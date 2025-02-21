module RAM(
	input		clk, rst, we, oe,
	input  [3:0]	mem_in, mem_add
	output [3:0]	mem_out
);
	integer i;
	reg [3:0]	ram [15:0];

	assign mem_out =	we==1'b1 ||
				oe==1'b1 ?
				ram[mem_add] : 4'bz ;

	always @ (posedge clk) begin
		if (rst) begin
			for(i=0 ; i<16 ; i++) begin
				memory[i] <= 4'b0000;
		end else begin
			if (we==1'b1) begin
				ram[mem_add] <= mem_in;
			end
		end
	end
endmodule