#!/usr/bin/env python
import argparse
import xml.etree.ElementTree as ET
from os import path


class Definition:
    def __init__(self, items=[]):
        self.items = items


class Item:
    def __init__(self, name, pattern, path, fields):
        self.name = name
        self.pattern = pattern
        self.path = path
        self.fields = fields


class Field:
    def __init__(
        self, index, name, collection_type, type_instance, tsdb_name, tsdb_tags
    ):
        self.index = index
        self.name = name
        self.collection_type = collection_type
        self.type_instance = type_instance
        self.tsdb_name = tsdb_name
        self.tsdb_tags = tsdb_tags


def parse_field(field):
    index = field.find("index").text
    field_name = field.find("./name").text
    for option in field.findall("option"):
        name = option.find("name").text
        if name == "type":
            collection_type = option.find("string").text
        elif name == "type_instance":
            type_instance = option.find("string").text
        elif name == "tsdb_name":
            tsdb_name = option.find("string").text
        elif name == "tsdb_tags":
            tsdb_tags = option.find("string").text
        else:
            continue
    return Field(
        index, field_name, collection_type, type_instance, tsdb_name, tsdb_tags
    )


def parse_item(item, path):
    name = item.find("name").text
    pattern = item.find("pattern").text
    fields = []
    for field in item.findall("field"):
        fields.append(parse_field(field))
    return Item(name, pattern, path, fields)


def parse_entry(entry, parent_path, definition):
    subpath = entry.find("subpath")
    full_path = path.join(parent_path, subpath.find("path").text)
    mode = entry.find("mode").text
    if mode == "directory":
        for child in entry.findall("entry"):
            parse_entry(child, full_path, definition)
    elif mode == "file":
        for item in entry.findall("item"):
            definition.items.append(parse_item(item, full_path))
    else:
        print("ERROR: mode tag text should be directory or file")


def parse_definition(definition_xml, definition):
    for entry in definition_xml.findall("entry"):
        parse_entry(entry, "", definition)


def print_item(item):
    print("Item Name   : ", item.name)
    print("Item Pattern: ", item.pattern)
    print("Item Path   : ", item.path)


def print_field(field):
    print("    Index        : ", field.index)
    print("    Name         : ", field.name)
    print("    Type         : ", field.collection_type)
    print("    Type Instance: ", field.type_instance)
    print("    TSDB Name    : ", field.tsdb_name)
    print("    TSDB Tags    : ", field.tsdb_tags)


def show_all_items(definition):
    for item in definition.items:
        print_item(item)
        for field in item.fields:
            print_field(field)


def show_item(definition, requested_item):
    for item in definition.items:
        if item.name == requested_item:
            print_item(item)
            for field in item.fields:
                print_field(field)


def check_type_instance_duplication(definition):
    type_instances = {}
    duplication = {}
    for item in definition.items:
        for field in item.fields:
            if field.type_instance not in type_instances:
                type_instances[field.type_instance] = (
                    "Index: " + field.index + " Name: " + field.name
                )
            else:
                if field.type_instance not in duplication:
                    duplication[field.type_instance] = (
                        item.name
                        + "->"
                        + type_instances[field.type_instance]
                        + "\n"
                        + item.name
                        + "->Index: "
                        + field.index
                        + " Name: "
                        + field.name
                    )
                else:
                    duplication[field.type_instance] = (
                        duplication[field.type_instance]
                        + "\n"
                        + item.name
                        + "->Index: "
                        + field.index
                        + " Name: "
                        + field.name
                    )
    if len(duplication) != 0:
        for type_instance in list(duplication):
            print("----------------------------------------------------------")
            print(f'Type Instance "{type_instance}" is redundantly defined in;')
            print("----------------------------------------------------------")
            print(f"{duplication[type_instance]}")


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--definition_file",
        "-f",
        default="/etc/lustre.xml",
        help="Specify the Lustre XML Definition file for collectd to be parsed",
    )
    parser.add_argument(
        "--item",
        "-i",
        default="all",
        help="Specify the item to be shown",
    )
    parser.add_argument(
        "--check",
        "-c",
        default="no",
        help="Specify yes to Check type instance duplication",
    )
    args = parser.parse_args()
    definition_xml = ET.parse(args.definition_file).getroot()
    definition = Definition()
    parse_definition(definition_xml, definition)
    if args.check == "yes":
        check_type_instance_duplication(definition)
    else:
        if args.item == "all":
            show_all_items(definition)
        else:
            show_item(definition, args.item)


if __name__ == "__main__":
    main()
