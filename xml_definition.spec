%define filedatadir /filedata

Name:		filedata_definition
Version:	3.0.6
Release:	1
Summary:	XML definition files
Group:		Applications/ScaleWX
License:	Share
Packager:	Katsuhiko Ono <kono@ddn.com>
Vendor:		ScaleWX
URL:		https://github.com/ScaleWX/xml_definition
Source0:	filedata_definition.tar.xz
BuildArch:	noarch
BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}-root

%description
This package includes XML definition files for system information collection daemon.

%prep
%setup -c

%install
rm -rf %{buildroot}
mkdir -p %{buildroot}%{_sysconfdir}%{filedatadir}
%{__install} -Dp -m0644 ime-1.1.xml %{buildroot}%{_sysconfdir}%{filedatadir}
%{__install} -Dp -m0644 ime-1.2.xml %{buildroot}%{_sysconfdir}%{filedatadir}
%{__install} -Dp -m0644 infiniband-0.1.xml %{buildroot}%{_sysconfdir}%{filedatadir}/infiniband-0.1_definition.xml
%{__install} -Dp -m0644 infiniband-1.0.xml %{buildroot}%{_sysconfdir}%{filedatadir}/infiniband-1.0_definition.xml
%{__install} -Dp -m0644 lustre-1.8.9.xml %{buildroot}%{_sysconfdir}%{filedatadir}/lustre-1.8_definition.xml
%{__install} -Dp -m0644 lustre-2.1.6.xml %{buildroot}%{_sysconfdir}%{filedatadir}/lustre-2.1_definition.xml
%{__install} -Dp -m0644 lustre-2.12.xml %{buildroot}%{_sysconfdir}%{filedatadir}/lustre-2.12.xml
%{__install} -Dp -m0644 lustre-2.13.xml %{buildroot}%{_sysconfdir}%{filedatadir}/lustre-2.13.xml
%{__install} -Dp -m0644 lustre-2.4.2.xml %{buildroot}%{_sysconfdir}%{filedatadir}/lustre-2.4_definition.xml
%{__install} -Dp -m0644 lustre-2.5.xml %{buildroot}%{_sysconfdir}%{filedatadir}/lustre-2.5_definition.xml
%{__install} -Dp -m0644 lustre-b_es5_1.xml %{buildroot}%{_sysconfdir}%{filedatadir}/lustre-b_es5_1.xml
%{__install} -Dp -m0644 lustre-b_es5_2.xml %{buildroot}%{_sysconfdir}%{filedatadir}/lustre-b_es5_2.xml
%{__install} -Dp -m0644 lustre-b_es6_0.xml %{buildroot}%{_sysconfdir}%{filedatadir}/lustre-b_es6_0.xml
%{__install} -Dp -m0644 lustre-es4-2.10.xml %{buildroot}%{_sysconfdir}%{filedatadir}/lustre-es4-2.10.xml
%{__install} -Dp -m0644 lustre-ieel-2.5.xml %{buildroot}%{_sysconfdir}%{filedatadir}/lustre-ieel-2.5_definition.xml
%{__install} -Dp -m0644 lustre-ieel-2.7.xml %{buildroot}%{_sysconfdir}%{filedatadir}/lustre-ieel-2.7_definition.xml
%{__install} -Dp -m0644 sfa-11.0.xml %{buildroot}%{_sysconfdir}%{filedatadir}/sfa-11.0_definition.xml
%{__install} -Dp -m0644 sfa-11.6.xml %{buildroot}%{_sysconfdir}%{filedatadir}/sfa-11.6_definition.xml
%{__install} -Dp -m0644 sfa-3.0.xml %{buildroot}%{_sysconfdir}%{filedatadir}/sfa-3.0_definition.xml
%{__install} -Dp -m0644 Field_List-b_es5_2.txt %{buildroot}%{_sysconfdir}%{filedatadir}/Field_List-b_es5_2.txt
%{__install} -Dp -m0644 Field_List-b_es6_0.txt %{buildroot}%{_sysconfdir}%{filedatadir}/Field_List-b_es6_0.txt

%clean

%post

%preun

%postun

%files
%defattr(-,root,root,-)
%{_sysconfdir}%{filedatadir}/ime-1.1.xml
%{_sysconfdir}%{filedatadir}/ime-1.2.xml
%{_sysconfdir}%{filedatadir}/infiniband-0.1_definition.xml
%{_sysconfdir}%{filedatadir}/infiniband-1.0_definition.xml
%{_sysconfdir}%{filedatadir}/lustre-1.8_definition.xml
%{_sysconfdir}%{filedatadir}/lustre-2.12.xml
%{_sysconfdir}%{filedatadir}/lustre-2.13.xml
%{_sysconfdir}%{filedatadir}/lustre-2.1_definition.xml
%{_sysconfdir}%{filedatadir}/lustre-2.4_definition.xml
%{_sysconfdir}%{filedatadir}/lustre-2.5_definition.xml
%{_sysconfdir}%{filedatadir}/lustre-b_es5_1.xml
%{_sysconfdir}%{filedatadir}/lustre-b_es5_2.xml
%{_sysconfdir}%{filedatadir}/lustre-b_es6_0.xml
%{_sysconfdir}%{filedatadir}/lustre-es4-2.10.xml
%{_sysconfdir}%{filedatadir}/lustre-ieel-2.5_definition.xml
%{_sysconfdir}%{filedatadir}/lustre-ieel-2.7_definition.xml
%{_sysconfdir}%{filedatadir}/sfa-11.0_definition.xml
%{_sysconfdir}%{filedatadir}/sfa-11.6_definition.xml
%{_sysconfdir}%{filedatadir}/sfa-3.0_definition.xml
%{_sysconfdir}%{filedatadir}/Field_List-b_es5_2.txt
%{_sysconfdir}%{filedatadir}/Field_List-b_es6_0.txt

%changelog
* Thu May 26 2022 Katsuhiko Ono <kono@ddn.com> - 1.0
- First package
- Include XML Definition files
