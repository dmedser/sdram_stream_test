module s_gen_controller (
	input clk,
	input n_rst,
	input wrreq,
	input sdram_rfo,
	input [7:0] d,
	output reg gen_en
);

parameter OFF = 0,
			 ON  = 1;

reg [7:0] INPUT_REG;

always@(posedge clk or negedge n_rst)
begin
	if(n_rst == 0)
		begin
			INPUT_REG = 0;
		end
	else if(wrreq == ON)
		begin
			INPUT_REG = d;
		end
end

always@(posedge clk or negedge n_rst)
begin
	if(n_rst == 0)
		begin
			gen_en = OFF;
		end
	else if((INPUT_REG != 0) && (sdram_rfo == ON))
		begin
			gen_en = ON;
		end
	else
		begin
			gen_en = OFF;
		end
end

endmodule