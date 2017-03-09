module fifo_to_ftdi_controller (
	input clk,
	input [10:0] fifo_usedw,
	input fifo_empty,
	input fifo_full,
	output reg fifo_tx_rdy,
	input ftdi_rx_rdy,
	output fifo_rdreq,
	output fifo_rx_rdy
);

parameter OFF = 0,
			 ON  = 1;
			 
parameter FALSE = 0,
			 TRUE = 1;

parameter NUMBER_OF_8B_WORDS_IN_KBYTE = 1024;

assign fifo_rx_rdy = (fifo_usedw < NUMBER_OF_8B_WORDS_IN_KBYTE) && (fifo_full == FALSE);

wire KBYTE_IS_RDY = (fifo_usedw >= NUMBER_OF_8B_WORDS_IN_KBYTE) || (fifo_full == TRUE);

reg[10:0] byte_cnt;

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
			if(byte_cnt == NUMBER_OF_8B_WORDS_IN_KBYTE)
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
	if(rx_tx_rdy == ON)
		begin
			if(byte_cnt < NUMBER_OF_8B_WORDS_IN_KBYTE)
				begin
					byte_cnt = byte_cnt + 1;
				end
		end
	else if(fifo_tx_rdy == OFF)
		begin
			byte_cnt = 0;
		end
end
			 
wire rx_tx_rdy = (fifo_tx_rdy == ON) && (ftdi_rx_rdy == ON);

assign fifo_rdreq = (rx_tx_rdy == TRUE) && (byte_cnt < NUMBER_OF_8B_WORDS_IN_KBYTE);


endmodule


