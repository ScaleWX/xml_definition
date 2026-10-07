include(`ldiskfs.m4')dnl
dnl
dnl ldiskfs stats depend on the kernel and ldiskfs patch series rather than
dnl the Lustre release, so they live in their own definition.
dnl
HEADER(ldiskfs-0.1, 2026, `DataDirect Networks, Inc.', `Xiao Yang <xyang at ddn.com>')
<definition>
	<version>0.1</version>
	<entry>
		<subpath>
			<subpath_type>constant</subpath_type>
			<path>/proc/fs/ldiskfs</path>
		</subpath>
		<mode>directory</mode>
		<entry>
			<subpath>
				<subpath_type>regular_expression</subpath_type>
				<path>(^.+$)</path>
					<subpath_field>
						<index>1</index>
						<name>device_name</name>
					</subpath_field>
			</subpath>
			<mode>directory</mode>
			LDISKFS_MB_STATS_V1(3, 1)
			LDISKFS_MB_STATS_V2(3, 1)
			LDISKFS_MB_STATS_V3(3, 1)
		</entry>
	</entry>
	<entry>
		<subpath>
			<subpath_type>constant</subpath_type>
			<path>/sys/fs/ldiskfs</path>
		</subpath>
		<mode>directory</mode>
		<entry>
			<subpath>
				<subpath_type>regular_expression</subpath_type>
				<path>(^.+$)</path>
					<subpath_field>
						<index>1</index>
						<name>device_name</name>
					</subpath_field>
			</subpath>
			<mode>directory</mode>
			LDISKFS_INFO_ENTRY(3, lifetime_write_kbytes, (.+), number, ${key:hostname}, ${subpath:device_name}, derive, 1)
		</entry>
	</entry>
</definition>
