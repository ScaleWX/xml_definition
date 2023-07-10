#!/usr/bin/env python
import argparse
import xml.etree.ElementTree as ET
from enum import Enum
import os


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
        self,
        index,
        name,
        plugin_instance,
        collection_type,
        type_instance,
        tsdb_name,
        tsdb_tags,
    ):
        self.index = index
        self.name = name
        self.plugin_instance = plugin_instance
        self.collection_type = collection_type
        self.type_instance = type_instance
        self.tsdb_name = tsdb_name
        self.tsdb_tags = tsdb_tags


class PluginInstance:
    def __init__(self, name, type_instance, item_name, field_name, tsdb_name):
        self.name = name
        self.type_instance = type_instance
        self.item_name = item_name
        self.field_name = field_name
        self.tsdb_name = tsdb_name


PLUGIN_INSTANCE_COLUMN_NAME = "Plugin Instance"
TYPE_INSTANCE_COLUMN_NAME = "Type Instance"
ITEM_NAME_COLUMN_NAME = "Item Name"
FIELD_NAME_COLUMN_NAME = "Field Name"
TSDB_NAME_COLUMN_NAME = "TSDB Name"

FILEDATA_TAG = '<Plugin "filedata">'
FILEDATA_END_TAG = "</Plugin>"
COMMON_TAG = "<Common>"
COMMON_END_TAG = "</Common>"
DEFINITION_FILE = "DefinitionFile"
ITEM_TAG = "<Item>"
ITEM_END_TAG = "</Item>"
TYPE_ATTR = "Type"


class WidthIndex(Enum):
    PLUGIN_INSTANCE = 0
    TYPE_INSTANCE = 1
    ITEM_NAME = 2
    FIELD_NAME = 3
    TSDB_NAME = 4


def parse_field(field):
    index = field.find("index").text
    field_name = field.find("./name").text
    for option in field.findall("option"):
        name = option.find("name").text
        if name == "plugin_instance":
            plugin_instance = option.find("string").text
        elif name == "type":
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
        index,
        field_name,
        plugin_instance,
        collection_type,
        type_instance,
        tsdb_name,
        tsdb_tags,
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
    full_path = os.path.join(parent_path, subpath.find("path").text)
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


def print_item_name(item):
    print("Item Name   : ", item.name)


def print_item(item):
    print_item_name(item)
    print("Item Pattern: ", item.pattern)
    print("Item Path   : ", item.path)


def print_main_field(field):
    print("    Field Name     : ", field.name)
    print("    Plugin Instance: ", field.plugin_instance)
    print("    Type Instance  : ", field.type_instance)
    print("    TSDB Name      : ", field.tsdb_name)


def print_field(field):
    print("    Index          : ", field.index)
    print_main_field(field)
    print("    Type           : ", field.collection_type)
    print("    TSDB Tags      : ", field.tsdb_tags)


def show_all_items(definition, verbose):
    for item in definition.items:
        if verbose == "yes":
            print_item(item)
        else:
            print_item_name(item)
        for field in item.fields:
            print("    ->")
            if verbose == "yes":
                print_field(field)
            else:
                print_main_field(field)


def show_item(definition, requested_item, verbose):
    for item in definition.items:
        if item.name == requested_item:
            if verbose == "yes":
                print_item(item)
            else:
                print_item_name(item)
            for field in item.fields:
                print("    ->")
                if verbose == "yes":
                    print_field(field)
                else:
                    print_main_field(field)


def generate_config(definition, abspath, indent):
    indentation = ""
    for _ in range(int(indent)):
        indentation += " "
    print(FILEDATA_TAG)
    print(f"{indentation}{COMMON_TAG}")
    print(f'{indentation}{indentation}{DEFINITION_FILE} "{abspath}"')
    print(f"{indentation}{COMMON_END_TAG}")
    for item in definition.items:
        print(f"{indentation}{ITEM_TAG}")
        print(f'{indentation}{indentation}Type "{item.name}"')
        print(f"{indentation}{ITEM_END_TAG}")
    print(FILEDATA_END_TAG)


def is_max(current, previous):
    if current > previous:
        return True
    else:
        return False


def set_widths(
    widths, plugin_instance, type_instance, item_name, field_name, tsdb_name
):
    if is_max(len(plugin_instance), widths[WidthIndex.PLUGIN_INSTANCE.value]):
        widths[WidthIndex.PLUGIN_INSTANCE.value] = len(plugin_instance)
    if is_max(len(type_instance), widths[WidthIndex.TYPE_INSTANCE.value]):
        widths[WidthIndex.TYPE_INSTANCE.value] = len(type_instance)
    if is_max(len(item_name), widths[WidthIndex.ITEM_NAME.value]):
        widths[WidthIndex.ITEM_NAME.value] = len(item_name)
    if is_max(len(field_name), widths[WidthIndex.FIELD_NAME.value]):
        widths[WidthIndex.FIELD_NAME.value] = len(field_name)
    if is_max(len(tsdb_name), widths[WidthIndex.TSDB_NAME.value]):
        widths[WidthIndex.TSDB_NAME.value] = len(tsdb_name)


