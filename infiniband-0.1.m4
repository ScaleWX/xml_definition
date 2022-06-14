include(`general.m4')dnl
dnl
dnl $1: number of INDENT
dnl $2: path of entry, name of field use this value
dnl $3: item name
dnl $4: item pattern
dnl $5: field type
dnl $6: host OPTION
dnl $7: plugin OPTION
dnl $8: plugin_instance OPTION
dnl $9: type OPTION
dnl $10: type_instance OPTION
dnl $11: tsdb_name OPTION
dnl $12: tsdb_tags OPTION
dnl $13: is first child of parent ELEMENT
define(`CONSTANT_FILE_ENTRY',
	`ELEMENT($1, entry,
SUBPATH($1+1, constant, $2, 1)
MODE($1+1, file, 0)
ONE_FIELD_ITEM($1+1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, 0), $13)')dnl
dnl $1: number of INDENT
dnl $2: plugin OPTION
dnl $3: is first child of parent ELEMENT
define(`FILES_COUNTER_INFO_ENTRIES',
`CONSTANT_FILE_ENTRY($1, excessive_buffer_overrun_errors, excessive_buffer_overrun_errors, (.+), number, ${key:hostname}, $2, countersinfo, derive, excessive_buffer_overrun_errors, excessive_buffer_overrun_errors, driver_type=${subpath:driver_type} driver_index=${subpath:driver_index} port_number=${subpath:port_number}, 1)
CONSTANT_FILE_ENTRY($1, link_downed, link_downed, (.+), number, ${key:hostname}, $2, countersinfo, derive, link_downed, link_downed, driver_type=${subpath:driver_type} driver_index=${subpath:driver_index} port_number=${subpath:port_number}, 0)
CONSTANT_FILE_ENTRY($1, link_error_recovery, link_error_recovery, (.+), number, ${key:hostname}, $2, countersinfo, derive, link_error_recovery, link_error_recovery, driver_type=${subpath:driver_type} driver_index=${subpath:driver_index} port_number=${subpath:port_number}, 0)
CONSTANT_FILE_ENTRY($1, local_link_integrity_errors, local_link_integrity_errors, (.+), number, ${key:hostname}, $2, countersinfo, derive, local_link_integrity_errors, local_link_integrity_errors, driver_type=${subpath:driver_type} driver_index=${subpath:driver_index} port_number=${subpath:port_number}, 0)
CONSTANT_FILE_ENTRY($1, port_rcv_constraint_errors, port_rcv_constraint_errors, (.+), number, ${key:hostname}, $2, countersinfo, derive, port_rcv_constraint_errors, port_rcv_constraint_errors, driver_type=${subpath:driver_type} driver_index=${subpath:driver_index} port_number=${subpath:port_number}, 0)
CONSTANT_FILE_ENTRY($1, port_rcv_data, port_rcv_data, (.+), number, ${key:hostname}, $2, countersinfo, derive, port_rcv_data, port_rcv_data, driver_type=${subpath:driver_type} driver_index=${subpath:driver_index} port_number=${subpath:port_number}, 0)
CONSTANT_FILE_ENTRY($1, port_rcv_errors, port_rcv_errors, (.+), number, ${key:hostname}, $2, countersinfo, derive, port_rcv_errors, port_rcv_errors, driver_type=${subpath:driver_type} driver_index=${subpath:driver_index} port_number=${subpath:port_number}, 0)
CONSTANT_FILE_ENTRY($1, port_rcv_packets, port_rcv_packets, (.+), number, ${key:hostname}, $2, countersinfo, derive, port_rcv_packets, port_rcv_packets, driver_type=${subpath:driver_type} driver_index=${subpath:driver_index} port_number=${subpath:port_number}, 0)
CONSTANT_FILE_ENTRY($1, port_rcv_remote_physical_errors, port_rcv_remote_physical_errors, (.+), number, ${key:hostname}, $2, countersinfo, derive, port_rcv_remote_physical_errors, port_rcv_remote_physical_errors, driver_type=${subpath:driver_type} driver_index=${subpath:driver_index} port_number=${subpath:port_number}, 0)
CONSTANT_FILE_ENTRY($1, port_xmit_constraint_errors, port_xmit_constraint_errors, (.+), number, ${key:hostname}, $2, countersinfo, derive, port_xmit_constraint_errors, port_xmit_constraint_errors, driver_type=${subpath:driver_type} driver_index=${subpath:driver_index} port_number=${subpath:port_number}, 0)
CONSTANT_FILE_ENTRY($1, port_xmit_data, port_xmit_data, (.+), number, ${key:hostname}, $2, countersinfo, derive, port_xmit_data, port_xmit_data, driver_type=${subpath:driver_type} driver_index=${subpath:driver_index} port_number=${subpath:port_number}, 0)
CONSTANT_FILE_ENTRY($1, port_xmit_discards, port_xmit_discards, (.+), number, ${key:hostname}, $2, countersinfo, derive, port_xmit_discards, port_xmit_discards, driver_type=${subpath:driver_type} driver_index=${subpath:driver_index} port_number=${subpath:port_number}, 0)
CONSTANT_FILE_ENTRY($1, port_xmit_packets, port_xmit_packets, (.+), number, ${key:hostname}, $2, countersinfo, derive, port_xmit_packets, port_xmit_packets, driver_type=${subpath:driver_type} driver_index=${subpath:driver_index} port_number=${subpath:port_number}, 0)
CONSTANT_FILE_ENTRY($1, symbol_error, symbol_error, (.+), number, ${key:hostname}, $2, countersinfo, derive, symbol_error, symbol_error, driver_type=${subpath:driver_type} driver_index=${subpath:driver_index} port_number=${subpath:port_number}, 0)
CONSTANT_FILE_ENTRY($1, VL15_dropped, VL15_dropped, (.+), number, ${key:hostname}, $2, countersinfo, derive, VL15_dropped, VL15_dropped, driver_type=${subpath:driver_type} driver_index=${subpath:driver_index} port_number=${subpath:port_number}, 0)
CONSTANT_FILE_ENTRY($1, port_rcv_switch_relay_errors, port_rcv_switch_relay_errors, (.+), number, ${key:hostname}, $2, countersinfo, derive, port_rcv_switch_relay_errors, port_rcv_switch_relay_errors, driver_index=${subpath:driver_index} port_number=${subpath:port_number}, 0)')dnl
dnl $1: number of INDENT
dnl $2: plugin OPTION
dnl $3: is first child of parent ELEMENT
define(`FILES_HW_COUNTER_INFO_ENTRIES',
`CONSTANT_FILE_ENTRY($1, duplicate_request, duplicate_request, (.+), number, ${key:hostname}, $2, hw_countersinfo, derive, duplicate_request, duplicate_request, driver_type=${subpath:driver_type} driver_index=${subpath:driver_index} port_number=${subpath:port_number}, 1)
CONSTANT_FILE_ENTRY($1, implied_nak_seq_err, implied_nak_seq_err, (.+), number, ${key:hostname}, $2, hw_countersinfo, derive, implied_nak_seq_err, implied_nak_seq_err, driver_type=${subpath:driver_type} driver_index=${subpath:driver_index} port_number=${subpath:port_number}, 0)
CONSTANT_FILE_ENTRY($1, lifespan, lifespan, (.+), number, ${key:hostname}, $2, hw_countersinfo, derive, lifespan, lifespan, driver_type=${subpath:driver_type} driver_index=${subpath:driver_index} port_number=${subpath:port_number}, 0)
CONSTANT_FILE_ENTRY($1, local_ack_timeout_err, local_ack_timeout_err, (.+), number, ${key:hostname}, $2, hw_countersinfo, derive, local_ack_timeout_err, local_ack_timeout_err, driver_type=${subpath:driver_type} driver_index=${subpath:driver_index} port_number=${subpath:port_number}, 0)
CONSTANT_FILE_ENTRY($1, out_of_buffer, out_of_buffer, (.+), number, ${key:hostname}, $2, hw_countersinfo, derive, out_of_buffer, out_of_buffer, driver_type=${subpath:driver_type} driver_index=${subpath:driver_index} port_number=${subpath:port_number}, 0)
CONSTANT_FILE_ENTRY($1, out_of_sequence, out_of_sequence, (.+), number, ${key:hostname}, $2, hw_countersinfo, derive, out_of_sequence, out_of_sequence, driver_type=${subpath:driver_type} driver_index=${subpath:driver_index} port_number=${subpath:port_number}, 0)
CONSTANT_FILE_ENTRY($1, packet_seq_err, packet_seq_err, (.+), number, ${key:hostname}, $2, hw_countersinfo, derive, packet_seq_err, packet_seq_err, driver_type=${subpath:driver_type} driver_index=${subpath:driver_index} port_number=${subpath:port_number}, 0)
CONSTANT_FILE_ENTRY($1, req_cqe_error, req_cqe_error, (.+), number, ${key:hostname}, $2, hw_countersinfo, derive, req_cqe_error, req_cqe_error, driver_type=${subpath:driver_type} driver_index=${subpath:driver_index} port_number=${subpath:port_number}, 0)
CONSTANT_FILE_ENTRY($1, req_cqe_flush_error, req_cqe_flush_error, (.+), number, ${key:hostname}, $2, hw_countersinfo, derive, req_cqe_flush_error, req_cqe_flush_error, driver_type=${subpath:driver_type} driver_index=${subpath:driver_index} port_number=${subpath:port_number}, 0)
CONSTANT_FILE_ENTRY($1, req_remote_access_errors, req_remote_access_errors, (.+), number, ${key:hostname}, $2, hw_countersinfo, derive, req_remote_access_errors, req_remote_access_errors, driver_type=${subpath:driver_type} driver_index=${subpath:driver_index} port_number=${subpath:port_number}, 0)
CONSTANT_FILE_ENTRY($1, req_remote_invalid_request, req_remote_invalid_request, (.+), number, ${key:hostname}, $2, hw_countersinfo, derive, req_remote_invalid_request, req_remote_invalid_request, driver_type=${subpath:driver_type} driver_index=${subpath:driver_index} port_number=${subpath:port_number}, 0)
CONSTANT_FILE_ENTRY($1, resp_cqe_error, resp_cqe_error, (.+), number, ${key:hostname}, $2, hw_countersinfo, derive, resp_cqe_error, resp_cqe_error, driver_type=${subpath:driver_type} driver_index=${subpath:driver_index} port_number=${subpath:port_number}, 0)
CONSTANT_FILE_ENTRY($1, resp_cqe_flush_error, resp_cqe_flush_error, (.+), number, ${key:hostname}, $2, hw_countersinfo, derive, resp_cqe_flush_error, resp_cqe_flush_error, driver_type=${subpath:driver_type} driver_index=${subpath:driver_index} port_number=${subpath:port_number}, 0)
CONSTANT_FILE_ENTRY($1, resp_local_length_error, resp_local_length_error, (.+), number, ${key:hostname}, $2, hw_countersinfo, derive, resp_local_length_error, resp_local_length_error, driver_type=${subpath:driver_type} driver_index=${subpath:driver_index} port_number=${subpath:port_number}, 0)
CONSTANT_FILE_ENTRY($1, resp_remote_access_errors, resp_remote_access_errors, (.+), number, ${key:hostname}, $2, hw_countersinfo, derive, resp_remote_access_errors, resp_remote_access_errors, driver_type=${subpath:driver_type} driver_index=${subpath:driver_index} port_number=${subpath:port_number}, 0)
CONSTANT_FILE_ENTRY($1, rnr_nak_retry_err, rnr_nak_retry_err, (.+), number, ${key:hostname}, $2, hw_countersinfo, derive, rnr_nak_retry_err, rnr_nak_retry_err, driver_type=${subpath:driver_type} driver_index=${subpath:driver_index} port_number=${subpath:port_number}, 0)
CONSTANT_FILE_ENTRY($1, roce_adp_retrans, roce_adp_retrans, (.+), number, ${key:hostname}, $2, hw_countersinfo, derive, roce_adp_retrans, roce_adp_retrans, driver_type=${subpath:driver_type} driver_index=${subpath:driver_index} port_number=${subpath:port_number}, 0)
CONSTANT_FILE_ENTRY($1, roce_adp_retrans_to, roce_adp_retrans_to, (.+), number, ${key:hostname}, $2, hw_countersinfo, derive, roce_adp_retrans_to, roce_adp_retrans_to, driver_type=${subpath:driver_type} driver_index=${subpath:driver_index} port_number=${subpath:port_number}, 0)
CONSTANT_FILE_ENTRY($1, roce_slow_restart, roce_slow_restart, (.+), number, ${key:hostname}, $2, hw_countersinfo, derive, roce_slow_restart, roce_slow_restart, driver_type=${subpath:driver_type} driver_index=${subpath:driver_index} port_number=${subpath:port_number}, 0)
CONSTANT_FILE_ENTRY($1, roce_slow_restart_cnps, roce_slow_restart_cnps, (.+), number, ${key:hostname}, $2, hw_countersinfo, derive, roce_slow_restart_cnps, roce_slow_restart_cnps, driver_type=${subpath:driver_type} driver_index=${subpath:driver_index} port_number=${subpath:port_number}, 0)
CONSTANT_FILE_ENTRY($1, roce_slow_restart_trans, roce_slow_restart_trans, (.+), number, ${key:hostname}, $2, hw_countersinfo, derive, roce_slow_restart_trans, roce_slow_restart_trans, driver_type=${subpath:driver_type} driver_index=${subpath:driver_index} port_number=${subpath:port_number}, 0)
CONSTANT_FILE_ENTRY($1, rx_atomic_requests, rx_atomic_requests, (.+), number, ${key:hostname}, $2, hw_countersinfo, derive, rx_atomic_requests, rx_atomic_requests, driver_type=${subpath:driver_type} driver_index=${subpath:driver_index} port_number=${subpath:port_number}, 0)
CONSTANT_FILE_ENTRY($1, rx_dct_connect, rx_dct_connect, (.+), number, ${key:hostname}, $2, hw_countersinfo, derive, rx_dct_connect, rx_dct_connect, driver_type=${subpath:driver_type} driver_index=${subpath:driver_index} port_number=${subpath:port_number}, 0)
CONSTANT_FILE_ENTRY($1, rx_icrc_encapsulated, rx_icrc_encapsulated, (.+), number, ${key:hostname}, $2, hw_countersinfo, derive, rx_icrc_encapsulated, rx_icrc_encapsulated, driver_type=${subpath:driver_type} driver_index=${subpath:driver_index} port_number=${subpath:port_number}, 0)
CONSTANT_FILE_ENTRY($1, rx_read_requests, rx_read_requests, (.+), number, ${key:hostname}, $2, hw_countersinfo, derive, rx_read_requests, rx_read_requests, driver_type=${subpath:driver_type} driver_index=${subpath:driver_index} port_number=${subpath:port_number}, 0)
CONSTANT_FILE_ENTRY($1, rx_write_requests, rx_write_requests, (.+), number, ${key:hostname}, $2, hw_countersinfo, derive, rx_write_requests, rx_write_requests, driver_type=${subpath:driver_type} driver_index=${subpath:driver_index} port_number=${subpath:port_number}, 0)')dnl
dnl
HEAD(infiniband-0.1)
<definition>
	<version>0.1</version>
	<entry>
		<subpath>
			<subpath_type>constant</subpath_type>
			<path>/sys/class/infiniband</path>
		</subpath>
		<mode>directory</mode>
		<entry>
			<subpath>
				<subpath_type>regular_expression</subpath_type>
				<path>(^.+)_([0-9]+$)</path>
				<subpath_field>
					<index>1</index>
					<name>driver_type</name>
				</subpath_field>
				<subpath_field>
					<index>2</index>
					<name>driver_index</name>
				</subpath_field>
			</subpath>
			<mode>directory</mode>
			<entry>
				<subpath>
					<subpath_type>constant</subpath_type>
					<path>ports</path>
				</subpath>
				<mode>directory</mode>
				<entry>
					<subpath>
						<subpath_type>regular_expression</subpath_type>
						<path>(^[0-9]+$)</path>
						<subpath_field>
							<index>1</index>
							<name>port_number</name>
						</subpath_field>
					</subpath>
					<mode>directory</mode>
					<entry>
						<subpath>
							<subpath_type>constant</subpath_type>
							<path>counters</path>
						</subpath>
						<mode>directory</mode>
						FILES_COUNTER_INFO_ENTRIES(6, ${subpath:driver_type}-${subpath:driver_index}-${subpath:port_number}, 1)
					</entry>
					<entry>
						<subpath>
							<subpath_type>constant</subpath_type>
							<path>hw_counters</path>
						</subpath>
						<mode>directory</mode>
						FILES_HW_COUNTER_INFO_ENTRIES(6, ${subpath:driver_type}-${subpath:driver_index}-${subpath:port_number}, 1)
					</entry>
				</entry>
			</entry>
		</entry>
	</entry>
</definition>
