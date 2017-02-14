module fifo_to_sdram_rd_controller (
	input clk,
	input [9:0] fifo_usedw,
	output reg	fifo_tx_rdy,
	input sdram_rx_rdy,
	output reg	fifo_rdreq
);

parameter OFF = 0,
			 ON  = 1;
			 
reg[9:0]  ticks = 0;
parameter NUMBER_OF_16BIT_WORDS_IN_1KBYTE = 512;

wire KBYTE_IS_RDY = (fifo_usedw == NUMBER_OF_16BIT_WORDS_IN_1KBYTE);

always@(posedge clk)
begin
	if(KBYTE_IS_RDY == ON)
		begin
			fifo_tx_rdy = ON;
		end
	else if(ticks == NUMBER_OF_16BIT_WORDS_IN_1KBYTE)
		begin
			fifo_tx_rdy = OFF;
		end
end

always@(posedge clk)
begin
	if(sdram_rx_rdy == ON)
		begin
			if(ticks < NUMBER_OF_16BIT_WORDS_IN_1KBYTE)
				begin
					ticks = ticks + 1;
					fifo_rdreq = ON;
				end
			else 
				begin
					ticks = 0;
					fifo_rdreq = OFF;
				end
		end	
end

endmodule 