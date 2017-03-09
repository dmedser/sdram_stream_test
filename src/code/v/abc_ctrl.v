module abc_controller (
	input clk,
	input n_rst,
	input [2:0] sdram_state,
	input [9:0] uni_time,
	
	output reg CKE,
	output reg nCS,
	output reg nWE,
	output reg nCAS,
	output reg nRAS,
	output reg [12:0] A,
	output reg [1:0]  BA,
	output DQML,
	output DQMH,
	
	output reg incr_refs_cnt,
	output reg sdram_rfo,
	output reg sdram_rx_rdy,
	output reg sdram_q_asserted,
	output sdram_full,
	output sdram_empty
);

`include "C:/Users/dell/Documents/Quartus/usb_test/src/code/vh/sdram_states.vh"
`include "C:/Users/dell/Documents/Quartus/usb_test/src/code/vh/mode_reg_defs.vh"

assign DQML = 0;
assign DQMH = 0;

pointers PTRS (
	.incr_wr_ptr(incr_wr_ptr),
	.incr_rd_ptr(incr_rd_ptr),
	.n_rst(n_rst),
	.wr_row(WR_ROW),
	.wr_bank(WR_BANK),
	.rd_row(RD_ROW),
	.rd_bank(RD_BANK),
	.sdram_empty(SDRAM_EMPTY)
);

wire [1:0]  WR_BANK;
wire [12:0] WR_ROW;

wire [1:0]  RD_BANK;
wire [12:0] RD_ROW;

reg incr_wr_ptr;
reg incr_rd_ptr;

assign sdram_empty = SDRAM_EMPTY;

always@(posedge clk or negedge n_rst)
begin
	if(n_rst == 0)
		begin
			incr_wr_ptr = 0;
			incr_rd_ptr = 0;
			CKE = 0;
			A = 0;
			BA = 0;
			NOP();
			sdram_rfo = 0;
		end
	else
		begin
			case (sdram_state)
			`SDRAM_STATE_INIT:
				begin
					case(uni_time)
						0: 
							begin
								CKE = 1;
							end
						1: 
							begin
								PRECHARGE();
								A[10] = 1;
							end
						2:
							begin
								NOP();
								A[10] = 0;
							end
						3:
							begin
								AUTO_REFRESH();
							end
						4:
							begin
								NOP();
							end
						8:
							begin
								AUTO_REFRESH();
							end
						9:
							begin
								NOP();
							end
						13:	
							begin
								LOAD_MODE_REGISTER();
								`write_burst_mode = `WRITE_BURST_MODE_PROGRAMMED_BURST_LENGTH;
								`operating_mode 	= `OPERATING_MODE_STANDARD; 
								`cas_latency 		= `CAS_LATENCY_2;
								`burst_type 		= `BURST_TYPE_SEQUENTIAL;
								`burst_length 		= `BURST_LENGTH_FULL_PAGE;
							end	
						14:
							begin
								NOP();
								A = 0;
								sdram_rfo = 1;
							end
						default:
							begin	
								NOP();
							end
					endcase
				end
			`SDRAM_STATE_FORCE_REFRESH:
				begin
					case(uni_time)
					1:
						begin
							AUTO_REFRESH();
							incr_refs_cnt = 1;
						end
					default: 
						begin
							NOP();
							incr_refs_cnt = 0;
						end
					endcase 
				end
			`SDRAM_STATE_CONTROL:
				begin
					NOP();
				end
			`SDRAM_STATE_WRITE:
				begin
					case(uni_time)
						0:
							begin
								sdram_rx_rdy = 1;
								ACTIVE();			
								A  = WR_ROW;			
								BA = WR_BANK;	
							end
						1:
							begin
								NOP();
								A = 0;
							end
						2:
							begin
								WRITE();
							end
						513:
							begin
								sdram_rx_rdy = 0;
							end
						514: 
							begin
								BURST_TERMINATE();
							end
						515: 
							begin
								PRECHARGE();
								incr_wr_ptr = 1;
							end
						default:
							begin
								NOP();
								incr_wr_ptr = 0;
							end
					endcase
				end
			`SDRAM_STATE_READ:
				begin
					case(uni_time)
						0:
							begin
								ACTIVE();			
								A  = RD_ROW;			
								BA = RD_BANK;	
							end
						1:
							begin
								NOP();
								A = 0;
							end
						2:
							begin
								READ();
							end
						4:
							begin
								sdram_q_asserted = 1;
							end
						516:
							begin
								BURST_TERMINATE();
								sdram_q_asserted = 0;
							end
						517:
							begin
								PRECHARGE();
								incr_rd_ptr = 1;
							end
						default:
							begin
								NOP();
								incr_rd_ptr = 0;
							end
					endcase
				end
			`SDRAM_STATE_REFRESH:
				begin
					case(uni_time)
						0: 
							begin
								AUTO_REFRESH();
								incr_refs_cnt = 1;
							end
						default:
							begin
								NOP();
								incr_refs_cnt = 0;
							end
					endcase 
				end
			default:
				begin
				
				end
			endcase
		end
end


task NOP;
	begin
		nCS  = 0;
		nRAS = 1;
		nCAS = 1;
		nWE  = 1;
	end
endtask

task ACTIVE;
	begin
		nCS  = 0;
		nRAS = 0;
		nCAS = 1;
		nWE  = 1;
	end
endtask

task READ;
	begin
		nCS  = 0;
		nRAS = 1;
		nCAS = 0;
		nWE  = 1;
	end
endtask

task WRITE;
	begin
		nCS  = 0;
		nRAS = 1;
		nCAS = 0;
		nWE  = 0;
	end
endtask

task BURST_TERMINATE;
	begin
		nCS  = 0;
		nRAS = 1;
		nCAS = 1;
		nWE  = 0;
	end
endtask

task PRECHARGE;
	begin
		nCS  = 0;
		nRAS = 0;
		nCAS = 1;
		nWE  = 0;
	end
endtask


task AUTO_REFRESH;
	begin
		nCS  = 0;
		nRAS = 0;
		nCAS = 0;
		nWE  = 1;
	end
endtask

task LOAD_MODE_REGISTER;
	begin
		nCS  = 0;
		nRAS = 0;
		nCAS = 0;
		nWE  = 0;
	end
endtask



endmodule