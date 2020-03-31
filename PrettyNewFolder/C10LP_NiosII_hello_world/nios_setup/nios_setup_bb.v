
module nios_setup (
	clk_clk,
	led_external_connection_export,
	reset_reset_n,
	switch_external_connection_export);	

	input		clk_clk;
	input	[4:0]	led_external_connection_export;
	input		reset_reset_n;
	output	[2:0]	switch_external_connection_export;
endmodule
