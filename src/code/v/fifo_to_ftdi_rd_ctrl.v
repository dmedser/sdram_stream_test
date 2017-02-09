module fifo_to_ftdi_rd_controller (
	input clk,
	input [10:0] fifo_usedw,
	output reg	fifo_tx_rdy,
	input ftdi_rx_rdy,
	output reg fifo_rdreq,
	input fifo_wrreq
);

parameter OFF = 0,
			 ON  = 1;

always@(posedge clk)
begin
	if(fifo_wrreq == OFF)
		begin
			if(fifo_usedw > 0)
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
			fifo_tx_rdy = OFF;
		end
end	

wire rx_tx_en = (ftdi_rx_rdy == ON) && (fifo_tx_rdy == ON);

always@(posedge clk)
begin
	if(rx_tx_en == ON)
		begin
			fifo_rdreq = ON;
		end
	else
		begin
			fifo_rdreq = OFF;
		end
end 


endmodule