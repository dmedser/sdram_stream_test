module fifo_from_sdram_controller (
	input clk,
	input [9:0] fifo_usedw,
	input fifo_full,
	output reg byte_switcher,
	output reg fifo_q_asserted,
	output reg fifo_rdreq,
	input next_rx_rdy,
	output this_rx_rdy
);

/******************** WRITE CONTROL ********************/

assign this_rx_rdy = ((fifo_usedw < NUMBER_OF_16BIT_WORDS_IN_1KBYTE) && (fifo_full == FALSE));

/******************** READ CONTROL ********************/

parameter OFF = 0,
			 ON  = 1;	 
parameter FALSE = 0,
			 TRUE = 1;
			 
reg[10:0]  ticks = 0;
parameter NUMBER_OF_16BIT_WORDS_IN_1KBYTE = 512;

wire KBYTE_IS_RDY = ((fifo_usedw >= NUMBER_OF_16BIT_WORDS_IN_1KBYTE) || (fifo_full == TRUE));		

wire this_tx_rdy = (next_rx_rdy == ON) && (KBYTE_IS_RDY == ON); 

parameter KBYTE_TRANSMISSION_TIME = 1024;	 

reg switch_en;	
always@(posedge clk)
begin
	if(switch_en == OFF)
		begin
			if(this_tx_rdy == ON)
				begin
					switch_en = ON;
				end
			else
				begin
					switch_en = OFF;
				end
		end
	else
		begin
			if(ticks == KBYTE_TRANSMISSION_TIME)
				begin
					switch_en = OFF;
				end
			else
				begin
					switch_en = ON;
				end
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



/*
if(next_rx_rdy == ON)
		begin
			if(switch_en == OFF)
				begin
					if(KBYTE_IS_RDY == ON)
						begin
							switch_en = ON;
						end
					else
						begin
							switch_en = OFF;
						end
				end
			else
				begin
					if(ticks == KBYTE_TRANSMISSION_TIME)
						begin
							switch_en = OFF;
						end
					else
						begin
							switch_en = ON;
						end
				end
		end
	else
		begin
			switch_en = OFF;
		end
*/

//	if(switch_en == OFF)
//		begin
//			if(next_rx_rdy == ON)
//				begin
//					if(KBYTE_IS_RDY == ON)
//						begin
//							switch_en = ON;
//						end
//					else
//						begin
//							switch_en = OFF;
//						end
//				end
//			else
//				begin
//					switch_en = OFF;
//				end
//		end
//	else
//		begin
//			if(ticks == KBYTE_TRANSMISSION_TIME)
//				begin
//					switch_en = OFF;
//				end
//			else
//				begin
//					switch_en = ON;
//				end
//		end

