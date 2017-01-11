module SDRAM_controller (
	
	input  clk,
	input  n_rst,
	
	/**** TO SDRAM ****/
	output reg CKE,
	output nCS,
	output nWE,
	output nCAS,
	output nRAS,
	output reg [12:0] A,
	output reg [1:0]  BA,
	output DQML,
	output DQMH,
	inout [15:0] DQ,
	
	
	/* USER INTERFACE */
	input [14:0] addr,
	inout [15:0] data,

	output reg rfo, 	// Ready For Operation, выставляется по готовности после ресета
	
	input  fifo_tx_rdy,			// FIFO готов передавать данные
	output reg sdram_rx_rdy,  	// SDRAM готова принимать данные 
	output reg sdram_q_asserted
);

`include "C:/Users/dell/Documents/Quartus/usb_test/src/code/commands.vh"
`include "C:/Users/dell/Documents/Quartus/usb_test/src/code/mode_reg_defs.vh"

reg[3:0] cmd;
reg SDRAM_IS_EMPTY;

assign DQ = (sdram_state == SDRAM_STATE_WRITE)? data : 16'hzzzz;

command_controller cmd_c (
	.clk(clk),
	.cmd_to_assert(cmd),
	.c_nCS(nCS),
	.c_nRAS(nRAS),
	.c_nCAS(nCAS),
	.c_nWE(nWE),
	.c_DQML(DQML),
	.c_DQMH(DQMH)
);

parameter OFF = 0,
			 ON  = 1;
			 
parameter FALSE = 0,
			 TRUE  = 1;

/*************** SDRAM INIT TIMER ***************/

// clk = 48 MHz
parameter CMD_ASSERT_TIME_OFFSET = 1;

parameter t100us = 4800 - 1 - CMD_ASSERT_TIME_OFFSET,
			 tCK	  = 1,
          tRP    = 2,
          tRFC   = 4,
          tMRD   = 2,
			 SDRAM_init_time = t100us + tCK + tRP + 2*tRFC + tMRD;

reg[15:0] time_ini;

always@(posedge clk or negedge n_rst)
begin
	if(n_rst == 0)
		begin
			time_ini = 0;
		end
	else 
		begin
			if(time_ini < SDRAM_init_time)
				begin
					time_ini = time_ini + 1;
				end
		end
end


/************** SDRAM REFRESH PERIOD TIMER **************/

// Refresh period = 66 ms
reg [21:0] refresh_period_time;
parameter REFRESH_PERIOD = 3072000 - 1;

always@(posedge clk or negedge n_rst)
begin
	if(n_rst == 0)
		begin
			refresh_period_time = 0;
		end
	else 
		begin
			if(rfo == ON)
				begin
					if(refresh_period_time < REFRESH_PERIOD)
						begin
							refresh_period_time = refresh_period_time + 1;
							RESET_REFRESH_COUNTER = OFF;
						end
					else 
						begin
							refresh_period_time = 0;
							RESET_REFRESH_COUNTER	= ON;
						end
				end
			else 
				refresh_period_time = 0;
		end
end

/************ MAIN MACHINE ************/	

reg [2:0] sdram_state;
parameter SDRAM_STATE_INIT 			= 0,
			 SDRAM_STATE_FORCE_REFRESH = 1,
			 SDRAM_STATE_CONTROL 		= 2,
			 SDRAM_STATE_WRITE			= 3,
			 SDRAM_STATE_READ	   		= 4,
			 SDRAM_STATE_REFRESH 		= 5;
			 
reg RESET_REFRESH_COUNTER;			 

always@(posedge clk or negedge n_rst)
begin
	if(n_rst == OFF)
		begin
			reset_sdram_controller();
		end
	else
		begin
			if(RESET_REFRESH_COUNTER == ON)
				begin
					reset_refresh_counter();
				end
			else	
				begin
					case(sdram_state)
						SDRAM_STATE_INIT:
							begin
								sdram_init();
							end
						SDRAM_STATE_FORCE_REFRESH:
							begin
								sdram_force_refresh();
							end
						SDRAM_STATE_CONTROL:
							begin
								sdram_state_control();
							end
						SDRAM_STATE_WRITE:
							begin
								sdram_write();
							end
						SDRAM_STATE_READ:
							begin
								sdram_read();
							end
						SDRAM_STATE_REFRESH:
							begin
								sdram_refresh();
							end
						default: 
							begin
								sdram_state_control();
							end
					endcase 
				end
		end
