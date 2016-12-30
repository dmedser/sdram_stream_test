module usb_test (

/*********************** CLK **********************/
		
		input CLK,

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
		
		output  reg FUSB_nRES,
		inout   wire [7:0] FU_D, 
		input   wire FRXF,
		input   wire FPWREN,
		output  reg FODD,
		output  reg FOE,
		output  reg FSIWU,
		output  reg FWR,
		output  reg FRD,
		input   wire FTXE,
		input   wire FCLK_OUT,
		
		
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



/********** SDRAM **********/

//assign SDRAM_A  	= 0;
//assign SDRAM_BA 	= 0;
//assign SDRAM_CLK	 = 0;
//assign SDRAM_CLKE  = 0;
//assign SDRAM_nCS 	 = 1;
//assign SDRAM_DQMH  = 0;
//assign SDRAM_DQ 	 = 0;
//assign SDRAM_nRAS	 = 1;
//assign SDRAM_nCAS	 = 1;
//assign SDRAM_nWE	 = 1;
//assign SDRAM_DQML	 = 0;

/************ TP ************/

//assign TP[6:1] = 0;

/*********** FTDI ***********/
/*	
assign FUSB_nRES = 1;
assign FU_D		  = 0; 
assign FPWREN	  = 0;
assign FODD		  = 0;
assign FOE		  = 0;
assign FSIWU	  = 0;
assign FWR		  = 0;
assign FRD		  = 0;
*/
/************ I2C ************/

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

parameter OFF = 0,
			 ON  = 1;

wire   CLK48M;
//assign SDRAM_CLK = CLK48M;

pll _pll
(
	.inclk0(CLK), 
	.c0(),
	.c1(CLK48M),
	.c2()
);

SDRAM_controller sdram_c 
(
	.clk(CLK48M),
	.n_rst(RESET),
	
	/***** TO SDRAM *****/
	//.CKE(SDRAM_CLKE),
	.CKE(),
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
	.addr(SDRAM_ADDRESS),
	.data(SDRAM_DATA),
	.fifo_tx_rdy(FIFO_TX_RDY),
	.sdram_rx_rdy(SDRAM_RX_RDY),
	.rfo(SDRAM_RFO)
);

wire [15:0] SDRAM_DATA;

wire FIFO_TX_RDY;
wire SDRAM_RX_RDY;

//fifo _fifo_buf 
//(
//	.clock(FCLK_OUT),
//	.data(TO_FIFO_REG),
//	.rdreq(_FIFO_BUF_RD_REQ),
//	.wrreq(_FIFO_BUF_WR_REQ),
//	.empty(_FIFO_BUF_EMPTY),
//	.full(_FIFO_BUF_FULL),
//	.q(_FIFO_BUF_Q),
//	.usedw()
//);


// reg [7:0] TO_FIFO_REG;
//wire [7:0] _FIFO_BUF_Q;
//wire _FIFO_BUF_EMPTY;
//wire _FIFO_BUF_FULL;

// СТРОБ ЗАПИСИ В FTDI 
//wire _FIFO_BUF_RD_REQ = ~WR_DISABLE; // FIFO не пустой, FTXE == 0, FWR == 0, FOE == 1
// СТРОБ ЗАПИСИ В FIFO
//wire _FIFO_BUF_WR_REQ = ~_FIFO_BUF_FULL & (COUNT_STATUS == COUNT_START); // FIFO не полон, COUNT_STATUS == COUNT_START
 
//assign FU_D[7:0] = FOE ? _FIFO_BUF_Q : 8'hzz; // FOE = 0 -> слушать, шина в 3-ем состоянии, ничего в нее не писать   
// -------------------------------------------------------------------------------------------------------------------
//ram_1_port _ram
//(
//	.address(_RAM_ADDR),
//	.clock(FCLK_OUT),
//	.data(TO_RAM_REG),
//	.rden(_RAM_RD_EN),
//	.wren(_RAM_WR_EN),
//	.q(_RAM_Q)
//);
//
//reg [7:0] TO_RAM_REG;
//
//wire _RAM_RD_EN = (ram_state == RAM_STATE_READING);//~WR_DISABLE;
//wire _RAM_WR_EN = (ram_state == RAM_STATE_WRITING);
//
//wire [7:0] _RAM_Q;
//wire [13:0] _RAM_ADDR;
//assign _RAM_ADDR = (ram_state == RAM_STATE_READING)? ram_rd_addr : ram_wr_addr;
//wire RAM_Q_ASSERTED = (ram_state == RAM_STATE_READING) && (byte_counter == 2);
//
//reg [13:0] ram_rd_addr;
//reg [13:0] ram_wr_addr;

assign FU_D[7:0] = 8'hzz;

reg RESET;
reg [7:0] INPUT_REG;

stream_generator gen (
	.clk(CLK48M),
	.n_rst(RESET),
	.enable(ENABLE_GENERATOR),
	.stream_32(STREAM_FROM_GEN_TO_ADAPTER),
	.num_32_rdy(NUM_32_RDY)
);


wire [31:0] STREAM_FROM_GEN_TO_ADAPTER;
wire 			NUM_32_RDY;
wire			ENABLE_GENERATOR = ((count_status == COUNT_START) && (SDRAM_RFO == ON)); 

adapter_32_to_16 adapter (
	.clk(CLK48M),
	.stream_32(STREAM_FROM_GEN_TO_ADAPTER),
	.num_32_rdy(NUM_32_RDY),
	.stream_16(FIFO_TO_SDRAM_DATA),
	.num_16_rdy(FIFO_TO_SDRAM_WR_REQ)
);

fifo fifo_to_sdram 
(
	.clock(CLK48M),
	.data(FIFO_TO_SDRAM_DATA),
	.rdreq(FIFO_TO_SDRAM_RD_REQ),
	.wrreq(FIFO_TO_SDRAM_WR_REQ),
	.empty(FIFO_TO_SDRAM_EMPTY),
	.full(FIFO_TO_SDRAM_FULL),
	.q(SDRAM_DATA),
	.usedw(USEDW)
);

wire [9:0] USEDW;

wire [15:0] FIFO_TO_SDRAM_DATA;
wire 			FIFO_TO_SDRAM_WR_REQ;
wire 			FIFO_TO_SDRAM_EMPTY;
wire 			FIFO_TO_SDRAM_FULL;


fifo_rd_controller fifo_rd_c (
	.clk(CLK48M),
	.usedw(USEDW),
	.fifo_tx_rdy(FIFO_TX_RDY),
	.sdram_rx_rdy(SDRAM_RX_RDY),
	.rdreq(FIFO_TO_SDRAM_RD_REQ)
);



parameter TICKS_IN_4_SEC = 192000000 - 1;
reg[31:0] rst_ticks;

always @(posedge CLK48M)
begin
	if(rst_ticks < TICKS_IN_4_SEC)
		begin
			rst_ticks = rst_ticks + 1;
			RESET = 0;
		end
	else 
		RESET = 1;
end

always @(posedge FCLK_OUT, negedge RESET)
begin	
	if(RESET == 0)
		begin
			FODD  = 1;
			FSIWU = 1;
		end
end


// костыль - иначе при прошивке слетает программатор
initial 
begin  
	FUSB_nRES = 1;
end 


reg count_status;
parameter COUNT_STOP = 0,
			 COUNT_START = 1;
	 
reg [2:0] system_state;
parameter SYS_STATE_COUNT_START_WAIT 		  = 0, 
			 SYS_STATE_READ_FROM_FTDI_PREPARE  = 1, 
			 SYS_STATE_LATCH_DATA_FROM_FTDI 	  = 2,
			 SYS_STATE_DATA_FROM_FTDI_ANALYSIS = 3,
			 SYS_STATE_COUNT_STOP_WAIT 		  = 4;

/************** SYSTEM STATE MACHINE **************/
always@(posedge FCLK_OUT or negedge RESET)
begin
	if(RESET == 0)
		begin
			FWR   = 1;	
			FRD   = 1;
			FOE   = 1;
			INPUT_REG = 0;
			system_state = SYS_STATE_COUNT_START_WAIT;
			count_status = COUNT_STOP;
		end
	else 
		begin
			case(system_state)
				SYS_STATE_COUNT_START_WAIT:
					begin
						if(FRXF == 0)
							begin
								FOE <= 0;
								system_state = SYS_STATE_READ_FROM_FTDI_PREPARE;
							end
						else
							begin
								FOE = 1;
								FRD = 1;
							end
					end
				SYS_STATE_READ_FROM_FTDI_PREPARE: 
					begin
						FRD = 0;
						system_state = SYS_STATE_LATCH_DATA_FROM_FTDI;
					end
				SYS_STATE_LATCH_DATA_FROM_FTDI:
					begin
						INPUT_REG <= FU_D;
						FRD = 1;
						FOE = 1;
						system_state = SYS_STATE_DATA_FROM_FTDI_ANALYSIS;
					end
				SYS_STATE_DATA_FROM_FTDI_ANALYSIS:
					begin
						// СТАТУС СЧИТАН, далее либо запись в FTDI, либо SYS_STATE_COUNT_START_WAIT
						if(INPUT_REG != 0)
							begin
								count_status = COUNT_START;
								system_state = SYS_STATE_COUNT_STOP_WAIT;
							end
						else 
							begin
								count_status = COUNT_STOP;
								system_state = SYS_STATE_COUNT_START_WAIT;
							end
					end
				SYS_STATE_COUNT_STOP_WAIT:
					begin
						if(FRXF == 0)
							begin
								FWR <= 1;	
								FOE <= 0;
								system_state = SYS_STATE_READ_FROM_FTDI_PREPARE;
							end
					end
				default : 				
					system_state <= SYS_STATE_COUNT_START_WAIT;
			endcase
		end
end


endmodule
