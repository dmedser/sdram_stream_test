module stream_generator (
	input  clk,
	input  en,
	input  n_rst, 
	output [31:0] s32,
	output  n32rdy
);

parameter OFF = 0,
			 ON  = 1;

assign s32  = counter;
assign n32rdy = ((en == ON) && (ticks == 0));

reg [31:0] counter;

/******************** BYTE STREAM TIMER ********************/ 
// 10 Mbyte/s = 10*2^20 byte/s = 10*2^18 increments of 4-bit-depth number per sec -> increment counter every ~18 ticks
// stream = 10.6*10^6 bytes/s 

reg [4:0] ticks;
parameter M10p6_COUNT_INCREMENT_PERIOD = 18 - 1;

//reg[17:0] ticks;
parameter KB1_COUNT_INCREMENT_PERIOD = 187500;

parameter M38p4_COUNT_INCREMENT_PERIOD = 5 - 1; // 38.4 MB/s
parameter MIN_COUNT_INCREMENT_PERIOD = 12 - 1; // 16 MB/s

parameter TEST_COUNT_INCREMENT_PERIOD = 11 - 1; 

always@(posedge clk or negedge n_rst)
begin
	if(n_rst == OFF)
		begin
			ticks = 0;
			counter = 32'hfafbfcfd;
		end
	else 
		begin
			if(en == ON)
				begin
					if(ticks < MIN_COUNT_INCREMENT_PERIOD)
						ticks = ticks + 1;
					else 
						begin
							counter = counter + 1;
							ticks = 0;
						end
				end
		end
end


endmodule
