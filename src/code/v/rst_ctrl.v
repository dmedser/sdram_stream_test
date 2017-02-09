module reset_controller (
	input clk,
	output reg n_rst
);

parameter TICKS_IN_4_SEC = 192000000 - 1;
reg [31:0] rst_ticks;

always @(posedge clk)
begin
	if(rst_ticks < TICKS_IN_4_SEC)
		begin
			rst_ticks = rst_ticks + 1;
			n_rst = 0;
		end
	else 
		begin
			n_rst = 1;
		end
end

endmodule