end


/************** RESET SDRAM CONTROLLER **************/

task reset_sdram_controller;
	begin
		CKE = OFF;
		rfo = OFF;
		A   = 0;
		BA  = 0;
		SDRAM_IS_EMPTY = TRUE;
		sdram_state = SDRAM_STATE_INIT;	
	end
endtask


/************** RESET REFRESH COUNTER **************/

task reset_refresh_counter;
	begin
		refresh_counter = 0;
	end
endtask


/************** SDRAM IINIT **************/

parameter ADDR_ASSERT_TIME_OFFSET = 1; 

task sdram_init;
	begin
		case(time_ini)
			(t100us - tCK):				
				begin
					CKE = ON;
				end
			(t100us + tCK):
				begin
					cmd = `CMD_PRECHARGE;
				end
			(t100us + tCK + ADDR_ASSERT_TIME_OFFSET):
				begin
					A[10] = ON; 		// All banks precharged
					cmd = `CMD_NOP;	// Т.к. не выполнится default
				end
			(t100us + tCK + tRP):
				begin
					A = 0;
					cmd = `CMD_AUTO_REFRESH;
				end
			(t100us + tCK + tRP + tRFC):
				begin
					cmd = `CMD_AUTO_REFRESH;
				end
			(t100us + tCK + tRP + 2*tRFC):
				begin
					cmd = `CMD_LOAD_MODE_REGISTER;
				end
			(t100us + tCK + tRP + 2*tRFC + ADDR_ASSERT_TIME_OFFSET):
				begin
					BA[0] = OFF;
					BA[1] = OFF;
					`write_burst_mode = `WRITE_BURST_MODE_PROGRAMMED_BURST_LENGTH;
					`operating_mode 	= `OPERATING_MODE_STANDARD; 
					`cas_latency 		= `CAS_LATENCY_3;
					`burst_type 		= `BURST_TYPE_SEQUENTIAL;
					`burst_length 		= `BURST_LENGTH_FULL_PAGE;
					cmd = `CMD_NOP;
				end	
			SDRAM_init_time:
				begin
					rfo = ON;
					sdram_state = SDRAM_STATE_CONTROL;
					A = 0;
				end
			default:
				begin	
					cmd = `CMD_NOP;
					A = 0;
				end
		endcase
	end
endtask


/************** SDRAM STATE CONTROL **************/

reg [13:0] refresh_counter;
parameter REFRESHES_PER_tRFC = 8192;
parameter FORCE_REFRESH_TIME = (REFRESH_PERIOD - (REFRESHES_PER_tRFC*4));

task sdram_state_control;
	begin
		if((refresh_counter < REFRESHES_PER_tRFC) && (refresh_period_time >= FORCE_REFRESH_TIME))
			begin
				cmd = `CMD_AUTO_REFRESH;
				refresh_counter = refresh_counter + 1;
				sdram_state = SDRAM_STATE_FORCE_REFRESH;
			end
		else if(fifo_tx_rdy == ON)
			begin
				cmd = `CMD_ACTIVE;
				sdram_rx_rdy = ON;
				sdram_state = SDRAM_STATE_WRITE;
			end
		else if(SDRAM_IS_EMPTY == FALSE)
			begin
				cmd = `CMD_ACTIVE;
				sdram_state = SDRAM_STATE_READ;
			end
	else if(refresh_counter < REFRESHES_PER_tRFC)
			begin
				cmd = `CMD_AUTO_REFRESH;
				refresh_counter = refresh_counter + 1;
				sdram_state = SDRAM_STATE_REFRESH;
			end
	end
endtask 

/************** SDRAM PAGE WRITE TIMER **************/ 

reg [9:0] wr_time;
parameter PAGE_WRITE_PERIOD = 512 + 2;
parameter tWRITE      	  = 2 - 1,
			 tWR_BURST_TERM  = PAGE_WRITE_PERIOD - 1,
			 tWRITE_COMPLETE = PAGE_WRITE_PERIOD + 1 - 1;

always@(posedge clk or negedge n_rst)
begin
	if(n_rst == 0)
		begin
			wr_time = 0;
		end
	else 
		begin
			if(sdram_state == SDRAM_STATE_WRITE)
				begin
					if(wr_time < tWRITE_COMPLETE)
						begin
							wr_time = wr_time + 1;
						end
				end
			else 
				begin
					wr_time = 0;
				end
		end
end


/************** SDRAM WRITE **************/ 

task sdram_write;
	begin
		case(wr_time)
			tWRITE:
				begin
					cmd = `CMD_WRITE;
					SDRAM_IS_EMPTY = FALSE;
				end
			tWR_BURST_TERM:
				begin
					cmd = `CMD_BURST_TERMINATE;
				end
			tWRITE_COMPLETE:
				begin
					cmd = `CMD_NOP;
					sdram_state = SDRAM_STATE_CONTROL;
				end
			default:
				begin
					cmd = `CMD_NOP;
					sdram_rx_rdy = OFF;
				end
		endcase
	end
endtask


/************** SDRAM PAGE READ TIMER **************/ 

reg [9:0] rd_time;
parameter PAGE_READ_PERIOD = 512 + 4;
parameter tREAD       = 2 - 1,
			 tDATA_OUT   = 4 - 1,
			 tRD_BURST_TERM = PAGE_READ_PERIOD - 1,
			 tREAD_COMPLETE = PAGE_READ_PERIOD + 1 - 1;

always@(posedge clk or negedge n_rst)
begin
	if(n_rst == 0)
		begin
			rd_time = 0;
		end
	else 
		begin
			if(sdram_state == SDRAM_STATE_READ)
				begin
					if(wr_time < tREAD_COMPLETE)
						begin
							rd_time = rd_time + 1;
						end
				end
			else 
				begin
					rd_time = 0;
				end
		end
end


/************** SDRAM READ **************/ 

task sdram_read;
	begin
		case(rd_time)
			tREAD:
				begin
					cmd = `CMD_READ;
				end
			tDATA_OUT:
				begin
					sdram_q_asserted = ON;
				end
			tRD_BURST_TERM:
				begin
					cmd = `CMD_BURST_TERMINATE;
					sdram_q_asserted = OFF;
				end
			tREAD_COMPLETE:
				begin
					cmd = `CMD_NOP;
					SDRAM_IS_EMPTY = TRUE;
					sdram_state = SDRAM_STATE_CONTROL;
				end
			default:
				begin
					cmd = `CMD_NOP;
				end
		endcase
	end
endtask


/************** SDRAM REFRESH **************/

reg [1:0] refresh_time; 
parameter REFRESH_TIME = 3;

task sdram_refresh;
	begin
		if(refresh_time < REFRESH_TIME)
			begin
				cmd = `CMD_NOP;
				refresh_time = refresh_time + 1;
			end
		else 
			begin
				refresh_time = 0;
				sdram_state = SDRAM_STATE_CONTROL;
			end
	end
endtask


/************** SDRAM FORCE REFRESH **************/

task sdram_force_refresh;
	begin
		if(refresh_time < REFRESH_TIME)
			begin
				cmd = `CMD_NOP;
				refresh_time = refresh_time + 1;
			end
		else 
			begin
				refresh_time = 0;
				if(refresh_counter == REFRESHES_PER_tRFC)
					begin
						sdram_state = SDRAM_STATE_CONTROL;
					end
				else 
					begin
						cmd = `CMD_AUTO_REFRESH;
						refresh_counter = refresh_counter + 1;
					end
			end
	end
endtask



endmodule


