module SDRAM_controller (
	
	input  clk,
	input  n_rst,
	
	/**** TO SDRAM ****/
	output CKE,
	output nCS,
	output nWE,
	output nCAS,
	output nRAS,
	output [12:0] A,
	output [1:0]  BA,
	output DQML,
	output DQMH,
	inout [15:0] DQ,
	
	
	/* USER INTERFACE */
	input [15:0] data,

	output sdram_rfo, 	// Ready For Operation, выставляется по завершению инициализации sdram
	
	input  fifo_to_sdram_tx_rdy,			// FIFO готов передавать данные
	
	output sdram_rx_rdy,  	// SDRAM готова принимать данные 
	output sdram_q_asserted,
	input fifo_from_sdram_rx_rdy,
	output [15:0] sdram_q,
	output sdram_full,
	output sdram_empty
);

`include "C:/Users/dell/Documents/Quartus/usb_test/src/code/vh/sdram_states.vh"

assign sdram_full  		= SDRAM_IS_FULL;
assign sdram_empty 		= SDRAM_IS_EMPTY;
assign sdram_rfo		   = SDRAM_RFO;
assign sdram_rx_rdy 		= SDRAM_RX_RDY;
assign sdram_q_asserted = SDRAM_Q_ASSERTED;

assign DQ = (SDRAM_STATE == `SDRAM_STATE_WRITE)? data : 16'hzzzz;
assign sdram_q = sdram_q_asserted ? DQ : 16'h0000;


refresh_period_timer REF_TIM (
	.clk(clk),
	.n_rst(n_rst),
	.en(SDRAM_RFO),
	.rst_ref_cnt(RST_REF_CNT),
	.its_fr_time(ITS_FR_TIME)
);

refreshes_counter REF_CNT (
	.n_rst(n_rst & (~RST_REF_CNT)),
	.incr_refs_cnt(INCR_REFS_CNT),
	.refs_cd_is_over(CD_IS_OVER)
);

universal_timer UNI_TIM (
	.clk(clk),
	.n_rst(n_rst & (~RST_UNI_TIME)),
	.uni_time(UNI_TIME)
);

wire [9:0] UNI_TIME;


abc_controller ABC_CTRL (
	.clk(clk),
	.n_rst(n_rst),
	.sdram_state(SDRAM_STATE),
	.uni_time(UNI_TIME),
	.CKE(CKE),
	.nCS(nCS),
	.nWE(nWE),
	.nCAS(nCAS),
	.nRAS(nRAS),
	.A(A),
	.BA(BA),
	.DQML(DQML),
	.DQMH(DQMH),
	.incr_refs_cnt(INCR_REFS_CNT),
	.sdram_rfo(SDRAM_RFO),
	.sdram_rx_rdy(SDRAM_RX_RDY),
	.sdram_q_asserted(SDRAM_Q_ASSERTED),
	.sdram_full(SDRAM_IS_FULL),
	.sdram_empty(SDRAM_IS_EMPTY)
);

state_controller ST_CTRL (
	.clk(clk),
	.n_rst(n_rst),
	.sdram_state(SDRAM_STATE),
	.uni_time(UNI_TIME),
	.rst_uni_time(RST_UNI_TIME),
	.fifo_to_sdram_tx_rdy(fifo_to_sdram_tx_rdy),
	.refs_cd_is_over(CD_IS_OVER),
	.rst_ref_cnt(RST_REF_CNT),
	.its_fr_time(ITS_FR_TIME),
	.fifo_from_sdram_rx_rdy(fifo_from_sdram_rx_rdy),
	.sdram_is_empty(SDRAM_IS_EMPTY)
);


wire [2:0] SDRAM_STATE; 

