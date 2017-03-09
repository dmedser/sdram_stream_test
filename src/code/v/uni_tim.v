/************** UNIVERSAL TIMER **************/
module universal_timer (
	input clk,
	input n_rst,
	output reg [9:0] uni_time
);

always@(posedge clk or negedge n_rst)
begin
	if(n_rst == 0)
		begin
			uni_time = 0;
		end
	else 
		begin
			uni_time = uni_time + 1;
		end
end

endmodule 