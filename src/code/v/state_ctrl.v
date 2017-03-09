module state_controller (
	input clk,
	input n_rst,
	output reg [2:0] sdram_state,
	
	input [9:0] uni_time,
	output reg rst_uni_time,
	
	input fifo_to_sdram_tx_rdy, 
	input refs_cd_is_over,
	input rst_ref_cnt,
	input its_fr_time,
	input fifo_from_sdram_rx_rdy,
	input sdram_is_empty
);

parameter OFF = 0,
			 ON  = 1;

`include "C:/Users/dell/Documents/Quartus/usb_test/src/code/vh/sdram_states.vh"

			 
always@(posedge clk or negedge n_rst)
begin
	if(n_rst == 0)
		begin
			reset();
		end
	else
		begin
			case (sdram_state)
			`SDRAM_STATE_INIT:
				begin
					init();
				end
			`SDRAM_STATE_FORCE_REFRESH:
				begin
					force_refresh();
				end
			`SDRAM_STATE_CONTROL:
				begin
					control();
				end
			`SDRAM_STATE_WRITE:
				begin
					write();
				end
			`SDRAM_STATE_READ:
				begin
					read();
				end
			`SDRAM_STATE_REFRESH:
				begin
					refresh();
				end
			default:
				begin
					
				end
			endcase
		end
end

wire INI_IS_DONE = (uni_time == 15);
wire WR_IS_DONE  = (uni_time == 516);//// 517
wire RD_IS_DONE  = (uni_time == 518);
wire REF_IS_DONE = (uni_time == 3);
wire FREF_IS_DONE = (uni_time == 7);

task reset;
begin
	sdram_state = `SDRAM_STATE_INIT; 
	rst_uni_time = ON;
end
endtask

task init;
begin
	if(INI_IS_DONE)
		begin
			rst_uni_time = ON;
			sdram_state = `SDRAM_STATE_CONTROL;
		end
	else
		begin
			rst_uni_time = OFF;
		end
end
endtask
 
task write;
begin
	if(WR_IS_DONE)
		begin
			rst_uni_time = ON;
			sdram_state = `SDRAM_STATE_CONTROL;
		end
	else
		begin
			rst_uni_time = OFF;
		end
end
endtask
 
task read;
begin
	if(RD_IS_DONE)
		begin
			rst_uni_time = ON;
			sdram_state = `SDRAM_STATE_CONTROL;
		end
	else
		begin
			rst_uni_time = OFF;
		end
end
endtask

task refresh;
begin
	if(REF_IS_DONE)
		begin
			rst_uni_time = ON;
			sdram_state = `SDRAM_STATE_CONTROL;
		end
	else
		begin
			rst_uni_time = OFF;
		end
end
endtask

task control;
begin
	if((~refs_cd_is_over) && its_fr_time)
		begin
			rst_uni_time = OFF;
			sdram_state = `SDRAM_STATE_FORCE_REFRESH;
		end
	else if(fifo_to_sdram_tx_rdy)
		begin
			rst_uni_time = OFF;
			sdram_state = `SDRAM_STATE_WRITE;
		end
	else if((~sdram_is_empty) && fifo_from_sdram_rx_rdy)
		begin
			rst_uni_time = OFF;
			sdram_state = `SDRAM_STATE_READ;
		end
	else if(~refs_cd_is_over)
		begin
			rst_uni_time = OFF;
			sdram_state = `SDRAM_STATE_REFRESH;
		end
end
endtask


task force_refresh;
begin
	if(REF_IS_DONE)
		begin
			if(refs_cd_is_over)
				begin
					rst_uni_time = OFF;
					sdram_state = `SDRAM_STATE_FORCE_REFRESH;
				end
			else	
				begin
					rst_uni_time = ON;
					sdram_state = `SDRAM_STATE_FORCE_REFRESH;
				end
		end
	else if(FREF_IS_DONE) 
		begin
			rst_uni_time = ON;
			sdram_state = `SDRAM_STATE_CONTROL;
		end
	else
		begin
			rst_uni_time = OFF;
			sdram_state = `SDRAM_STATE_FORCE_REFRESH;
		end
end
endtask
			 
			
endmodule