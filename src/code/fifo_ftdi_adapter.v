module fifo_ftdi_adapter (
	input      		   clk,
	input      [9:0]  usedw,
	input  	  [15:0] data_from_fifo,
	output 		data_to_ftdi_asserted,
	output 	  [7:0]  data_to_ftdi,
	output reg	 		rdreq
);

parameter OFF = 0,
			 ON  = 1;

`define H8 data_from_fifo[15:8]
`define L8 data_from_fifo[7:0]			 
			 	 
assign data_to_ftdi = (rdreq == ON) ? `L8 : `H8;
assign data_to_ftdi_asserted = (usedw > 0);

always@(posedge clk)
begin
	if(usedw > 0)
		begin
			if(rdreq == OFF)
				begin
					rdreq = ON;
				end
			else 
				begin
					rdreq = OFF;
				end
		end
	else
		begin
			rdreq = OFF;
		end
end

endmodule 