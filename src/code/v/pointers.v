module pointers (
	input incr_wr_ptr,
	input incr_rd_ptr,
	input n_rst,
	output [12:0] wr_row,
	output [1:0] wr_bank,
	output [12:0] rd_row,
	output [1:0] rd_bank,
	output sdram_empty
);


`define WR_BANK	wr_ptr[14:13] 
`define WR_ROW		wr_ptr[12:0]

`define RD_BANK	rd_ptr[14:13]
`define RD_ROW		rd_ptr[12:0]

reg[14:0] wr_ptr;
reg[14:0] rd_ptr;

assign wr_row = `WR_ROW;
assign wr_bank = `WR_BANK;

assign rd_row = `RD_ROW;
assign rd_bank = `RD_BANK;

assign sdram_empty = (wr_ptr == rd_ptr);

always@(posedge incr_wr_ptr or negedge n_rst)
begin
	if(n_rst == 0)
		begin
			wr_ptr = 0;
		end
	else
		begin
			wr_ptr = wr_ptr + 1;
		end
end


always@(posedge incr_rd_ptr or negedge n_rst)
begin
	if(n_rst == 0)
		begin
			rd_ptr = 0;
		end
	else
		begin
			rd_ptr = rd_ptr + 1;
		end
end


endmodule