//assign sdram_full = ((rd_ptr == wr_ptr + 1));
//assign sdram_empty = SDRAM_IS_EMPTY;
//
//`include "C:/Users/dell/Documents/Quartus/usb_test/src/code/commands.vh"
//`include "C:/Users/dell/Documents/Quartus/usb_test/src/code/mode_reg_defs.vh"
//
//reg[3:0] cmd;
//
//`define WR_BANK	wr_ptr[14:13] 
//`define WR_ROW		wr_ptr[12:0]
//
//`define RD_BANK	rd_ptr[14:13]
//`define RD_ROW		rd_ptr[12:0]
//
//reg[14:0] wr_ptr;
//reg[14:0] rd_ptr;
//
//assign SDRAM_IS_EMPTY = (wr_ptr == rd_ptr);
//
//assign DQ = (sdram_state == SDRAM_STATE_WRITE)? data : 16'hzzzz;
//
//assign sdram_q_asserted = (4 < rd_time) && (rd_time < 517);
//
//assign sdram_q = sdram_q_asserted ? DQ : 16'h0000;
//
//
//command_controller cmd_c (
//	.clk(clk),
//	.cmd_to_assert(cmd),
//	.c_nCS(nCS),
//	.c_nRAS(nRAS),
//	.c_nCAS(nCAS),
//	.c_nWE(nWE),
//	.c_DQML(DQML),
//	.c_DQMH(DQMH)
//);
//
//
//
//parameter OFF = 0,
//			 ON  = 1;
//			 
//parameter FALSE = 0,
//			 TRUE  = 1;
//
///*************** SDRAM INIT TIMER ***************/
//
//// clk = 60 MHz
//parameter CMD_ASSERT_TIME_OFFSET = 1;
//
//parameter //t100us = 4800 - 1 - CMD_ASSERT_TIME_OFFSET,
//			 t100us = 6000 - 1 - CMD_ASSERT_TIME_OFFSET,
//			 tCK	  = 1,
//          tRP    = 2,
//          tRFC   = 5, // 4
//          tMRD   = 2,
//			 SDRAM_init_time = t100us + tCK + tRP + 2*tRFC + tMRD;
//
//reg[15:0] time_ini;
//
//always@(posedge clk or negedge n_rst)
//begin
//	if(n_rst == 0)
//		begin
//			time_ini = 0;
//		end
//	else 
//		begin
//			if(time_ini < SDRAM_init_time)
//				begin
//					time_ini = time_ini + 1;
//				end
//		end
//end
//
//
///************** SDRAM REFRESH PERIOD TIMER **************/
//
//// Refresh period = 64 ms
//reg [21:0] refresh_period_time;
////parameter REFRESH_PERIOD = 3072000 - 1;
//parameter REFRESH_PERIOD = 3840000 - 1;
//
//
//always@(posedge clk or negedge n_rst)
//begin
//	if(n_rst == 0)
//		begin
//			refresh_period_time = 0;
//		end
//	else 
//		begin
//			if(sdram_rfo == ON)
//				begin
//					if(refresh_period_time < REFRESH_PERIOD)
//						begin
//							refresh_period_time = refresh_period_time + 1;
//							RESET_REFRESH_COUNTER = OFF;
//						end
//					else 
//						begin
//							refresh_period_time = 0;
//							RESET_REFRESH_COUNTER	= ON;
//						end
//				end
//			else 
//				refresh_period_time = 0;
//		end
//end
//
///************ MAIN MACHINE ************/	
//
//reg [2:0] sdram_state;
//parameter SDRAM_STATE_INIT 			= 0,
//			 SDRAM_STATE_FORCE_REFRESH = 1,
//			 SDRAM_STATE_CONTROL 		= 2,
//			 SDRAM_STATE_WRITE			= 3,
//			 SDRAM_STATE_READ	   		= 4,
//			 SDRAM_STATE_REFRESH 		= 5;
//			 
//reg RESET_REFRESH_COUNTER;			 
//
//always@(posedge clk or negedge n_rst)
//begin
//	if(n_rst == OFF)
//		begin
//			reset_sdram_controller();
//		end
//	else
//		begin
//			if(RESET_REFRESH_COUNTER == ON)
//				begin
//					reset_refresh_counter();
//				end
//			else	
//				begin
//					case(sdram_state)
//						SDRAM_STATE_INIT:
//							begin
//								sdram_init();
//							end
//						SDRAM_STATE_FORCE_REFRESH:
//							begin
//								sdram_force_refresh();
//							end
//						SDRAM_STATE_CONTROL:
//							begin
//								sdram_state_control();
//							end
//						SDRAM_STATE_WRITE:
//							begin
//								sdram_write();
//							end
//						SDRAM_STATE_READ:
//							begin
//								sdram_read();
//							end
//						SDRAM_STATE_REFRESH:
//							begin
//								sdram_refresh();
//							end
//						default: 
//							begin
//								sdram_state_control();
//							end
//					endcase 
//				end
//		end
//end
//
//
///************** RESET SDRAM CONTROLLER **************/
//
//task reset_sdram_controller;
//	begin
//		CKE = OFF;
//		sdram_rfo = OFF;
//		A   = 0;
//		BA  = 0;
//		wr_ptr = 0;		
//		rd_ptr = 0;
//		//sdram_q_asserted = OFF;
//		sdram_state = SDRAM_STATE_INIT;	
//	end
//endtask
//
//
///************** RESET REFRESH COUNTER **************/
//
//task reset_refresh_counter;
//	begin
//		refresh_counter = 0;
//	end
//endtask
//
//
///************** SDRAM IINIT **************/
//
//parameter ADDR_ASSERT_TIME_OFFSET = 1; 
//
//task sdram_init;
//	begin
//		case(time_ini)
//			(t100us - tCK):				
//				begin
//					CKE = ON;
//				end
//			(t100us + tCK):
//				begin
//					cmd = `CMD_PRECHARGE;
//				end
//			(t100us + tCK + ADDR_ASSERT_TIME_OFFSET):
//				begin
//					A[10] = ON; 		// All banks precharged
//					cmd = `CMD_NOP;	
//				end
//			(t100us + tCK + tRP):
//				begin
//					A = 0;
//					cmd = `CMD_AUTO_REFRESH;
//				end
//			(t100us + tCK + tRP + tRFC):
//				begin
//					cmd = `CMD_AUTO_REFRESH;
//				end
//			(t100us + tCK + tRP + 2*tRFC):
//				begin
//					cmd = `CMD_LOAD_MODE_REGISTER;
//				end
//			(t100us + tCK + tRP + 2*tRFC + ADDR_ASSERT_TIME_OFFSET):
//				begin
//					BA[0] = OFF;
//					BA[1] = OFF;
//					`write_burst_mode = `WRITE_BURST_MODE_PROGRAMMED_BURST_LENGTH;
//					`operating_mode 	= `OPERATING_MODE_STANDARD; 
//					`cas_latency 		= `CAS_LATENCY_2;
//					`burst_type 		= `BURST_TYPE_SEQUENTIAL;
//					`burst_length 		= `BURST_LENGTH_FULL_PAGE;
//					cmd = `CMD_NOP;
//				end	
//			SDRAM_init_time:
//				begin
//					sdram_rfo = ON;
//					sdram_state = SDRAM_STATE_CONTROL;
//					A = 0;
//				end
//			default:
//				begin	
//					cmd = `CMD_NOP;
//				end
//		endcase
//	end
//endtask
//
//
///************** SDRAM STATE CONTROL **************/
//
//reg [13:0] refresh_counter;
//parameter REFRESHES_PER_tRFC = 8192;
//parameter FORCE_REFRESH_TIME = (REFRESH_PERIOD - (REFRESHES_PER_tRFC*4));
//
//task sdram_state_control;
//	begin
//		if((refresh_counter < REFRESHES_PER_tRFC) && (refresh_period_time >= FORCE_REFRESH_TIME))
//			begin
//				cmd = `CMD_AUTO_REFRESH;
//				refresh_counter = refresh_counter + 1;
//				sdram_state = SDRAM_STATE_FORCE_REFRESH;
//			end
//		else if(fifo_tx_rdy == ON)
//			begin
//				cmd = `CMD_ACTIVE;
//				sdram_state = SDRAM_STATE_WRITE;
//			end
//		else if((SDRAM_IS_EMPTY == FALSE) && (next_rx_rdy == ON))
//			begin
//				cmd = `CMD_ACTIVE;
//				sdram_state = SDRAM_STATE_READ;
//			end
//		else if(refresh_counter < REFRESHES_PER_tRFC)
//			begin
//				cmd = `CMD_AUTO_REFRESH;
//				refresh_counter = refresh_counter + 1;
//				sdram_state = SDRAM_STATE_REFRESH;
//			end
//	end
//endtask 
//
///************** SDRAM PAGE WRITE TIMER **************/ 
//
//reg [9:0] wr_time;
//parameter PAGE_WRITE_PERIOD = 512 + 2;
//
//parameter tSDRAM_RX_RDY 	= 0,
//			 tCMD_WR 			= tSDRAM_RX_RDY + 1,
//			 tCMD_BT_W 			= PAGE_WRITE_PERIOD - 1,
//			 tCMD_PRC_W 		= tCMD_BT_W + 1,
//			 tWRITE_COMPLETE 	= tCMD_PRC_W + tRP;  
//			 
//always@(posedge clk or negedge n_rst)
//begin
//	if(n_rst == 0)
//		begin
//			wr_time = 0;
//		end
//	else 
//		begin
//			if(sdram_state == SDRAM_STATE_WRITE)
//				begin
//					if(wr_time < tWRITE_COMPLETE)
//						begin
//							wr_time = wr_time + 1;
//						end
//					else
//						begin
//							wr_time = 0;
//						end
//				end
//			else 
//				begin
//					wr_time = 0;
//				end
//		end
//end
//
//
///************** SDRAM WRITE **************/ 
//
//task sdram_write;
//	begin
//		case(wr_time)
//			tSDRAM_RX_RDY:
//				begin
//					A  <= `WR_ROW;			
//					BA <= `WR_BANK;			
//					cmd <= `CMD_NOP;
//					sdram_rx_rdy <= ON;
//				end
//			tCMD_WR:
//				begin
//					A <= 0;					
//					cmd <= `CMD_WRITE;
//				end
//			tCMD_BT_W:
//				begin
//					sdram_rx_rdy <= OFF;
//					cmd <= `CMD_BURST_TERMINATE;
//				end
//			tCMD_PRC_W:
//				begin
//					cmd <= `CMD_PRECHARGE;
//				end
//			tWRITE_COMPLETE:
//				begin
//					wr_ptr <= wr_ptr + 1;		
//					cmd <= `CMD_NOP;
//					sdram_state <= SDRAM_STATE_CONTROL;
//				end
//			default:
//				begin
//					cmd <= `CMD_NOP;
//				end
//		endcase
//	end
//endtask
//
//
///************** SDRAM PAGE READ TIMER **************/ 
//
//reg [9:0] rd_time;
//parameter PAGE_READ_PERIOD = 512 + 4;
//parameter tCMD_ACT_R		 = 0,
//			 tCMD_RD        = tCMD_ACT_R + 1,
//			 tDATA_OUT   	 = tCMD_RD + 3,
//			 tCMD_BT_R      = PAGE_READ_PERIOD - 1,
//			 tCMD_PRC_R     = tCMD_BT_R + 1,
//			 tREAD_COMPLETE = tCMD_PRC_R + tRP;
//
//always@(posedge clk or negedge n_rst)
//begin
//	if(n_rst == 0)
//		begin
//			rd_time = 0;
//		end
//	else 
//		begin
//			if(sdram_state == SDRAM_STATE_READ)
//				begin
//					if(rd_time < (tREAD_COMPLETE + 1))
//						begin
//							rd_time = rd_time + 1;
//						end
//					else 
//						begin
//							rd_time = 0;
//						end
//				end
//			else 
//				begin
//					rd_time = 0;
//				end
//		end
//end
//
//
////wire tRD_BT = (rd_time == 515 + 1);
////wire tRD_PRC = (rd_time == 516 + 1);
////wire tRD_COMPLETE = (rd_time == 518 + 1);
////wire tRD_A_BA = ((sdram_state == SDRAM_STATE_READ) && (rd_time == 0)); 
////wire tRD = (rd_time == 1);
////
////
////task sdram_read;
////	begin
////		if(tRD_A_BA)
////			begin
////				A  = `RD_ROW;			
////				BA = `RD_BANK;
////				cmd = `CMD_NOP;
////			end
////		else if(tRD)
////			begin
////				A = 0;
////				cmd = `CMD_READ;
////			end
////		else if(tRD_BT)
////			begin
////				cmd = `CMD_BURST_TERMINATE;
////			end
////		else if(tRD_PRC)
////			begin
////				cmd = `CMD_PRECHARGE;
////			end
////		else if(tRD_COMPLETE)
////			begin
////				rd_ptr = rd_ptr + 1;		
////				sdram_state = SDRAM_STATE_CONTROL;
////			end
////		else
////			begin	
////				cmd = `CMD_NOP;
////			end
////	end
////endtask
//
///************** SDRAM READ **************/ 
//
//task sdram_read;
//	begin
//		case(rd_time)
//			tCMD_ACT_R:						
//				begin							
//					A  <= `RD_ROW;			
//					BA <= `RD_BANK;			
//					cmd <= `CMD_NOP; 		
//				end							
//			tCMD_RD:
//				begin
//					A <= 0;					
//					cmd <= `CMD_READ;
//				end
//			tDATA_OUT:
//				begin
//				 //sdram_q_asserted = ON;
//				end
//			tCMD_BT_R:
//				begin
//					cmd <= `CMD_BURST_TERMINATE;
//				end
//			tCMD_PRC_R:
//				begin
//					cmd <= `CMD_PRECHARGE;
//				 //sdram_q_asserted = OFF;
//				end
//			tREAD_COMPLETE:
//				begin
//					cmd <= `CMD_NOP;
//					rd_ptr <= rd_ptr + 1;		
//					sdram_state <= SDRAM_STATE_CONTROL;
//				end
//			default:
//				begin
//					cmd <= `CMD_NOP;
//				end
//		endcase
//	end
//endtask
//
//
///************** SDRAM REFRESH **************/
//
//reg [1:0] refresh_time; 
//parameter REFRESH_TIME = 3;
//
//task sdram_refresh;
//	begin
//		if(refresh_time < REFRESH_TIME)
//			begin
//				cmd = `CMD_NOP;
//				refresh_time = refresh_time + 1;
//			end
//		else 
//			begin
//				refresh_time = 0;
//				sdram_state = SDRAM_STATE_CONTROL;
//			end
//	end
//endtask
//
//
///************** SDRAM FORCE REFRESH **************/
//
//task sdram_force_refresh;
//	begin
//		if(refresh_time < REFRESH_TIME)
//			begin
//				cmd = `CMD_NOP;
//				refresh_time = refresh_time + 1;
//			end
//		else 
//			begin
//				refresh_time = 0;
//				if(refresh_counter == REFRESHES_PER_tRFC)
//					begin
//						sdram_state = SDRAM_STATE_CONTROL;
//					end
//				else 
//					begin
//						cmd = `CMD_AUTO_REFRESH;
//						refresh_counter = refresh_counter + 1;
//					end
//			end
//	end
//endtask


endmodule


