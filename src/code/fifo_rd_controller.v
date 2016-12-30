module fifo_rd_controller(
	input 		clk,
	input [9:0] usedw,	
	output reg	fifo_tx_rdy,
	input 		sdram_rx_rdy,
	output reg	rdreq
);

parameter OFF = 0,
			 ON  = 1;

reg[8:0]  ticks = 0;
parameter NUMBER_OF_16BIT_WORDS_IN_1KBYTE = 512;

wire KBYTE_IS_RDY = (usedw == NUMBER_OF_16BIT_WORDS_IN_1KBYTE);

always@(posedge clk)
begin
	if((KBYTE_IS_RDY == ON) && (rdreq == OFF))
		fifo_tx_rdy = ON;
	else 
		fifo_tx_rdy = OFF;
end

always@(posedge clk)
begin
	if(sdram_rx_rdy == ON)
		rdreq = ON;
	else 
		begin
			if(rdreq == ON)
				begin
					if(ticks == (NUMBER_OF_16BIT_WORDS_IN_1KBYTE - 1))
						begin
							ticks = 0;
							rdreq = OFF;
						end
					else 
						ticks = ticks + 1;
				end
		end
end

endmodule 