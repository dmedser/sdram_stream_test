module adapter_32_to_16(
	input 		  clk,
	input  [31:0] stream_32,
	input 		  num_32_rdy,
	output [15:0] stream_16,
	output 	     num_16_rdy
);

parameter OFF = 0,
			 ON  = 1;

`define H16 stream_32[31:16]
`define L16 stream_32[15:0]

reg delay_tick;		
		
always@(posedge clk)
begin
	if(num_32_rdy == ON)
		delay_tick = ON;
	else
		delay_tick = OFF;
end

assign num_16_rdy = (num_32_rdy == ON || delay_tick == ON); 
assign stream_16 = num_32_rdy ? `H16 : `L16;

endmodule