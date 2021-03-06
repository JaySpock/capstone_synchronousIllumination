// nios_setup.v

// Generated using ACDS version 18.1 625

`timescale 1 ps / 1 ps
module nios_setup (
		input  wire       clk_clk,                           //                        clk.clk
		output wire [2:0] led_external_connection_export,    //    led_external_connection.export
		input  wire       reset_reset_n,                     //                      reset.reset_n
		input  wire [2:0] switch_external_connection_export  // switch_external_connection.export
	);

	wire   [1:0] matlab_as_axi_master_0_axm_m0_awburst;                     // MATLAB_as_AXI_Master_0:axi4m_awburst -> mm_interconnect_0:MATLAB_as_AXI_Master_0_axm_m0_awburst
	wire   [7:0] matlab_as_axi_master_0_axm_m0_arlen;                       // MATLAB_as_AXI_Master_0:axi4m_arlen -> mm_interconnect_0:MATLAB_as_AXI_Master_0_axm_m0_arlen
	wire   [3:0] matlab_as_axi_master_0_axm_m0_arqos;                       // MATLAB_as_AXI_Master_0:axi4m_arqos -> mm_interconnect_0:MATLAB_as_AXI_Master_0_axm_m0_arqos
	wire         matlab_as_axi_master_0_axm_m0_wready;                      // mm_interconnect_0:MATLAB_as_AXI_Master_0_axm_m0_wready -> MATLAB_as_AXI_Master_0:axi4m_wready
	wire   [7:0] matlab_as_axi_master_0_axm_m0_wstrb;                       // MATLAB_as_AXI_Master_0:axi4m_wstrb -> mm_interconnect_0:MATLAB_as_AXI_Master_0_axm_m0_wstrb
	wire         matlab_as_axi_master_0_axm_m0_rid;                         // mm_interconnect_0:MATLAB_as_AXI_Master_0_axm_m0_rid -> MATLAB_as_AXI_Master_0:axi4m_rid
	wire         matlab_as_axi_master_0_axm_m0_rready;                      // MATLAB_as_AXI_Master_0:axi4m_rready -> mm_interconnect_0:MATLAB_as_AXI_Master_0_axm_m0_rready
	wire   [7:0] matlab_as_axi_master_0_axm_m0_awlen;                       // MATLAB_as_AXI_Master_0:axi4m_awlen -> mm_interconnect_0:MATLAB_as_AXI_Master_0_axm_m0_awlen
	wire   [3:0] matlab_as_axi_master_0_axm_m0_awqos;                       // MATLAB_as_AXI_Master_0:axi4m_awqos -> mm_interconnect_0:MATLAB_as_AXI_Master_0_axm_m0_awqos
	wire   [3:0] matlab_as_axi_master_0_axm_m0_arcache;                     // MATLAB_as_AXI_Master_0:axi4m_arcache -> mm_interconnect_0:MATLAB_as_AXI_Master_0_axm_m0_arcache
	wire         matlab_as_axi_master_0_axm_m0_wvalid;                      // MATLAB_as_AXI_Master_0:axi4m_wvalid -> mm_interconnect_0:MATLAB_as_AXI_Master_0_axm_m0_wvalid
	wire  [31:0] matlab_as_axi_master_0_axm_m0_araddr;                      // MATLAB_as_AXI_Master_0:axi4m_araddr -> mm_interconnect_0:MATLAB_as_AXI_Master_0_axm_m0_araddr
	wire   [2:0] matlab_as_axi_master_0_axm_m0_arprot;                      // MATLAB_as_AXI_Master_0:axi4m_arprot -> mm_interconnect_0:MATLAB_as_AXI_Master_0_axm_m0_arprot
	wire   [2:0] matlab_as_axi_master_0_axm_m0_awprot;                      // MATLAB_as_AXI_Master_0:axi4m_awprot -> mm_interconnect_0:MATLAB_as_AXI_Master_0_axm_m0_awprot
	wire  [63:0] matlab_as_axi_master_0_axm_m0_wdata;                       // MATLAB_as_AXI_Master_0:axi4m_wdata -> mm_interconnect_0:MATLAB_as_AXI_Master_0_axm_m0_wdata
	wire         matlab_as_axi_master_0_axm_m0_arvalid;                     // MATLAB_as_AXI_Master_0:axi4m_arvalid -> mm_interconnect_0:MATLAB_as_AXI_Master_0_axm_m0_arvalid
	wire   [3:0] matlab_as_axi_master_0_axm_m0_awcache;                     // MATLAB_as_AXI_Master_0:axi4m_awcache -> mm_interconnect_0:MATLAB_as_AXI_Master_0_axm_m0_awcache
	wire   [0:0] matlab_as_axi_master_0_axm_m0_arid;                        // MATLAB_as_AXI_Master_0:axi4m_arid -> mm_interconnect_0:MATLAB_as_AXI_Master_0_axm_m0_arid
	wire         matlab_as_axi_master_0_axm_m0_arlock;                      // MATLAB_as_AXI_Master_0:axi4m_arlock -> mm_interconnect_0:MATLAB_as_AXI_Master_0_axm_m0_arlock
	wire         matlab_as_axi_master_0_axm_m0_awlock;                      // MATLAB_as_AXI_Master_0:axi4m_awlock -> mm_interconnect_0:MATLAB_as_AXI_Master_0_axm_m0_awlock
	wire  [31:0] matlab_as_axi_master_0_axm_m0_awaddr;                      // MATLAB_as_AXI_Master_0:axi4m_awaddr -> mm_interconnect_0:MATLAB_as_AXI_Master_0_axm_m0_awaddr
	wire         matlab_as_axi_master_0_axm_m0_arready;                     // mm_interconnect_0:MATLAB_as_AXI_Master_0_axm_m0_arready -> MATLAB_as_AXI_Master_0:axi4m_arready
	wire   [1:0] matlab_as_axi_master_0_axm_m0_bresp;                       // mm_interconnect_0:MATLAB_as_AXI_Master_0_axm_m0_bresp -> MATLAB_as_AXI_Master_0:axi4m_bresp
	wire  [63:0] matlab_as_axi_master_0_axm_m0_rdata;                       // mm_interconnect_0:MATLAB_as_AXI_Master_0_axm_m0_rdata -> MATLAB_as_AXI_Master_0:axi4m_rdata
	wire         matlab_as_axi_master_0_axm_m0_awready;                     // mm_interconnect_0:MATLAB_as_AXI_Master_0_axm_m0_awready -> MATLAB_as_AXI_Master_0:axi4m_awready
	wire   [1:0] matlab_as_axi_master_0_axm_m0_arburst;                     // MATLAB_as_AXI_Master_0:axi4m_arburst -> mm_interconnect_0:MATLAB_as_AXI_Master_0_axm_m0_arburst
	wire   [2:0] matlab_as_axi_master_0_axm_m0_arsize;                      // MATLAB_as_AXI_Master_0:axi4m_arsize -> mm_interconnect_0:MATLAB_as_AXI_Master_0_axm_m0_arsize
	wire         matlab_as_axi_master_0_axm_m0_bready;                      // MATLAB_as_AXI_Master_0:axi4m_bready -> mm_interconnect_0:MATLAB_as_AXI_Master_0_axm_m0_bready
	wire         matlab_as_axi_master_0_axm_m0_rlast;                       // mm_interconnect_0:MATLAB_as_AXI_Master_0_axm_m0_rlast -> MATLAB_as_AXI_Master_0:axi4m_rlast
	wire         matlab_as_axi_master_0_axm_m0_wlast;                       // MATLAB_as_AXI_Master_0:axi4m_wlast -> mm_interconnect_0:MATLAB_as_AXI_Master_0_axm_m0_wlast
	wire   [1:0] matlab_as_axi_master_0_axm_m0_rresp;                       // mm_interconnect_0:MATLAB_as_AXI_Master_0_axm_m0_rresp -> MATLAB_as_AXI_Master_0:axi4m_rresp
	wire   [0:0] matlab_as_axi_master_0_axm_m0_awid;                        // MATLAB_as_AXI_Master_0:axi4m_awid -> mm_interconnect_0:MATLAB_as_AXI_Master_0_axm_m0_awid
	wire         matlab_as_axi_master_0_axm_m0_bid;                         // mm_interconnect_0:MATLAB_as_AXI_Master_0_axm_m0_bid -> MATLAB_as_AXI_Master_0:axi4m_bid
	wire         matlab_as_axi_master_0_axm_m0_bvalid;                      // mm_interconnect_0:MATLAB_as_AXI_Master_0_axm_m0_bvalid -> MATLAB_as_AXI_Master_0:axi4m_bvalid
	wire         matlab_as_axi_master_0_axm_m0_awvalid;                     // MATLAB_as_AXI_Master_0:axi4m_awvalid -> mm_interconnect_0:MATLAB_as_AXI_Master_0_axm_m0_awvalid
	wire         matlab_as_axi_master_0_axm_m0_rvalid;                      // mm_interconnect_0:MATLAB_as_AXI_Master_0_axm_m0_rvalid -> MATLAB_as_AXI_Master_0:axi4m_rvalid
	wire   [2:0] matlab_as_axi_master_0_axm_m0_awsize;                      // MATLAB_as_AXI_Master_0:axi4m_awsize -> mm_interconnect_0:MATLAB_as_AXI_Master_0_axm_m0_awsize
	wire         mm_interconnect_0_jtag_uart_avalon_jtag_slave_chipselect;  // mm_interconnect_0:jtag_uart_avalon_jtag_slave_chipselect -> jtag_uart:av_chipselect
	wire  [31:0] mm_interconnect_0_jtag_uart_avalon_jtag_slave_readdata;    // jtag_uart:av_readdata -> mm_interconnect_0:jtag_uart_avalon_jtag_slave_readdata
	wire         mm_interconnect_0_jtag_uart_avalon_jtag_slave_waitrequest; // jtag_uart:av_waitrequest -> mm_interconnect_0:jtag_uart_avalon_jtag_slave_waitrequest
	wire   [0:0] mm_interconnect_0_jtag_uart_avalon_jtag_slave_address;     // mm_interconnect_0:jtag_uart_avalon_jtag_slave_address -> jtag_uart:av_address
	wire         mm_interconnect_0_jtag_uart_avalon_jtag_slave_read;        // mm_interconnect_0:jtag_uart_avalon_jtag_slave_read -> jtag_uart:av_read_n
	wire         mm_interconnect_0_jtag_uart_avalon_jtag_slave_write;       // mm_interconnect_0:jtag_uart_avalon_jtag_slave_write -> jtag_uart:av_write_n
	wire  [31:0] mm_interconnect_0_jtag_uart_avalon_jtag_slave_writedata;   // mm_interconnect_0:jtag_uart_avalon_jtag_slave_writedata -> jtag_uart:av_writedata
	wire         mm_interconnect_0_onchip_memory_s1_chipselect;             // mm_interconnect_0:onchip_memory_s1_chipselect -> onchip_memory:chipselect
	wire  [31:0] mm_interconnect_0_onchip_memory_s1_readdata;               // onchip_memory:readdata -> mm_interconnect_0:onchip_memory_s1_readdata
	wire  [11:0] mm_interconnect_0_onchip_memory_s1_address;                // mm_interconnect_0:onchip_memory_s1_address -> onchip_memory:address
	wire   [3:0] mm_interconnect_0_onchip_memory_s1_byteenable;             // mm_interconnect_0:onchip_memory_s1_byteenable -> onchip_memory:byteenable
	wire         mm_interconnect_0_onchip_memory_s1_write;                  // mm_interconnect_0:onchip_memory_s1_write -> onchip_memory:write
	wire  [31:0] mm_interconnect_0_onchip_memory_s1_writedata;              // mm_interconnect_0:onchip_memory_s1_writedata -> onchip_memory:writedata
	wire         mm_interconnect_0_onchip_memory_s1_clken;                  // mm_interconnect_0:onchip_memory_s1_clken -> onchip_memory:clken
	wire         mm_interconnect_0_led_s1_chipselect;                       // mm_interconnect_0:led_s1_chipselect -> led:chipselect
	wire  [31:0] mm_interconnect_0_led_s1_readdata;                         // led:readdata -> mm_interconnect_0:led_s1_readdata
	wire   [1:0] mm_interconnect_0_led_s1_address;                          // mm_interconnect_0:led_s1_address -> led:address
	wire         mm_interconnect_0_led_s1_write;                            // mm_interconnect_0:led_s1_write -> led:write_n
	wire  [31:0] mm_interconnect_0_led_s1_writedata;                        // mm_interconnect_0:led_s1_writedata -> led:writedata
	wire         rst_controller_reset_out_reset;                            // rst_controller:reset_out -> [MATLAB_as_AXI_Master_0:aresetn, jtag_uart:rst_n, led:reset_n, mm_interconnect_0:MATLAB_as_AXI_Master_0_aresetn_reset_bridge_in_reset_reset, onchip_memory:reset, pb:reset_n, rst_translator:in_reset]
	wire         rst_controller_reset_out_reset_req;                        // rst_controller:reset_req -> [onchip_memory:reset_req, rst_translator:reset_req_in]

	hdlverifier_axi_master #(
		.JTAG_ID        (56),
		.ID_WIDTH       (1),
		.AXI_DATA_WIDTH (64),
		.AXI_ADDR_WIDTH (32)
	) matlab_as_axi_master_0 (
		.axi4m_awaddr  (matlab_as_axi_master_0_axm_m0_awaddr),  //  axm_m0.awaddr
		.axi4m_awprot  (matlab_as_axi_master_0_axm_m0_awprot),  //        .awprot
		.axi4m_awvalid (matlab_as_axi_master_0_axm_m0_awvalid), //        .awvalid
		.axi4m_awready (matlab_as_axi_master_0_axm_m0_awready), //        .awready
		.axi4m_wdata   (matlab_as_axi_master_0_axm_m0_wdata),   //        .wdata
		.axi4m_wlast   (matlab_as_axi_master_0_axm_m0_wlast),   //        .wlast
		.axi4m_wvalid  (matlab_as_axi_master_0_axm_m0_wvalid),  //        .wvalid
		.axi4m_wready  (matlab_as_axi_master_0_axm_m0_wready),  //        .wready
		.axi4m_bvalid  (matlab_as_axi_master_0_axm_m0_bvalid),  //        .bvalid
		.axi4m_bready  (matlab_as_axi_master_0_axm_m0_bready),  //        .bready
		.axi4m_araddr  (matlab_as_axi_master_0_axm_m0_araddr),  //        .araddr
		.axi4m_arprot  (matlab_as_axi_master_0_axm_m0_arprot),  //        .arprot
		.axi4m_arvalid (matlab_as_axi_master_0_axm_m0_arvalid), //        .arvalid
		.axi4m_arready (matlab_as_axi_master_0_axm_m0_arready), //        .arready
		.axi4m_rdata   (matlab_as_axi_master_0_axm_m0_rdata),   //        .rdata
		.axi4m_rvalid  (matlab_as_axi_master_0_axm_m0_rvalid),  //        .rvalid
		.axi4m_rready  (matlab_as_axi_master_0_axm_m0_rready),  //        .rready
		.axi4m_arburst (matlab_as_axi_master_0_axm_m0_arburst), //        .arburst
		.axi4m_arcache (matlab_as_axi_master_0_axm_m0_arcache), //        .arcache
		.axi4m_arlen   (matlab_as_axi_master_0_axm_m0_arlen),   //        .arlen
		.axi4m_arlock  (matlab_as_axi_master_0_axm_m0_arlock),  //        .arlock
		.axi4m_arqos   (matlab_as_axi_master_0_axm_m0_arqos),   //        .arqos
		.axi4m_arsize  (matlab_as_axi_master_0_axm_m0_arsize),  //        .arsize
		.axi4m_awburst (matlab_as_axi_master_0_axm_m0_awburst), //        .awburst
		.axi4m_awcache (matlab_as_axi_master_0_axm_m0_awcache), //        .awcache
		.axi4m_awid    (matlab_as_axi_master_0_axm_m0_awid),    //        .awid
		.axi4m_awlen   (matlab_as_axi_master_0_axm_m0_awlen),   //        .awlen
		.axi4m_awlock  (matlab_as_axi_master_0_axm_m0_awlock),  //        .awlock
		.axi4m_awqos   (matlab_as_axi_master_0_axm_m0_awqos),   //        .awqos
		.axi4m_awsize  (matlab_as_axi_master_0_axm_m0_awsize),  //        .awsize
		.axi4m_bresp   (matlab_as_axi_master_0_axm_m0_bresp),   //        .bresp
		.axi4m_rid     (matlab_as_axi_master_0_axm_m0_rid),     //        .rid
		.axi4m_rlast   (matlab_as_axi_master_0_axm_m0_rlast),   //        .rlast
		.axi4m_rresp   (matlab_as_axi_master_0_axm_m0_rresp),   //        .rresp
		.axi4m_wstrb   (matlab_as_axi_master_0_axm_m0_wstrb),   //        .wstrb
		.axi4m_arid    (matlab_as_axi_master_0_axm_m0_arid),    //        .arid
		.axi4m_bid     (matlab_as_axi_master_0_axm_m0_bid),     //        .bid
		.aclk          (clk_clk),                               //    aclk.clk
		.aresetn       (~rst_controller_reset_out_reset)        // aresetn.reset_n
	);

	nios_setup_jtag_uart jtag_uart (
		.clk            (clk_clk),                                                   //               clk.clk
		.rst_n          (~rst_controller_reset_out_reset),                           //             reset.reset_n
		.av_chipselect  (mm_interconnect_0_jtag_uart_avalon_jtag_slave_chipselect),  // avalon_jtag_slave.chipselect
		.av_address     (mm_interconnect_0_jtag_uart_avalon_jtag_slave_address),     //                  .address
		.av_read_n      (~mm_interconnect_0_jtag_uart_avalon_jtag_slave_read),       //                  .read_n
		.av_readdata    (mm_interconnect_0_jtag_uart_avalon_jtag_slave_readdata),    //                  .readdata
		.av_write_n     (~mm_interconnect_0_jtag_uart_avalon_jtag_slave_write),      //                  .write_n
		.av_writedata   (mm_interconnect_0_jtag_uart_avalon_jtag_slave_writedata),   //                  .writedata
		.av_waitrequest (mm_interconnect_0_jtag_uart_avalon_jtag_slave_waitrequest), //                  .waitrequest
		.av_irq         ()                                                           //               irq.irq
	);

	nios_setup_led led (
		.clk        (clk_clk),                             //                 clk.clk
		.reset_n    (~rst_controller_reset_out_reset),     //               reset.reset_n
		.address    (mm_interconnect_0_led_s1_address),    //                  s1.address
		.write_n    (~mm_interconnect_0_led_s1_write),     //                    .write_n
		.writedata  (mm_interconnect_0_led_s1_writedata),  //                    .writedata
		.chipselect (mm_interconnect_0_led_s1_chipselect), //                    .chipselect
		.readdata   (mm_interconnect_0_led_s1_readdata),   //                    .readdata
		.out_port   (led_external_connection_export)       // external_connection.export
	);

	nios_setup_onchip_memory onchip_memory (
		.clk        (clk_clk),                                       //   clk1.clk
		.address    (mm_interconnect_0_onchip_memory_s1_address),    //     s1.address
		.clken      (mm_interconnect_0_onchip_memory_s1_clken),      //       .clken
		.chipselect (mm_interconnect_0_onchip_memory_s1_chipselect), //       .chipselect
		.write      (mm_interconnect_0_onchip_memory_s1_write),      //       .write
		.readdata   (mm_interconnect_0_onchip_memory_s1_readdata),   //       .readdata
		.writedata  (mm_interconnect_0_onchip_memory_s1_writedata),  //       .writedata
		.byteenable (mm_interconnect_0_onchip_memory_s1_byteenable), //       .byteenable
		.reset      (rst_controller_reset_out_reset),                // reset1.reset
		.reset_req  (rst_controller_reset_out_reset_req),            //       .reset_req
		.freeze     (1'b0)                                           // (terminated)
	);

	nios_setup_pb pb (
		.clk      (clk_clk),                           //                 clk.clk
		.reset_n  (~rst_controller_reset_out_reset),   //               reset.reset_n
		.address  (),                                  //                  s1.address
		.readdata (),                                  //                    .readdata
		.in_port  (switch_external_connection_export)  // external_connection.export
	);

	nios_setup_mm_interconnect_0 mm_interconnect_0 (
		.MATLAB_as_AXI_Master_0_axm_m0_awid                         (matlab_as_axi_master_0_axm_m0_awid),                        //                        MATLAB_as_AXI_Master_0_axm_m0.awid
		.MATLAB_as_AXI_Master_0_axm_m0_awaddr                       (matlab_as_axi_master_0_axm_m0_awaddr),                      //                                                     .awaddr
		.MATLAB_as_AXI_Master_0_axm_m0_awlen                        (matlab_as_axi_master_0_axm_m0_awlen),                       //                                                     .awlen
		.MATLAB_as_AXI_Master_0_axm_m0_awsize                       (matlab_as_axi_master_0_axm_m0_awsize),                      //                                                     .awsize
		.MATLAB_as_AXI_Master_0_axm_m0_awburst                      (matlab_as_axi_master_0_axm_m0_awburst),                     //                                                     .awburst
		.MATLAB_as_AXI_Master_0_axm_m0_awlock                       (matlab_as_axi_master_0_axm_m0_awlock),                      //                                                     .awlock
		.MATLAB_as_AXI_Master_0_axm_m0_awcache                      (matlab_as_axi_master_0_axm_m0_awcache),                     //                                                     .awcache
		.MATLAB_as_AXI_Master_0_axm_m0_awprot                       (matlab_as_axi_master_0_axm_m0_awprot),                      //                                                     .awprot
		.MATLAB_as_AXI_Master_0_axm_m0_awqos                        (matlab_as_axi_master_0_axm_m0_awqos),                       //                                                     .awqos
		.MATLAB_as_AXI_Master_0_axm_m0_awvalid                      (matlab_as_axi_master_0_axm_m0_awvalid),                     //                                                     .awvalid
		.MATLAB_as_AXI_Master_0_axm_m0_awready                      (matlab_as_axi_master_0_axm_m0_awready),                     //                                                     .awready
		.MATLAB_as_AXI_Master_0_axm_m0_wdata                        (matlab_as_axi_master_0_axm_m0_wdata),                       //                                                     .wdata
		.MATLAB_as_AXI_Master_0_axm_m0_wstrb                        (matlab_as_axi_master_0_axm_m0_wstrb),                       //                                                     .wstrb
		.MATLAB_as_AXI_Master_0_axm_m0_wlast                        (matlab_as_axi_master_0_axm_m0_wlast),                       //                                                     .wlast
		.MATLAB_as_AXI_Master_0_axm_m0_wvalid                       (matlab_as_axi_master_0_axm_m0_wvalid),                      //                                                     .wvalid
		.MATLAB_as_AXI_Master_0_axm_m0_wready                       (matlab_as_axi_master_0_axm_m0_wready),                      //                                                     .wready
		.MATLAB_as_AXI_Master_0_axm_m0_bid                          (matlab_as_axi_master_0_axm_m0_bid),                         //                                                     .bid
		.MATLAB_as_AXI_Master_0_axm_m0_bresp                        (matlab_as_axi_master_0_axm_m0_bresp),                       //                                                     .bresp
		.MATLAB_as_AXI_Master_0_axm_m0_bvalid                       (matlab_as_axi_master_0_axm_m0_bvalid),                      //                                                     .bvalid
		.MATLAB_as_AXI_Master_0_axm_m0_bready                       (matlab_as_axi_master_0_axm_m0_bready),                      //                                                     .bready
		.MATLAB_as_AXI_Master_0_axm_m0_arid                         (matlab_as_axi_master_0_axm_m0_arid),                        //                                                     .arid
		.MATLAB_as_AXI_Master_0_axm_m0_araddr                       (matlab_as_axi_master_0_axm_m0_araddr),                      //                                                     .araddr
		.MATLAB_as_AXI_Master_0_axm_m0_arlen                        (matlab_as_axi_master_0_axm_m0_arlen),                       //                                                     .arlen
		.MATLAB_as_AXI_Master_0_axm_m0_arsize                       (matlab_as_axi_master_0_axm_m0_arsize),                      //                                                     .arsize
		.MATLAB_as_AXI_Master_0_axm_m0_arburst                      (matlab_as_axi_master_0_axm_m0_arburst),                     //                                                     .arburst
		.MATLAB_as_AXI_Master_0_axm_m0_arlock                       (matlab_as_axi_master_0_axm_m0_arlock),                      //                                                     .arlock
		.MATLAB_as_AXI_Master_0_axm_m0_arcache                      (matlab_as_axi_master_0_axm_m0_arcache),                     //                                                     .arcache
		.MATLAB_as_AXI_Master_0_axm_m0_arprot                       (matlab_as_axi_master_0_axm_m0_arprot),                      //                                                     .arprot
		.MATLAB_as_AXI_Master_0_axm_m0_arqos                        (matlab_as_axi_master_0_axm_m0_arqos),                       //                                                     .arqos
		.MATLAB_as_AXI_Master_0_axm_m0_arvalid                      (matlab_as_axi_master_0_axm_m0_arvalid),                     //                                                     .arvalid
		.MATLAB_as_AXI_Master_0_axm_m0_arready                      (matlab_as_axi_master_0_axm_m0_arready),                     //                                                     .arready
		.MATLAB_as_AXI_Master_0_axm_m0_rid                          (matlab_as_axi_master_0_axm_m0_rid),                         //                                                     .rid
		.MATLAB_as_AXI_Master_0_axm_m0_rdata                        (matlab_as_axi_master_0_axm_m0_rdata),                       //                                                     .rdata
		.MATLAB_as_AXI_Master_0_axm_m0_rresp                        (matlab_as_axi_master_0_axm_m0_rresp),                       //                                                     .rresp
		.MATLAB_as_AXI_Master_0_axm_m0_rlast                        (matlab_as_axi_master_0_axm_m0_rlast),                       //                                                     .rlast
		.MATLAB_as_AXI_Master_0_axm_m0_rvalid                       (matlab_as_axi_master_0_axm_m0_rvalid),                      //                                                     .rvalid
		.MATLAB_as_AXI_Master_0_axm_m0_rready                       (matlab_as_axi_master_0_axm_m0_rready),                      //                                                     .rready
		.clk_0_clk_clk                                              (clk_clk),                                                   //                                            clk_0_clk.clk
		.MATLAB_as_AXI_Master_0_aresetn_reset_bridge_in_reset_reset (rst_controller_reset_out_reset),                            // MATLAB_as_AXI_Master_0_aresetn_reset_bridge_in_reset.reset
		.jtag_uart_avalon_jtag_slave_address                        (mm_interconnect_0_jtag_uart_avalon_jtag_slave_address),     //                          jtag_uart_avalon_jtag_slave.address
		.jtag_uart_avalon_jtag_slave_write                          (mm_interconnect_0_jtag_uart_avalon_jtag_slave_write),       //                                                     .write
		.jtag_uart_avalon_jtag_slave_read                           (mm_interconnect_0_jtag_uart_avalon_jtag_slave_read),        //                                                     .read
		.jtag_uart_avalon_jtag_slave_readdata                       (mm_interconnect_0_jtag_uart_avalon_jtag_slave_readdata),    //                                                     .readdata
		.jtag_uart_avalon_jtag_slave_writedata                      (mm_interconnect_0_jtag_uart_avalon_jtag_slave_writedata),   //                                                     .writedata
		.jtag_uart_avalon_jtag_slave_waitrequest                    (mm_interconnect_0_jtag_uart_avalon_jtag_slave_waitrequest), //                                                     .waitrequest
		.jtag_uart_avalon_jtag_slave_chipselect                     (mm_interconnect_0_jtag_uart_avalon_jtag_slave_chipselect),  //                                                     .chipselect
		.led_s1_address                                             (mm_interconnect_0_led_s1_address),                          //                                               led_s1.address
		.led_s1_write                                               (mm_interconnect_0_led_s1_write),                            //                                                     .write
		.led_s1_readdata                                            (mm_interconnect_0_led_s1_readdata),                         //                                                     .readdata
		.led_s1_writedata                                           (mm_interconnect_0_led_s1_writedata),                        //                                                     .writedata
		.led_s1_chipselect                                          (mm_interconnect_0_led_s1_chipselect),                       //                                                     .chipselect
		.onchip_memory_s1_address                                   (mm_interconnect_0_onchip_memory_s1_address),                //                                     onchip_memory_s1.address
		.onchip_memory_s1_write                                     (mm_interconnect_0_onchip_memory_s1_write),                  //                                                     .write
		.onchip_memory_s1_readdata                                  (mm_interconnect_0_onchip_memory_s1_readdata),               //                                                     .readdata
		.onchip_memory_s1_writedata                                 (mm_interconnect_0_onchip_memory_s1_writedata),              //                                                     .writedata
		.onchip_memory_s1_byteenable                                (mm_interconnect_0_onchip_memory_s1_byteenable),             //                                                     .byteenable
		.onchip_memory_s1_chipselect                                (mm_interconnect_0_onchip_memory_s1_chipselect),             //                                                     .chipselect
		.onchip_memory_s1_clken                                     (mm_interconnect_0_onchip_memory_s1_clken)                   //                                                     .clken
	);

	altera_reset_controller #(
		.NUM_RESET_INPUTS          (1),
		.OUTPUT_RESET_SYNC_EDGES   ("deassert"),
		.SYNC_DEPTH                (2),
		.RESET_REQUEST_PRESENT     (1),
		.RESET_REQ_WAIT_TIME       (1),
		.MIN_RST_ASSERTION_TIME    (3),
		.RESET_REQ_EARLY_DSRT_TIME (1),
		.USE_RESET_REQUEST_IN0     (0),
		.USE_RESET_REQUEST_IN1     (0),
		.USE_RESET_REQUEST_IN2     (0),
		.USE_RESET_REQUEST_IN3     (0),
		.USE_RESET_REQUEST_IN4     (0),
		.USE_RESET_REQUEST_IN5     (0),
		.USE_RESET_REQUEST_IN6     (0),
		.USE_RESET_REQUEST_IN7     (0),
		.USE_RESET_REQUEST_IN8     (0),
		.USE_RESET_REQUEST_IN9     (0),
		.USE_RESET_REQUEST_IN10    (0),
		.USE_RESET_REQUEST_IN11    (0),
		.USE_RESET_REQUEST_IN12    (0),
		.USE_RESET_REQUEST_IN13    (0),
		.USE_RESET_REQUEST_IN14    (0),
		.USE_RESET_REQUEST_IN15    (0),
		.ADAPT_RESET_REQUEST       (0)
	) rst_controller (
		.reset_in0      (~reset_reset_n),                     // reset_in0.reset
		.clk            (clk_clk),                            //       clk.clk
		.reset_out      (rst_controller_reset_out_reset),     // reset_out.reset
		.reset_req      (rst_controller_reset_out_reset_req), //          .reset_req
		.reset_req_in0  (1'b0),                               // (terminated)
		.reset_in1      (1'b0),                               // (terminated)
		.reset_req_in1  (1'b0),                               // (terminated)
		.reset_in2      (1'b0),                               // (terminated)
		.reset_req_in2  (1'b0),                               // (terminated)
		.reset_in3      (1'b0),                               // (terminated)
		.reset_req_in3  (1'b0),                               // (terminated)
		.reset_in4      (1'b0),                               // (terminated)
		.reset_req_in4  (1'b0),                               // (terminated)
		.reset_in5      (1'b0),                               // (terminated)
		.reset_req_in5  (1'b0),                               // (terminated)
		.reset_in6      (1'b0),                               // (terminated)
		.reset_req_in6  (1'b0),                               // (terminated)
		.reset_in7      (1'b0),                               // (terminated)
		.reset_req_in7  (1'b0),                               // (terminated)
		.reset_in8      (1'b0),                               // (terminated)
		.reset_req_in8  (1'b0),                               // (terminated)
		.reset_in9      (1'b0),                               // (terminated)
		.reset_req_in9  (1'b0),                               // (terminated)
		.reset_in10     (1'b0),                               // (terminated)
		.reset_req_in10 (1'b0),                               // (terminated)
		.reset_in11     (1'b0),                               // (terminated)
		.reset_req_in11 (1'b0),                               // (terminated)
		.reset_in12     (1'b0),                               // (terminated)
		.reset_req_in12 (1'b0),                               // (terminated)
		.reset_in13     (1'b0),                               // (terminated)
		.reset_req_in13 (1'b0),                               // (terminated)
		.reset_in14     (1'b0),                               // (terminated)
		.reset_req_in14 (1'b0),                               // (terminated)
		.reset_in15     (1'b0),                               // (terminated)
		.reset_req_in15 (1'b0)                                // (terminated)
	);

endmodule
