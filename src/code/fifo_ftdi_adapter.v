module fifo_ftdi_adapter (
	input      [10:0]  usedw,
	output 				fifo_tx_rdy,
	input 				ftdi_rx_rdy,
	output 				FWR,
	input 				FTXE,
	output 				rdreq,
	input 				wrreq
);


parameter OFF = 0,
			 ON  = 1;
			 
assign fifo_tx_rdy = (wrreq == OFF) && (usedw > 0);
assign rdreq = fifo_tx_rdy & ftdi_rx_rdy;
assign FWR = (rdreq == ON) ? 0 : 1;
 			 	
				
endmodule 