module s16s8_adapter (
	input 			byte_switcher,
	input   [15:0] s16,
	output  [7:0]  s8  
);

`define L8 s16[7:0]
`define H8 s16[15:8]

parameter LOW  = 0,
			 HIGH = 1;

assign s8 = (byte_switcher == LOW) ? `L8 : `H8;  


endmodule

