SUBDIRS = .

BUILD_DIRS = BUILD BUILDROOT RPMS SOURCES SPECS SRPMS

M4_DESTINATION_FILES = exa-5.2.5.m4 \
	exa-5.2.6.m4 \
	exa-5.2.7.m4 \
	exa-6.2.0.m4 \
	ime-1.1.m4 \
	ime-1.2.m4 \
	infiniband-0.1.m4 \
	infiniband-1.1.m4 \
	lustre-1.8.9.m4 \
	lustre-2.1.6.m4 \
	lustre-2.4.2.m4 \
	lustre-2.5.m4 \
	lustre-ieel-2.5.m4 \
	lustre-ieel-2.7.m4 \
	lustre-es4-2.10.m4 \
	lustre-2.12.m4 \
	lustre-b_es5_1.m4 \
	lustre-b_es5_2.m4 \
	lustre-2.13.m4 \
	sfa-3.0.m4 \
	sfa-11.0.m4 \
	sfa-11.6.m4


M4_FILES = general.m4 lustre.m4 sfa.m4 $(M4_DESTINATION_FILES)

XML_DESTINATION_FILES=$(M4_DESTINATION_FILES:.m4=.xml)

noinst_DATA = $(BUILD_DIRS) $(M4_FILES) \
	xml_definition.spec

$(XML_DESTINATION_FILES): $(M4_DESTINATION_FILES)
	m4 $(@:.xml=.m4) > $@.tmp
	xmllint --valid --noout $@.tmp > /dev/null
	mv $@.tmp $@

rpm: $(BUILD_DIRS) $(XML_DESTINATION_FILES)
	tar Jcvf filedata_definition.tar.xz *.xml *.txt
	mv filedata_definition.tar.xz ./SOURCES
	rpmbuild -ba --define="rev ${shell git rev-parse --short HEAD}" --define="_topdir $(shell pwd)" xml_definition.spec

$(BUILD_DIRS):
	mkdir $@

clean:
	rm -rf $(XML_DESTINATION_FILES) $(BUILD_DIRS)
