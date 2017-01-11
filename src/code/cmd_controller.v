module command_controller (
	input clk,
	input wire[3:0] cmd_to_assert, 
	
	output reg c_nCS,
	output reg c_nRAS, 
	output reg c_nCAS, 
	output reg c_nWE,  
	output reg c_DQML, 
	output reg c_DQMH  
);

`include "C:/Users/dell/Documents/Quartus/usb_test/src/code/commands.vh"
			 
always@(posedge clk)
begin
	case(cmd_to_assert)
		`CMD_COMMAND_INHIBIT: 	 COMMAND_INHIBIT();
		`CMD_NOP: 					 NOP();
		`CMD_ACTIVE:				 ACTIVE();
		`CMD_READ:					 READ();
		`CMD_WRITE:					 WRITE();
		`CMD_PRECHARGE:			 PRECHARGE();
		`CMD_BURST_TERMINATE:	 BURST_TERMINATE;
		`CMD_AUTO_REFRESH:		 AUTO_REFRESH;
		`CMD_LOAD_MODE_REGISTER: LOAD_MODE_REGISTER;
		default:						 NOP();
	endcase
end			 
			 
task COMMAND_INHIBIT; 
	begin
		c_nCS  = 1;
		c_nRAS = 0; 
		c_nCAS = 0;  
		c_nWE  = 0; 
		c_DQML = 0; 
		c_DQMH = 0;
	end
endtask

task NOP;
	begin
		c_nCS  = 0;
		c_nRAS = 1;
		c_nCAS = 1;
		c_nWE  = 1;
		c_DQML = 0; 
		c_DQMH = 0; 
	end
endtask

task ACTIVE;
	begin
		c_nCS  = 0;
		c_nRAS = 0;
		c_nCAS = 1;
		c_nWE  = 1;
		c_DQML = 0;  
		c_DQMH = 0; 
	end
endtask

task READ;
	begin
		c_nCS  = 0;
		c_nRAS = 1;
		c_nCAS = 0;
		c_nWE  = 1;
		c_DQML = 0; // low level is active  
		c_DQMH = 0; 
	end
endtask

task WRITE;
	begin
		c_nCS  = 0;
		c_nRAS = 1;
		c_nCAS = 0;
		c_nWE  = 0;
		c_DQML = 0;  
		c_DQMH = 0; 
	end
endtask

task BURST_TERMINATE;
	begin
		c_nCS  = 0;
		c_nRAS = 1;
		c_nCAS = 1;
		c_nWE  = 0;
		c_DQML = 0; // X 
		c_DQMH = 0; // X
	end
endtask

task PRECHARGE;
	begin
		c_nCS  = 0;
		c_nRAS = 0;
		c_nCAS = 1;
		c_nWE  = 0;
		c_DQML = 0; // X 
		c_DQMH = 0; // X
	end
endtask


task AUTO_REFRESH;
	begin
		c_nCS  = 0;
		c_nRAS = 0;
		c_nCAS = 0;
		c_nWE  = 1;
		c_DQML = 0; // X 
		c_DQMH = 0; // X
	end
endtask

task LOAD_MODE_REGISTER;
	begin
		c_nCS  = 0;
		c_nRAS = 0;
		c_nCAS = 0;
		c_nWE  = 0;
		c_DQML = 0; // X 
		c_DQMH = 0; // X
	end
endtask


endmodule
