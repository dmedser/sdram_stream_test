module fifo_to_ftdi_rd_controller (
	input ftdi_clk,
	input [10:0] fifo_usedw,
	input fifo_empty,
	output reg	fifo_tx_rdy,
	input ftdi_rx_rdy,
	output fifo_rdreq
);

parameter OFF = 0,
			 ON  = 1;

parameter NUMBER_OF_8BIT_WORDS_IN_1KBYTE = 1024;

wire KBYTE_IS_RDY = (fifo_usedw == NUMBER_OF_8BIT_WORDS_IN_1KBYTE);		 

always@(posedge ftdi_clk)
begin
	if(KBYTE_IS_RDY == ON)
		begin
			fifo_tx_rdy = ON;
		end
	else if(fifo_empty == ON)
		begin
			fifo_tx_rdy = OFF;
		end
end

wire rx_tx_rdy = (fifo_tx_rdy == ON) && (ftdi_rx_rdy == ON);

assign fifo_rdreq = rx_tx_rdy;


endmodule