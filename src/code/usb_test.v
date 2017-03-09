module usb_test (

/*********************** CLK **********************/
		
		input CLK_24,

/******************* SDRAM DD33 *******************/

		output [12:0] SDRAM_A,
		output [1:0]  SDRAM_BA,
		output SDRAM_CLK,
		output SDRAM_CLKE,
		output SDRAM_nCS,
		output SDRAM_DQMH,
		inout  [15:0] SDRAM_DQ,
		output SDRAM_nRAS,
		output SDRAM_nCAS,
		output SDRAM_nWE,
		output SDRAM_DQML,

/********************** TP X1 **********************/

		output wire [6:1] TP, 
	
/******************** FTDI DD31 ********************/	
		
		output  FUSB_nRES,
		inout   [7:0] FU_D, 
		input   FRXF,
		input   FPWREN,
		output  FODD,
		output  FOE,
		output  FSIWU,
		output  FWR,
		output  FRD,
		input   FTXE,
		input   FCLK_OUT,
		
		
/********************* I2C DD3 *********************/	
		
		inout   FSDA,
		output  FSCL,
				
/****************************************************/	
	
	// DD5
		input   FH3_D1_R,
		output  FH3_D1_D,
		output  FH3_D1_nRE,
		output  FH3_D1_DE, //
	// DD6 
		input   FL2_D1_R,
		output  FL2_D1_D,
		output  FL2_D1_nRE,
		output  FL2_D1_DE, //
	// DD7
		input   FH1_D1_R,
		output  FH1_D1_D,
		output  FH1_D1_nRE,
		output  FH1_D1_DE, // 
	// DD8
		input	  FH2_D1_R, 
		output  FH2_D1_D,
		output  FH2_D1_nRE,
		output  FH2_D1_DE, //
	// DD9
		input   FH3_C1_R,
		output  FH3_C1_D,
		output  FH3_C1_nRE,
		output  FH3_C1_DE, //
	// DD10
		input   FL2_D2_R,
		output  FL2_D2_D,
		output  FL2_D2_nRE,
		output  FL2_D2_DE, //
	// DD11
		input   FH1_C1_R,
		output  FH1_C1_D,
		output  FH1_C1_nRE,
		output  FH1_C1_DE, //
	// DD12
		input   FH2_C1_R,
		output  FH2_C1_D,
		output  FH2_C1_nRE,
		output  FH2_C1_DE, //
	// DD13
		input   FH3_D2_R,
		output  FH3_D2_D,
		output  FH3_D2_nRE,
		output  FH3_D2_DE, //
	// DD14 	
		input   FL1_D1_R,  
		output  FL1_D1_D,
		output  FL1_D1_nRE,
		output  FL1_D1_DE, //
	// DD15
		input   FH1_D2_R,
		output  FH1_D2_D,
		output  FH1_D2_nRE,
		output  FH1_D2_DE, //
	// DD16
		input	  FH2_D2_R, 
		output  FH2_D2_D,
		output  FH2_D2_nRE,
		output  FH2_D2_DE, //
	// DD17
		input   FH3_C2_R,
		output  FH3_C2_D,
		output  FH3_C2_nRE,
		output  FH3_C2_DE, //
	// DD18
		input   FL1_D2_R,
		output  FL1_D2_D,
		output  FL1_D2_nRE,
		output  FL1_D2_DE, //
	// DD19
		input	  FH1_C2_R,
		output  FH1_C2_D,
		output  FH1_C2_nRE,
		output  FH1_C2_DE, //
	// DD20
		input   FH2_C2_R,
		output  FH2_C2_D,
		output  FH2_C2_nRE,
		output  FH2_C2_DE, //	
	// DD21
		input   FH4_D1_R,
		output  FH4_D1_D,
		output  FH4_D1_nRE,
		output  FH4_D1_DE, //
	// DD22
		input   FH4_C1_R,
		output  FH4_C1_D,
		output  FH4_C1_nRE,
		output  FH4_C1_DE, //
	// DD23
		input   FL3_D1_R,
		output  FL3_D1_D,
		output  FL3_D1_nRE,
		output  FL3_D1_DE, //
	// DD24
		input   FH4_D2_R,
		output  FH4_D2_D,
		output  FH4_D2_nRE,
		output  FH4_D2_DE, //
	// DD25
		input   FL3_D2_R,
		output  FL3_D2_D,
		output  FL3_D2_nRE,
		output  FL3_D2_DE, //
	// DD26
		input   FH4_C2_R,		
		output  FH4_C2_D,
		output  FH4_C2_nRE,
		output  FH4_C2_DE //

		
);


assign FSDA = 0;
assign FSCL = 0;

/*****************************/

assign FH3_D1_D 	= 0;
assign FH3_D1_nRE = 1;
assign FH3_D1_DE 	= 0;

assign FL2_D1_D	= 0;
assign FL2_D1_nRE = 1;
assign FL2_D1_DE  = 0; 
  
assign FH1_D1_D	= 0;
assign FH1_D1_nRE	= 1;
assign FH1_D1_DE	= 0;

