module stream_generator (
	input  clk,
	input  enable,
	input  n_rst, 
	output [31:0] stream_32,
	output  num_32_rdy
);

parameter OFF = 0,
			 ON  = 1;

assign stream_32  = counter;
assign num_32_rdy = ((enable == ON) && (ticks == 0));

reg [31:0] counter;

/******************** BYTE STREAM TIMER ********************/ 
// 10 Mbyte/s = 10*2^20 byte/s = 10*2^18 increments of 4-bit-depth number per sec -> increment counter every ~18 ticks
// stream = 10.6*10^6 bytes/s 
parameter COUNT_INCREMENT_PERIOD = 18 - 1;
reg [4:0] ticks;

always@(posedge clk or negedge n_rst)
begin
	if(n_rst == OFF)
		begin
			ticks = 0;
			counter = 0;//32'hfafbfcfd;
		end
	else 
		begin
			if(enable == ON)
				begin
					if(ticks < COUNT_INCREMENT_PERIOD)
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
