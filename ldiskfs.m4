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
dnl
dnl $1: number of INDENT
dnl $2: index of FIELD
dnl $3: name of FIELD
dnl $4: type of FIELD
dnl $5: type OPTION
dnl $6: type_instance OPTION
dnl $7: tsdb_tags OPTION besides device_name
dnl $8: is first child of parent definition
define(`LDISKFS_MB_STATS_FIELD',
`FIELD($1, $2, $3, $4, ${key:hostname}, ldiskfs, ldiskfs-${subpath:device_name}, $5, $6, ldiskfs_mb_stats, device_name=${subpath:device_name} $7, $8)')dnl
dnl
dnl reqs, success and groups_scanned at the beginning
define(`LDISKFS_MB_STATS_START_PATTERN',
`^[[:blank:]]reqs: +([[:digit:]]+)
[[:blank:]]success: +([[:digit:]]+)
[[:blank:]]groups_scanned: +([[:digit:]]+)')dnl
dnl
dnl $1: number of INDENT
dnl $2: index of the first FIELD
define(`LDISKFS_MB_STATS_START_FIELDS',
`LDISKFS_MB_STATS_FIELD($1, $2, reqs, number, derive, reqs, optype=reqs, 0)
LDISKFS_MB_STATS_FIELD($1, eval($2 + 1), success, number, derive, success, optype=success, 0)
LDISKFS_MB_STATS_FIELD($1, eval($2 + 2), groups_scanned, number, derive, groups_scanned, optype=groups_scanned, 0)')dnl
dnl
dnl One crX_stats section, the section name is captured as the cr tag
dnl $1...$5: names of counters in the section, the last two are optional
define(`LDISKFS_MB_STATS_CR_PATTERN',
`[[:blank:]]([[:alnum:]_]+)_stats:
[[:blank:]]{2}$1: +([[:digit:]]+)
[[:blank:]]{2}$2: +([[:digit:]]+)
[[:blank:]]{2}$3: +([[:digit:]]+)`'dnl
ifelse(`$4', `', `', `
[[:blank:]]{2}$4: +([[:digit:]]+)')`'dnl
ifelse(`$5', `', `', `
[[:blank:]]{2}$5: +([[:digit:]]+)')')dnl
dnl
dnl $1: number of INDENT
dnl $2: index of the first FIELD
dnl $3: number of the section
dnl $4...$8: names of counters in the section, the last two are optional
define(`LDISKFS_MB_STATS_CR_FIELDS',
`LDISKFS_MB_STATS_FIELD($1, $2, cr$3, string, gauge, cr$3, , 0)
LDISKFS_MB_STATS_FIELD($1, eval($2 + 1), cr$3_$4, number, derive, ${content:cr$3}_$4, cr=${content:cr$3} optype=$4, 0)
LDISKFS_MB_STATS_FIELD($1, eval($2 + 2), cr$3_$5, number, derive, ${content:cr$3}_$5, cr=${content:cr$3} optype=$5, 0)
LDISKFS_MB_STATS_FIELD($1, eval($2 + 3), cr$3_$6, number, derive, ${content:cr$3}_$6, cr=${content:cr$3} optype=$6, 0)`'dnl
ifelse(`$7', `', `', `
LDISKFS_MB_STATS_FIELD($1, eval($2 + 4), cr$3_$7, number, derive, ${content:cr$3}_$7, cr=${content:cr$3} optype=$7, 0)')`'dnl
ifelse(`$8', `', `', `
LDISKFS_MB_STATS_FIELD($1, eval($2 + 5), cr$3_$8, number, derive, ${content:cr$3}_$8, cr=${content:cr$3} optype=$8, 0)')')dnl
dnl
dnl extents_scanned and the counters under it
dnl $1...$5: names of counters in regex, the last one is optional
define(`LDISKFS_MB_STATS_EXTENT_PATTERN',
`[[:blank:]]extents_scanned: +([[:digit:]]+)
[[:blank:]]{2}$1: +([[:digit:]]+)
[[:blank:]]{2}$2: +([[:digit:]]+)
[[:blank:]]{2}$3: +([[:digit:]]+)
[[:blank:]]{2}$4: +([[:digit:]]+)`'dnl
ifelse(`$5', `', `', `
[[:blank:]]{2}$5: +([[:digit:]]+)')')dnl
dnl
dnl $1: number of INDENT
dnl $2: index of the first FIELD
dnl $3...$7: names of counters, the last one is optional
define(`LDISKFS_MB_STATS_EXTENT_FIELDS',
`LDISKFS_MB_STATS_FIELD($1, $2, extents_scanned, number, derive, extents_scanned, optype=extents_scanned, 0)
LDISKFS_MB_STATS_FIELD($1, eval($2 + 1), $3, number, derive, $3, optype=$3, 0)
LDISKFS_MB_STATS_FIELD($1, eval($2 + 2), $4, number, derive, $4, optype=$4, 0)
LDISKFS_MB_STATS_FIELD($1, eval($2 + 3), $5, number, derive, $5, optype=$5, 0)
LDISKFS_MB_STATS_FIELD($1, eval($2 + 4), $6, number, derive, $6, optype=$6, 0)`'dnl
ifelse(`$7', `', `', `
LDISKFS_MB_STATS_FIELD($1, eval($2 + 5), $7, number, derive, $7, optype=$7, 0)')')dnl
dnl
dnl buddies_generated, buddies_time_used, preallocated and discarded at the end
define(`LDISKFS_MB_STATS_END_PATTERN',
`[[:blank:]]buddies_generated: +([[:digit:]]+)/([[:digit:]]+)
[[:blank:]]buddies_time_used: +([[:digit:]]+)
[[:blank:]]preallocated: +([[:digit:]]+)
[[:blank:]]discarded: +([[:digit:]]+)$')dnl
dnl
dnl $1: number of INDENT
dnl $2: index of the first FIELD
define(`LDISKFS_MB_STATS_END_FIELDS',
`LDISKFS_MB_STATS_FIELD($1, $2, buddies_generated, number, derive, buddies_generated, optype=buddies_generated, 0)
LDISKFS_MB_STATS_FIELD($1, eval($2 + 1), groups, number, gauge, groups, optype=groups, 0)
LDISKFS_MB_STATS_FIELD($1, eval($2 + 2), buddies_time_used, number, derive, buddies_time_used, optype=buddies_time_used, 0)
LDISKFS_MB_STATS_FIELD($1, eval($2 + 3), preallocated, number, derive, preallocated, optype=preallocated, 0)
LDISKFS_MB_STATS_FIELD($1, eval($2 + 4), discarded, number, derive, discarded, optype=discarded, 0)')dnl
dnl
dnl $1: number of INDENT
dnl $2: is first child of parent definition
dnl $3: suffix of item name
dnl $4: regex
dnl $5: fields of the groups in the regex
define(`LDISKFS_MB_STATS',
	`ELEMENT($1, entry,
	`SUBPATH($1 + 1, constant, mb_stats, 1)
MODE($1 + 1, file, 0)
ELEMENT($1 + 1, item,
	`NAME($1 + 2, ldiskfs_mb_stats_$3, 1)
PATTERN($1 + 2, `$4', 0)
$5', 0)', $2)')dnl
dnl
dnl mb_stats with cr0~cr3 and skipped_loops (e.g. exa6 on RockyLinux8.10)
define(`LDISKFS_MB_STATS_V1',
`LDISKFS_MB_STATS($1, $2, v1,
`LDISKFS_MB_STATS_START_PATTERN
LDISKFS_MB_STATS_CR_PATTERN(hits, groups_considered, useless_loops, bad_suggestions, skipped_loops)
LDISKFS_MB_STATS_CR_PATTERN(hits, groups_considered, useless_loops, bad_suggestions, skipped_loops)
LDISKFS_MB_STATS_CR_PATTERN(hits, groups_considered, useless_loops, skipped_loops)
LDISKFS_MB_STATS_CR_PATTERN(hits, groups_considered, useless_loops)
LDISKFS_MB_STATS_EXTENT_PATTERN(goal_hits, 2\^n_hits, breaks, lost)
LDISKFS_MB_STATS_END_PATTERN',
`LDISKFS_MB_STATS_START_FIELDS($1 + 2, 1)
LDISKFS_MB_STATS_CR_FIELDS($1 + 2, 4, 1, hits, groups_considered, useless_loops, bad_suggestions, skipped_loops)
LDISKFS_MB_STATS_CR_FIELDS($1 + 2, 10, 2, hits, groups_considered, useless_loops, bad_suggestions, skipped_loops)
LDISKFS_MB_STATS_CR_FIELDS($1 + 2, 16, 3, hits, groups_considered, useless_loops, skipped_loops)
LDISKFS_MB_STATS_CR_FIELDS($1 + 2, 21, 4, hits, groups_considered, useless_loops)
LDISKFS_MB_STATS_EXTENT_FIELDS($1 + 2, 25, goal_hits, pow2_hits, breaks, lost)
LDISKFS_MB_STATS_END_FIELDS($1 + 2, 30)')')dnl
dnl
dnl mb_stats with cr0~cr3 without skipped_loops (e.g. exa7 on RockyLinux9.7)
define(`LDISKFS_MB_STATS_V2',
`LDISKFS_MB_STATS($1, $2, v2,
`LDISKFS_MB_STATS_START_PATTERN
LDISKFS_MB_STATS_CR_PATTERN(hits, groups_considered, useless_loops, bad_suggestions)
LDISKFS_MB_STATS_CR_PATTERN(hits, groups_considered, useless_loops, bad_suggestions)
LDISKFS_MB_STATS_CR_PATTERN(hits, groups_considered, useless_loops)
LDISKFS_MB_STATS_CR_PATTERN(hits, groups_considered, useless_loops)
LDISKFS_MB_STATS_EXTENT_PATTERN(goal_hits, 2\^n_hits, breaks, lost)
LDISKFS_MB_STATS_END_PATTERN',
`LDISKFS_MB_STATS_START_FIELDS($1 + 2, 1)
LDISKFS_MB_STATS_CR_FIELDS($1 + 2, 4, 1, hits, groups_considered, useless_loops, bad_suggestions)
LDISKFS_MB_STATS_CR_FIELDS($1 + 2, 9, 2, hits, groups_considered, useless_loops, bad_suggestions)
LDISKFS_MB_STATS_CR_FIELDS($1 + 2, 14, 3, hits, groups_considered, useless_loops)
LDISKFS_MB_STATS_CR_FIELDS($1 + 2, 18, 4, hits, groups_considered, useless_loops)
LDISKFS_MB_STATS_EXTENT_FIELDS($1 + 2, 22, goal_hits, pow2_hits, breaks, lost)
LDISKFS_MB_STATS_END_FIELDS($1 + 2, 27)')')dnl
dnl
dnl mb_stats with cr_p2_aligned, cr_goal_fast, ... (e.g. v2.17.57 on RockyLinux10.1)
define(`LDISKFS_MB_STATS_V3',
`LDISKFS_MB_STATS($1, $2, v3,
`LDISKFS_MB_STATS_START_PATTERN
LDISKFS_MB_STATS_CR_PATTERN(hits, groups_considered, extents_scanned, useless_loops, bad_suggestions)
LDISKFS_MB_STATS_CR_PATTERN(hits, groups_considered, extents_scanned, useless_loops, bad_suggestions)
LDISKFS_MB_STATS_CR_PATTERN(hits, groups_considered, extents_scanned, useless_loops, bad_suggestions)
LDISKFS_MB_STATS_CR_PATTERN(hits, groups_considered, extents_scanned, useless_loops)
LDISKFS_MB_STATS_CR_PATTERN(hits, groups_considered, extents_scanned, useless_loops)
LDISKFS_MB_STATS_EXTENT_PATTERN(goal_hits, len_goal_hits, 2\^n_hits, breaks, lost)
LDISKFS_MB_STATS_END_PATTERN',
`LDISKFS_MB_STATS_START_FIELDS($1 + 2, 1)
LDISKFS_MB_STATS_CR_FIELDS($1 + 2, 4, 1, hits, groups_considered, extents_scanned, useless_loops, bad_suggestions)
LDISKFS_MB_STATS_CR_FIELDS($1 + 2, 10, 2, hits, groups_considered, extents_scanned, useless_loops, bad_suggestions)
LDISKFS_MB_STATS_CR_FIELDS($1 + 2, 16, 3, hits, groups_considered, extents_scanned, useless_loops, bad_suggestions)
LDISKFS_MB_STATS_CR_FIELDS($1 + 2, 22, 4, hits, groups_considered, extents_scanned, useless_loops)
LDISKFS_MB_STATS_CR_FIELDS($1 + 2, 27, 5, hits, groups_considered, extents_scanned, useless_loops)
LDISKFS_MB_STATS_EXTENT_FIELDS($1 + 2, 32, goal_hits, len_goal_hits, pow2_hits, breaks, lost)
LDISKFS_MB_STATS_END_FIELDS($1 + 2, 38)')')dnl