assign FH2_D1_D	= 0;
assign FH2_D1_nRE	= 1;
assign FH2_D1_DE	= 0;

assign FH3_C1_D	= 0;	
assign FH3_C1_nRE	= 1;
assign FH3_C1_DE	= 0;

assign FL2_D2_D	= 0;
assign FL2_D2_nRE	= 1;
assign FL2_D2_DE	= 0;

assign FH1_C1_D	= 0;
assign FH1_C1_nRE	= 1;
assign FH1_C1_DE	= 0;
		
assign FH2_C1_D	= 0;
assign FH2_C1_nRE	= 1;
assign FH2_C1_DE	= 0;

assign FH3_D2_D	= 0;
assign FH3_D2_nRE	= 1;
assign FH3_D2_DE	= 0;

assign FL1_D1_D	= 0;
assign FL1_D1_nRE	= 1;
assign FL1_D1_DE	= 0;	
		
assign FH1_D2_D	= 0;
assign FH1_D2_nRE	= 1;
assign FH1_D2_DE	= 0;

assign FH2_D2_D	= 0;
assign FH2_D2_nRE	= 1;
assign FH2_D2_DE	= 0;

assign FH3_C2_D	= 0;
assign FH3_C2_nRE	= 1;
assign FH3_C2_DE	= 0;

assign FL1_D2_D	= 0;
assign FL1_D2_nRE	= 1;
assign FL1_D2_DE	= 0;

assign FH1_C2_D	= 0;
assign FH1_C2_nRE	= 1;
assign FH1_C2_DE	= 0;

assign FH2_C2_D	= 0;
assign FH2_C2_nRE	= 1;
assign FH2_C2_DE	= 0;

assign FH4_D1_D	= 0;
assign FH4_D1_nRE	= 1;
assign FH4_D1_DE	= 0;

assign FH4_C1_D	= 0;
assign FH4_C1_nRE	= 1;
assign FH4_C1_DE	= 0;

assign FL3_D1_D	= 0;
assign FL3_D1_nRE	= 1;
assign FL3_D1_DE	= 0;

assign FH4_D2_D	= 0;
assign FH4_D2_nRE	= 1;
assign FH4_D2_DE	= 0;

assign FL3_D2_D	= 0;
assign FL3_D2_nRE	= 1;
assign FL3_D2_DE	= 0;

assign FH4_C2_D	= 0;
assign FH4_C2_nRE	= 1;
assign FH4_C2_DE	= 0;


assign SDRAM_CLK  = CLK_60_S; 
assign FU_D[7:0] = (FOE == 1) ? FIFO_TO_FTDI_Q : 8'hzz;
assign FODD  = 1;
assign FSIWU = 1;
assign FUSB_nRES = 1;

wire CLK_60 = FCLK_OUT;

pll PLL
(
	.inclk0(CLK_60), 
	.c0(CLK_60_S),
	.c1(STP_CLK_60x8_480),
);

reset_controller RST_CTRL (
	.clk(CLK_60),
	.n_rst(N_RST)
);

ftdi_controller FTDI_CTRL (
	.clk(CLK_60),
	.n_rst(N_RST),
	.oe(FOE),
	.rxf(FRXF),
	.rd(FRD),
	.txe(FTXE),
	.wr(FWR),
	.fifo_tx_rdy(FIFO_TO_FTDI_TX_RDY),
	.ftdi_rx_rdy(FTDI_RX_RDY), 
	.q_asserted(FTDI_Q_ASSERTED)
);

s_gen_controller S_GEN_CTRL (
	.clk(CLK_60),
	.n_rst(N_RST),
	.wrreq(FTDI_Q_ASSERTED),
	.sdram_rfo(SDRAM_RFO),
	.d(FU_D),
	.gen_en(GEN_EN)
);

stream_generator S_GEN (
	.clk(CLK_60),
	.n_rst(N_RST),
	.en(GEN_EN),
	.s32(S32),
	.n32rdy(N32RDY)
);

wire [31:0] S32;

s32s16_adapter S32S16_A (
	.clk(CLK_60),
	.s32(S32),
	.n32rdy(N32RDY),
	.s16(FIFO_TO_SDRAM_DATA),
	.n16rdy(FIFO_TO_SDRAM_WR_REQ)
);

wire [15:0] FIFO_TO_SDRAM_DATA;

fifo FIFO_TO_SDRAM 
(
	.clock(CLK_60),
	.data(FIFO_TO_SDRAM_DATA),
	.rdreq(FIFO_TO_SDRAM_RD_REQ),
	.wrreq(FIFO_TO_SDRAM_WR_REQ),
	.q(SDRAM_DATA),
	.usedw(FIFO_TO_SDRAM_USEDW),
	.full(FIFO_TO_SDRAM_FULL)
);

wire [9:0] FIFO_TO_SDRAM_USEDW;

