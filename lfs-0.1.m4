include(`general.m4')dnl
HEADER(lfs-0.1, 2025, `DataDirect Networks, Inc.', `Katsuhiko Ono <kono at ddn.com>')
<definition>
        <version>0.1</version>
        <entry>
                <subpath>
                        <subpath_type>constant</subpath_type>
                        <path>df</path>
                </subpath>
                <mode>file</mode>
                <item>
                        <name>df-ost</name>
                        <pattern>(.+)-(OST[0-9a-fA-F]+)_UUID +([[:digit:]]+) +([[:digit:]]+) +([[:digit:]]+) +[[:digit:]]+% +.*\[.*\]</pattern>
                        FIELD(3, 1, fs_name, string, , , NA, gauge, NA, NA, NA, 1)
                        FIELD(3, 2, ost_index, string, , , NA, gauge, NA, NA, NA, 1)
                        FIELD(3, 3, 1k-blocks, number, ${key:hostname}, lfs-df, ${content:fs_name}-${content:ost_index}, gauge, 1k-blocks, lfs-df, optype=1k-blocks fs_name=${content:fs_name} ost_index=${content:ost_index}, 1)
                        FIELD(3, 4, used, number, ${key:hostname}, lfs-df, ${content:fs_name}-${content:ost_index}, gauge, used, lfs-df, optype=used fs_name=${content:fs_name} ost_index=${content:ost_index}, 1)
                        FIELD(3, 5, available, number, ${key:hostname}, lfs-df, ${content:fs_name}-${content:ost_index}, gauge, available, lfs-df, optype=available fs_name=${content:fs_name} ost_index=${content:ost_index}, 1)
                </item>
                <item>
                        <name>df-mdt</name>
                        <pattern>(.+)-(MDT[0-9a-fA-F]+)_UUID +([[:digit:]]+) +([[:digit:]]+) +([[:digit:]]+) +[[:digit:]]+% +.*\[.*\]</pattern>
                        FIELD(3, 1, fs_name, string, , , NA, gauge, NA, NA, NA, 1)
                        FIELD(3, 2, mdt_index, string, , , NA, gauge, NA, NA, NA, 1)
                        FIELD(3, 3, 1k-blocks, number, ${key:hostname}, lfs-df, ${content:fs_name}-${content:mdt_index}, gauge, 1k-blocks, lfs-df, optype=1k-blocks fs_name=${content:fs_name} mdt_index=${content:mdt_index}, 1)
                        FIELD(3, 4, used, number, ${key:hostname}, lfs-df, ${content:fs_name}-${content:mdt_index}, gauge, used, lfs-df, optype=used fs_name=${content:fs_name} mdt_index=${content:mdt_index}, 1)
                        FIELD(3, 5, available, number, ${key:hostname}, lfs-df, ${content:fs_name}-${content:mdt_index}, gauge, available, lfs-df, optype=available fs_name=${content:fs_name} mdt_index=${content:mdt_index}, 1)
                </item>
        </entry>
        <entry>
                <subpath>
                        <subpath_type>constant</subpath_type>
                        <path>df -i</path>
                </subpath>
                <mode>file</mode>
                <item>
                <name>df-inode-ost</name>
                        <pattern>(.+)-(OST[0-9a-fA-F]+)_UUID +([[:digit:]]+) +([[:digit:]]+) +([[:digit:]]+) +[[:digit:]]+% +.*\[.*\]</pattern>
                        FIELD(3, 1, fs_name, string, , , NA, gauge, NA, NA, NA, 1)
                        FIELD(3, 2, ost_index, string, , , NA, gauge, NA, NA, NA, 1)
                        FIELD(3, 3, inodes, number, ${key:hostname}, lfs-df-i, ${content:fs_name}-${content:ost_index}, gauge, inodes, lfs-df-i, optype=inodes fs_name=${content:fs_name} ost_index=${content:ost_index}, 1)
                        FIELD(3, 4, iused, number, ${key:hostname}, lfs-df-i, ${content:fs_name}-${content:ost_index}, gauge, iused, lfs-df-i, optype=iused fs_name=${content:fs_name} ost_index=${content:ost_index}, 1)
                        FIELD(3, 5, ifree, number, ${key:hostname}, lfs-df-i, ${content:fs_name}-${content:ost_index}, gauge, ifree, lfs-df-i, optype=ifree fs_name=${content:fs_name} ost_index=${content:ost_index}, 1)
                </item>
                <item>
                        <name>df-inode-mdt</name>
                        <pattern>(.+)-(MDT[0-9a-fA-F]+)_UUID +([[:digit:]]+) +([[:digit:]]+) +([[:digit:]]+) +[[:digit:]]+% +.*\[.*\]</pattern>
                        FIELD(3, 1, fs_name, string, , , NA, gauge, NA, NA, NA, 1)
                        FIELD(3, 2, mdt_index, string, , , NA, gauge, NA, NA, NA, 1)
                        FIELD(3, 3, inodes, number, ${key:hostname}, lfs-df-i, ${content:fs_name}-${content:mdt_index}, gauge, inodes, lfs-df-i, optype=inodes fs_name=${content:fs_name} mdt_index=${content:mdt_index}, 1)
                        FIELD(3, 4, iused, number, ${key:hostname}, lfs-df-i, ${content:fs_name}-${content:mdt_index}, gauge, iused, lfs-df-i, optype=iused fs_name=${content:fs_name} mdt_index=${content:mdt_index}, 1)
                        FIELD(3, 5, ifree, number, ${key:hostname}, lfs-df-i, ${content:fs_name}-${content:mdt_index}, gauge, ifree, lfs-df-i, optype=ifree fs_name=${content:fs_name} mdt_index=${content:mdt_index}, 1)
                </item>
        </entry>
        <entry>
                <subpath>
                        <subpath_type>constant</subpath_type>
                        <path>df --pool</path>
                </subpath>
                <mode>file</mode>
                <item>
                <name>df-pool-ost</name>
                        <pattern>(.+) +(.+)-(OST[0-9a-fA-F]+)_UUID +([[:digit:]]+) +([[:digit:]]+) +([[:digit:]]+) +[[:digit:]]+% +.*\[.*\]</pattern>
                        FIELD(3, 1, pool_name, string, , , NA, gauge, NA, NA, NA, 1)
                        FIELD(3, 2, fs_name, string, , , NA, gauge, NA, NA, NA, 1)
                        FIELD(3, 3, ost_index, string, , , NA, gauge, NA, NA, NA, 1)
                        FIELD(3, 4, 1k-blocks, number, ${key:hostname}, lfs-df-pool, ${content:fs_name}-${content:pool_name}-${content:ost_index}, gauge, 1k-blocks, lfs-df-pool, optype=1k-blocks fs_name=${content:fs_name} ost_index=${content:ost_index} pool_name=${content:pool_name}, 1)
                        FIELD(3, 5, used, number, ${key:hostname}, lfs-df-pool, ${content:fs_name}-${content:pool_name}-${content:ost_index}, gauge, used, lfs-df-pool, optype=used fs_name=${content:fs_name} ost_index=${content:ost_index} pool_name=${content:pool_name}, 1)
                        FIELD(3, 6, available, number, ${key:hostname}, lfs-df-pool, ${content:fs_name}-${content:pool_name}-${content:ost_index}, gauge, available, lfs-df-pool, optype=available fs_name=${content:fs_name} ost_index=${content:ost_index} pool_name=${content:pool_name}, 1)
                </item>
                <item>
                        <name>df-pool-mdt</name>
                        <pattern>(.+) +(.+)-(MDT[0-9a-fA-F]+)_UUID +([[:digit:]]+) +([[:digit:]]+) +([[:digit:]]+) +[[:digit:]]+% +.*\[.*\]</pattern>
                        FIELD(3, 1, pool_name, string, , , NA, gauge, NA, NA, NA, 1)
                        FIELD(3, 2, fs_name, string, , , NA, gauge, NA, NA, NA, 1)
                        FIELD(3, 3, mdt_index, string, , , NA, gauge, NA, NA, NA, 1)
                        FIELD(3, 4, 1k-blocks, number, ${key:hostname}, lfs-df-pool, ${content:fs_name}-${content:pool_name}-${content:mdt_index}, gauge, 1k-blocks, lfs-df-pool, optype=1k-blocks fs_name=${content:fs_name} mdt_index=${content:mdt_index} pool_name=${content:pool_name}, 1)
                        FIELD(3, 5, used, number, ${key:hostname}, lfs-df-pool, ${content:fs_name}-${content:pool_name}-${content:mdt_index}, gauge, used, lfs-df-pool, optype=used fs_name=${content:fs_name} mdt_index=${content:mdt_index} pool_name=${content:pool_name}, 1)
                        FIELD(3, 6, available, number, ${key:hostname}, lfs-df-pool, ${content:fs_name}-${content:pool_name}-${content:mdt_index}, gauge, available, lfs-df-pool, optype=available fs_name=${content:fs_name} mdt_index=${content:mdt_index} pool_name=${content:pool_name}, 1)
                </item>
        </entry>
        <entry>
                <subpath>
                        <subpath_type>constant</subpath_type>
                        <path>df -i --pool</path>
                </subpath>
                <mode>file</mode>
                <item>
                <name>df-inode-pool-ost</name>
                        <pattern>(.+) +(.+)-(OST[0-9a-fA-F]+)_UUID +([[:digit:]]+) +([[:digit:]]+) +([[:digit:]]+) +[[:digit:]]+% +.*\[.*\]</pattern>
                        FIELD(3, 1, pool_name, string, , , NA, gauge, NA, NA, NA, 1)
                        FIELD(3, 2, fs_name, string, , , NA, gauge, NA, NA, NA, 1)
                        FIELD(3, 3, ost_index, string, , , NA, gauge, NA, NA, NA, 1)
                        FIELD(3, 4, inodes, number, ${key:hostname}, lfs-df-i-pool, ${content:fs_name}-${content:pool_name}-${content:ost_index}, gauge, inodes, lfs-df-i-pool, optype=inodes fs_name=${content:fs_name} ost_index=${content:ost_index} pool_name=${content:pool_name}, 1)
                        FIELD(3, 5, iused, number, ${key:hostname}, lfs-df-i-pool, ${content:fs_name}-${content:pool_name}-${content:ost_index}, gauge, iused, lfs-df-i-pool, optype=iused fs_name=${content:fs_name} ost_index=${content:ost_index} pool_name=${content:pool_name}, 1)
                        FIELD(3, 6, ifree, number, ${key:hostname}, lfs-df-i-pool, ${content:fs_name}-${content:pool_name}-${content:ost_index}, gauge, ifree, lfs-df-i-pool, optype=ifree fs_name=${content:fs_name} ost_index=${content:ost_index} pool_name=${content:pool_name}, 1)
                </item>
                <item>
                        <name>df-inode-pool-mdt</name>
                        <pattern>(.+) +(.+)-(MDT[0-9a-fA-F]+)_UUID +([[:digit:]]+) +([[:digit:]]+) +([[:digit:]]+) +[[:digit:]]+% +.*\[.*\]</pattern>
                        FIELD(3, 1, pool_name, string, , , NA, gauge, NA, NA, NA, 1)
                        FIELD(3, 2, fs_name, string, , , NA, gauge, NA, NA, NA, 1)
                        FIELD(3, 3, mdt_index, string, , , NA, gauge, NA, NA, NA, 1)
                        FIELD(3, 4, inodes, number, ${key:hostname}, lfs-df-i-pool, ${content:fs_name}-${content:pool_name}-${content:mdt_index}, gauge, inodes, lfs-df-i-pool, optype=inodes fs_name=${content:fs_name} mdt_index=${content:mdt_index} pool_name=${content:pool_name}, 1)
                        FIELD(3, 5, iused, number, ${key:hostname}, lfs-df-i-pool, ${content:fs_name}-${content:pool_name}-${content:mdt_index}, gauge, iused, lfs-df-i-pool, optype=iused fs_name=${content:fs_name} mdt_index=${content:mdt_index} pool_name=${content:pool_name}, 1)
                        FIELD(3, 6, ifree, number, ${key:hostname}, lfs-df-i-pool, ${content:fs_name}-${content:pool_name}-${content:mdt_index}, gauge, ifree, lfs-df-i-pool, optype=ifree fs_name=${content:fs_name} mdt_index=${content:mdt_index} pool_name=${content:pool_name}, 1)
                </item>
        </entry>
</definition>
