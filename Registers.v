module registers (
    	input clk, rst,
    	input pc_inc,
    	input [7:0] data_in,
    	output reg [7:0] data_out,
    	output reg [7:0] addr_reg
);
    	reg [7:0] pc;
    	reg [7:0] w_reg;
    
    	always @(posedge clk or posedge rst) begin
    	    	if (rst) begin
            		pc <= 8'b00000000;
            		w_reg <= 8'b00000000;
            		addr_reg <= 8'b00000000;
        	end else begin
            		if (pc_inc) pc <= pc + 1;
            		addr_reg <= pc;
            		data_out <= w_reg;
        	end
    	end
endmodule