fifo_to_sdram_rd_controller FIFO_TO_SDRAM_RD_CTRL (
	.clk(CLK_60),
	.fifo_usedw(FIFO_TO_SDRAM_USEDW),
	.fifo_full(FIFO_TO_SDRAM_FULL),
	.fifo_tx_rdy(FIFO_TO_SDRAM_TX_RDY),
	.sdram_rx_rdy(SDRAM_RX_RDY),
	.fifo_rdreq(FIFO_TO_SDRAM_RD_REQ),
	.fifo_q_asserted(FIFO_TO_SDRAM_Q_ASSERTED)
);

wire [15:0] SDRAM_DATA;

SDRAM_controller SDRAM_CTRL 
(
	.clk(CLK_60),
	.n_rst(N_RST),
	
	/***** TO SDRAM *****/
	.CKE(SDRAM_CLKE),
	.nCS(SDRAM_nCS),
	.nWE(SDRAM_nWE),
	.nCAS(SDRAM_nCAS),
	.nRAS(SDRAM_nRAS),
	.A(SDRAM_A),
	.BA(SDRAM_BA),
	.DQML(SDRAM_DQML),
	.DQMH(SDRAM_DQMH),
	.DQ(SDRAM_DQ),
	
	/******* USER ********/
	.data(SDRAM_DATA),
	.fifo_to_sdram_tx_rdy(FIFO_TO_SDRAM_TX_RDY),
	.sdram_rx_rdy(SDRAM_RX_RDY),
	.sdram_q_asserted(SDRAM_Q_ASSERTED),
	.fifo_from_sdram_rx_rdy(FIFO_FROM_SDRAM_RX_RDY),
	.sdram_q(SDRAM_Q),
	.sdram_rfo(SDRAM_RFO)
);

wire [15:0] SDRAM_Q;

fifo FIFO_FROM_SDRAM
(
	.clock(CLK_60),
	.data(SDRAM_Q),
	.rdreq(FIFO_FROM_SDRAM_RDREQ),
	.wrreq(SDRAM_Q_ASSERTED),
	.q(FIFO_FROM_SDRAM_Q_16),
	.usedw(FIFO_FROM_SDRAM_USEDW),
	.full(FIFO_FROM_SDRAM_FULL)
);

wire [9:0] FIFO_FROM_SDRAM_USEDW;
wire [15:0] FIFO_FROM_SDRAM_Q_16;

fifo_from_sdram_controller FIFO_FROM_SDRAM_CTRL
(
	.clk(CLK_60),
	.fifo_usedw(FIFO_FROM_SDRAM_USEDW),
	.fifo_full(FIFO_FROM_SDRAM_FULL),
	.fifo_rdreq(FIFO_FROM_SDRAM_RDREQ),
	.byte_switcher(BYTE_SWITCHER),
	.fifo_q_asserted(FIFO_FROM_SDRAM_Q_ASSERTED),
	.this_rx_rdy(FIFO_FROM_SDRAM_RX_RDY),
	.next_rx_rdy(FIFO_TO_FTDI_RX_RDY)
);

s16s8_adapter S16S8_A(
	.byte_switcher(BYTE_SWITCHER),
	.s16(FIFO_FROM_SDRAM_Q_16),
	.s8(FIFO_FROM_SDRAM_Q_8)
);

wire [7:0] FIFO_FROM_SDRAM_Q_8;

fifo8 FIFO_TO_FTDI (
	.clock(CLK_60),
	.wrreq(FIFO_FROM_SDRAM_Q_ASSERTED),
	.rdreq(FIFO_TO_FTDI_RDREQ),
	.data(FIFO_FROM_SDRAM_Q_8),
	.q(FIFO_TO_FTDI_Q),
	.usedw(FIFO_TO_FTDI_USEDW),
	.full(),
	.empty()
);

wire [10:0] FIFO_TO_FTDI_USEDW;
wire [7:0] FIFO_TO_FTDI_Q;

fifo_to_ftdi_controller FIFO_TO_FTDI_CTRL(
	.clk(CLK_60),
	.fifo_usedw(FIFO_TO_FTDI_USEDW),
	.fifo_rdreq(FIFO_TO_FTDI_RDREQ),
	.fifo_tx_rdy(FIFO_TO_FTDI_TX_RDY),
	.fifo_rx_rdy(FIFO_TO_FTDI_RX_RDY),
	.ftdi_rx_rdy(FTDI_RX_RDY)
);


//err_check_t1 ERR_CHECK_FROM_SDRAM (
//	.clk(CLK_60),
//	.data(SDRAM_DQ),
//	.wren(SDRAM_Q_ASSERTED),
//	.err()
//);
//
//err_check_t2 ERR_CHECK_FIFO_FROM_SDRAM (
//	.clk(CLK_60),
//	.data(FIFO_FROM_SDRAM_Q_16),
//	.wren(FIFO_FROM_SDRAM_Q_ASSERTED),
//	.err()
//);
//
//err_check_t1 ERR_CHECK_TO_SDRAM (
//	.clk(CLK_60),
//	.data(SDRAM_DQ),
//	.wren(FIFO_TO_SDRAM_Q_ASSERTED),
//	.err()
//);

endmodule