def get_plugin_instances(definition, target="all"):
    plugin_instance_dict = {}
    for item in definition.items:
        for field in item.fields:
            if target != "all" and target != field.plugin_instance:
                continue
            if field.plugin_instance not in plugin_instance_dict:
                plugin_instances = []
                plugin_instances.append(
                    PluginInstance(
                        field.plugin_instance,
                        field.type_instance,
                        item.name,
                        field.name,
                        field.tsdb_name,
                    )
                )
                plugin_instance_dict[field.plugin_instance] = plugin_instances
            else:
                plugin_instances = plugin_instance_dict[field.plugin_instance]
                plugin_instances.append(
                    PluginInstance(
                        field.plugin_instance,
                        field.type_instance,
                        item.name,
                        field.name,
                        field.tsdb_name,
                    )
                )
                plugin_instance_dict[field.plugin_instance] = plugin_instances
    return plugin_instance_dict


def infill(number):
    str = ""
    for _ in range(number + 2):
        str += " "
    print(str, end="")


def print_line(
    widths, plugin_instance, type_instance, item_name, field_name, tsdb_name
):
    print(plugin_instance, end="")
    infill(widths[WidthIndex.PLUGIN_INSTANCE.value] - len(plugin_instance))
    print(type_instance, end="")
    infill(widths[WidthIndex.TYPE_INSTANCE.value] - len(type_instance))
    print(item_name, end="")
    infill(widths[WidthIndex.ITEM_NAME.value] - len(item_name))
    print(field_name, end="")
    infill(widths[WidthIndex.FIELD_NAME.value] - len(field_name))
    print(tsdb_name)


def show_plugin_instances(plugin_instances, widths):
    print_line(
        widths,
        PLUGIN_INSTANCE_COLUMN_NAME,
        TYPE_INSTANCE_COLUMN_NAME,
        ITEM_NAME_COLUMN_NAME,
        FIELD_NAME_COLUMN_NAME,
        TSDB_NAME_COLUMN_NAME,
    )
    for plugin_instance_name in list(plugin_instances):
        for element in plugin_instances[plugin_instance_name]:
            print_line(
                widths,
                plugin_instance_name,
                element.type_instance,
                element.item_name,
                element.field_name,
                element.tsdb_name,
            )


def get_max_widths(plugin_instances):
    widths = [0, 0, 0, 0, 0]
    widths[WidthIndex.PLUGIN_INSTANCE.value] = len(PLUGIN_INSTANCE_COLUMN_NAME)
    widths[WidthIndex.TYPE_INSTANCE.value] = len(TYPE_INSTANCE_COLUMN_NAME)
    widths[WidthIndex.ITEM_NAME.value] = len(ITEM_NAME_COLUMN_NAME)
    widths[WidthIndex.FIELD_NAME.value] = len(FIELD_NAME_COLUMN_NAME)
    widths[WidthIndex.TSDB_NAME.value] = len(TSDB_NAME_COLUMN_NAME)
    for plugin_instance_name in list(plugin_instances):
        for element in plugin_instances[plugin_instance_name]:
            set_widths(
                widths,
                plugin_instance_name,
                element.type_instance,
                element.item_name,
                element.field_name,
                element.tsdb_name,
            )
    return widths


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
        default="none",
        help="Specify the item to be shown",
    )
    parser.add_argument(
        "--check",
        "-c",
        default="no",
        help="Specify yes to Check type instance duplication",
    )
    parser.add_argument(
        "--verbose",
        "-v",
        default="no",
        help="Specify yes to show the detailed information on the item(s)",
    )
    parser.add_argument(
        "--plugin",
        "-p",
        default="all",
        help="Specify the plugin instance definition to be shown",
    )
    parser.add_argument(
        "--generate",
        "-g",
        default="no",
        help="Generate configuration file for collectd",
    )
    parser.add_argument(
        "--indent",
        "-d",
        default="4",
        help="Specify the indent used for config generated",
    )
    args = parser.parse_args()
    definition_xml = ET.parse(args.definition_file).getroot()
    definition = Definition()
    parse_definition(definition_xml, definition)
    if args.check == "yes":
        check_type_instance_duplication(definition)
    elif args.generate == "yes":
        abspath = os.path.abspath(args.definition_file)
        generate_config(definition, abspath, args.indent)
    elif args.item != "none":
        if args.item == "all":
            show_all_items(definition, args.verbose)
        else:
            show_item(definition, args.item, args.verbose)
    else:
        if args.plugin == "all":
            plugin_instances = get_plugin_instances(definition)
            widths = get_max_widths(plugin_instances)
            show_plugin_instances(plugin_instances, widths)
        else:
            plugin_instances = get_plugin_instances(definition, args.plugin)
            if len(plugin_instances) == 0:
                print("Plugin Instance: ", args.plugin, "not found")
            else:
                widths = get_max_widths(plugin_instances)
                show_plugin_instances(plugin_instances, widths)


if __name__ == "__main__":
    main()
