include(`sfa.m4')dnl
dnl
dnl definition of VD_QDEPTH
dnl $1: number of INDENT
dnl $2: kind, current or abs
dnl $3: context start string
dnl $4: context end string
dnl $5: data source type, gauge or derive
dnl $6: is first child of parent ELEMENT
define(`VD_QDEPTH',
        `ELEMENT($1, item,
        `NAME($1 + 1, vd_qdepth$2, 1)
CONTEXT_SUBTYPE($1 + 1, $3, $4, 0)
PATTERN($1 + 1, `^ +([[:digit:]]+) +([[:digit:]]+) +([[:digit:]]+) +([[:digit:]]+) +([[:digit:]]+) +([[:digit:]]+) +([[:digit:]]+) +([[:digit:]]+) +([[:digit:]]+) +([[:digit:]]+) +([[:digit:]]+) +([[:digit:]]+)', 0)
FIELD($1 + 1, 1, disk_index, string, ${extra_tag:extrahost}, vd_qdepth_${content:disk_index}, qdepth, $5, disk_index, vd_qdepth, qdepth=disk_index disk_index=${content:disk_index}, 0)
FIELD($1 + 1, 2, 1, number, ${extra_tag:extrahost}, vd_qdepth_${content:disk_index}, qdepth, $5, 1, vd_qdepth, qdepth=1 disk_index=${content:disk_index}, 0)
FIELD($1 + 1, 3, 2, number, ${extra_tag:extrahost}, vd_qdepth_${content:disk_index}, qdepth, $5, 2, vd_qdepth, qdepth=2 disk_index=${content:disk_index}, 0)
FIELD($1 + 1, 4, 3to4, number, ${extra_tag:extrahost}, vd_qdepth_${content:disk_index}, qdepth, $5, 3to4, vd_qdepth, qdepth=3to4 disk_index=${content:disk_index}, 0)
FIELD($1 + 1, 5, 5to8, number, ${extra_tag:extrahost}, vd_qdepth_${content:disk_index}, qdepth, $5, 5to8, vd_qdepth, qdepth=5to8 disk_index=${content:disk_index}, 0)
FIELD($1 + 1, 6, 9to16, number, ${extra_tag:extrahost}, vd_qdepth_${content:disk_index}, qdepth, $5, 9to16, vd_qdepth, qdepth=9to16 disk_index=${content:disk_index}, 0)
FIELD($1 + 1, 7, 17to32, number, ${extra_tag:extrahost}, vd_qdepth_${content:disk_index}, qdepth, $5, 17to32, vd_qdepth, qdepth=17to32 disk_index=${content:disk_index}, 0)
FIELD($1 + 1, 8, 33to64, number, ${extra_tag:extrahost}, vd_qdepth_${content:disk_index}, qdepth, $5, 33to64, vd_qdepth, qdepth=33to64 disk_index=${content:disk_index}, 0)
FIELD($1 + 1, 9, 65to128, number, ${extra_tag:extrahost}, vd_qdepth_${content:disk_index}, qdepth, $5, 65to128, vd_qdepth, qdepth=65to128 disk_index=${content:disk_index}, 0)
FIELD($1 + 1, 10, 129to256, number, ${extra_tag:extrahost}, vd_qdepth_${content:disk_index}, qdepth, $5, 129to256, vd_qdepth, qdepth=129to256 disk_index=${content:disk_index}, 0)
FIELD($1 + 1, 11, 257to512, number, ${extra_tag:extrahost}, vd_qdepth_${content:disk_index}, qdepth, $5, 257to512, vd_qdepth, qdepth=257to512 disk_index=${content:disk_index}, 0)
FIELD($1 + 1, 12, gt512, number, ${extra_tag:extrahost}, vd_qdepth_${content:disk_index}, qdepth, $5, gt512, vd_qdepth, qdepth=gt512 disk_index=${content:disk_index}, 0)', $6)')dnl
