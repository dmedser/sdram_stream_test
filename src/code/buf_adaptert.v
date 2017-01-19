module buf_adapter (
	input 				clk,
	input 	    	   rdreq,
	input 	  		   FWR,
	input  	  [15:0] d16,
	output  [7:0]  d8,
	output 	         empty
	
);

parameter OFF = 0,
			 ON  = 1;

`define H8 buffer[15:8]
`define L8 buffer[7:0]	

assign d8 = rdreq ? `L8 : `H8;

reg [15:0] buffer; 
always@(posedge clk)
begin
	if(rdreq == ON)
		buffer = d16;
end

endmodule