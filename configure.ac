#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.71])
AC_INIT([FULL-PACKAGE-NAME], [VERSION], [BUG-REPORT-ADDRESS])
AM_INIT_AUTOMAKE([foreign])

AC_MSG_CHECKING([for xml_definition RPM])
XML_DEFINITION_REV=$(git rev-parse --short HEAD)
XML_DEFINITION_VERSION=$(grep Version xml_definition.spec | \
	awk '{print $2}')
XML_DEFINITION_RELEASE=$(grep Release xml_definition.spec | \
	awk '{print $2}'| sed -e "s/%{?rev}/${XML_DEFINITION_REV}/g")
XML_DEFINITION_RPM=xml_definition-${XML_DEFINITION_VERSION}-${XML_DEFINITION_RELEASE}.noarch.rpm
AC_MSG_RESULT([$XML_DEFINITION_RPM])
AC_SUBST(XML_DEFINITION_RPM)

AC_CONFIG_FILES([Makefile])
AC_OUTPUT
