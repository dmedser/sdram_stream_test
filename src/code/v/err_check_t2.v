module err_check_t2 (
	input clk,
	input [15:0] data,
	input wren,
	output reg err
);

parameter OFF = 0,
			 ON  = 1;
			 
reg [31:0] fst;
reg [31:0] snd; 

reg [1:0] ticks;

reg clk_x2;

always@(posedge clk)
begin
	if(wren == ON)
		clk_x2 = ~clk_x2;
end


always@(posedge clk_x2)
begin
	if(wren == ON)
		begin
			ticks = ticks + 1;
		end
end

always@(posedge clk_x2)
begin
	if(wren == ON)
		begin
			case(ticks)
			0:
				fst[31:16] = data;
			1:
				fst[15:0] = data;
			2:
				snd[31:16] = data;
			3: 
				snd[15:0] = data;
			default:
				begin
				end
			endcase
		end
end

reg delay_wren;

always@(posedge clk_x2)
begin
	if(wren == ON)
		begin
			delay_wren = ON;
		end
	else
		begin
			delay_wren = OFF;
		end
end

always@(posedge clk_x2)
begin
	if(delay_wren == ON)
		begin
			if((ticks == 0) && (snd != (fst + 1)))
				err = ON;
			else
				err = OFF;
		end
end


endmodule 