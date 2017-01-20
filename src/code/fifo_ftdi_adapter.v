module fifo_ftdi_adapter (
	input 				rdclk, 
	input     [10:0]  usedw,
	output reg			fifo_tx_rdy,
	input 				ftdi_rx_rdy,
	output 				FWR,
	input 				FTXE,
	output 				rdreq,
	input 				wrreq
);

parameter OFF = 0,
			 ON  = 1;
			 

always@(posedge rdclk)
begin
	if(wrreq == OFF)
		begin
			if(usedw > 0)
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
			 

assign rdreq = ((ftdi_rx_rdy == ON) & (FTXE == 0) & (usedw > 0)); 
			 
//assign fifo_tx_rdy = (wrreq == OFF) & (usedw > 0);
//assign rdreq = fifo_tx_rdy & ftdi_rx_rdy;
//assign FWR = (rdreq == ON) ? 0 : 1;

assign FWR = ((FTXE == 0) & (usedw > 0)) ? sync_FWR : 1;

reg sync_FWR;

always@(posedge rdclk)
begin
	if(rdreq == ON)
		begin
			sync_FWR = OFF;
		end
	else if (fifo_tx_rdy == OFF)
		begin
			sync_FWR = ON;
		end
end


 			 	
				
endmodule 