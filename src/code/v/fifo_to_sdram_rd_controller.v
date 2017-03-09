module fifo_to_sdram_rd_controller (
	input clk,
	input [9:0] fifo_usedw,
	input fifo_full,
	output reg	fifo_tx_rdy,
	input sdram_rx_rdy,
	output reg	fifo_rdreq,
	output reg fifo_q_asserted
);

parameter OFF = 0,
			 ON  = 1;

parameter FALSE = 0,
			 TRUE = 1;
			 
reg[9:0]  ticks = 0;
parameter NUMBER_OF_16BIT_WORDS_IN_1KBYTE = 512;

wire KBYTE_IS_RDY = ((fifo_usedw >= NUMBER_OF_16BIT_WORDS_IN_1KBYTE) || (fifo_full == TRUE));

always@(posedge clk)
begin
	if(fifo_tx_rdy == OFF)
		begin
			if(KBYTE_IS_RDY == ON)
				begin
					fifo_tx_rdy = ON;
				end
			else
				begin
					fifo_tx_rdy = OFF;
				end
		end
	else 
		begin
			if(ticks == NUMBER_OF_16BIT_WORDS_IN_1KBYTE)
				begin
					fifo_tx_rdy = OFF;
				end
			else
				begin
					fifo_tx_rdy = ON;
				end
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

always@(posedge clk)
begin
	if(fifo_rdreq == ON)
		begin
			fifo_q_asserted = ON;
		end
	else
		begin
			fifo_q_asserted = OFF;
		end
end

endmodule 