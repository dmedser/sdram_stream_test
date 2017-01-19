module fifo_from_sdram_rd_controller (
	input 			  clk,
	input      [9:0] usedw,
	output reg       byte_switcher,
	output reg 		  fifo_q_asserted,
	output reg       rdreq
);

parameter OFF = 0,
			 ON  = 1;
			 
reg switch_en;			
 
always@(posedge clk)
begin	
	if(usedw > 0)
		begin	
			switch_en = ON;
			rdreq = ~rdreq;
		end
	else
		begin
			switch_en = OFF;
			rdreq = OFF;
		end
end

always@(posedge clk)
begin
	if(switch_en == ON)
		begin
			fifo_q_asserted = ON;
			byte_switcher = ~byte_switcher;
		end
	else 
		begin
			byte_switcher = OFF;
			fifo_q_asserted = OFF;
		end
end


endmodule 
