/********** REFRESHES COUNTER **********/ 
module refreshes_counter (
	input n_rst,
	input incr_refs_cnt,
	output refs_cd_is_over
);

parameter REFRESHES_PER_tRFC = 8192;

assign refs_cd_is_over = (refresh_counter == REFRESHES_PER_tRFC);


reg [13:0] refresh_counter;

always@(posedge incr_refs_cnt or negedge n_rst)
begin
	if(n_rst == 0)
		begin
			refresh_counter = 0;
		end
	else
		begin
			refresh_counter = refresh_counter + 1;
		end
end

endmodule