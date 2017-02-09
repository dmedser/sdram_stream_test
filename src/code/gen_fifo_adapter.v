module s32s16_adapter (
	input 		  clk,
	input  [31:0] s32,
	input 		  n32rdy,
	output [15:0] s16,
	output 	     n16rdy
);

parameter OFF = 0,
			 ON  = 1;

`define H16 s32[31:16]
`define L16 s32[15:0]

reg delay_tick;		
		
always@(posedge clk)
begin
	if(n32rdy == ON)
		delay_tick = ON;
	else
		delay_tick = OFF;
end

assign n16rdy = (n32rdy == ON || delay_tick == ON); 
assign s16 = n32rdy ? `H16 : `L16;

endmodule