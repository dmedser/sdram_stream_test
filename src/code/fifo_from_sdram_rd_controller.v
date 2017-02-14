module fifo_from_sdram_rd_controller (
	input 			  clk,
	input      [9:0] fifo_usedw,
	output reg       byte_switcher,
	output reg 		  fifo_q_asserted,
	output reg       fifo_rdreq
);

parameter OFF = 0,
			 ON  = 1;	 
			 
reg[10:0]  ticks = 0;
parameter NUMBER_OF_16BIT_WORDS_IN_1KBYTE = 512;

wire KBYTE_IS_RDY = (fifo_usedw == NUMBER_OF_16BIT_WORDS_IN_1KBYTE);		

parameter KBYTE_TRANSMISSION_TIME = 1024;	 

reg switch_en;	
always@(posedge clk)
begin
	if(KBYTE_IS_RDY == ON)
		begin
			switch_en = ON;
		end
	else if(ticks == KBYTE_TRANSMISSION_TIME)
		begin
			switch_en = OFF;
		end
end

always@(posedge clk)
begin
	if(switch_en == ON)
		begin
			if(ticks < KBYTE_TRANSMISSION_TIME)
				begin
					ticks = ticks + 1;
					fifo_rdreq = ~fifo_rdreq;
				end
			else 
				begin
					ticks = 0;
					fifo_rdreq = OFF;
				end
		end
	else
		begin
			ticks = 0;
			fifo_rdreq = OFF;
		end
end

reg delay_q_asserted;

always@(posedge clk)
begin
	if(switch_en == ON)
		begin
			delay_q_asserted = ON;
		end
	else
		begin
			delay_q_asserted = OFF;
		end
end

always@(posedge clk)
begin
	if(switch_en == ON)
		begin
			byte_switcher = ~byte_switcher;
		end
	else if(delay_q_asserted == ON)
		begin
			byte_switcher = ~byte_switcher;
		end
	else
		begin
			byte_switcher = OFF;
		end
end

always@(posedge clk)
begin
	if(switch_en == ON)
		begin
			if(delay_q_asserted == ON)
				begin
					fifo_q_asserted = ON;
				end
			else
				begin
					fifo_q_asserted = OFF;
				end
		end
	else
		begin
			fifo_q_asserted = OFF;
		end
end
			 

endmodule 
