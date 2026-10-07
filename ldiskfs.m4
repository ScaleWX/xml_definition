dnl
dnl The m4 file to automatically generate ldiskfs definition file
dnl
include(`general.m4')dnl
dnl
dnl $1: number of INDENT
dnl $2: name
dnl $3: pattern
dnl $4: type
dnl $5: hostname
dnl $6: device name
dnl $7: collection type
dnl $8: is first child of parent definition
define(`LDISKFS_INFO_ENTRY',
`CONSTANT_FILE_ENTRY($1, $2, $2, $3, $4, $5, ldiskfs, ldiskfs-$6, $7, $2, ldiskfs_info, device_name=$6 optype=$2, $8)')dnl
