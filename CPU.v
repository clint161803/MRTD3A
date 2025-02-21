`include "OpCodes.v"

module CPU (
    	input clk, rst,
    	input [3:0] opCode,
    	input [7:0] data_in,
    	output [7:0] data_out
);
    	wire [3:0] alu_op;
    	wire mem_read, mem_write, pc_inc;
    	wire [7:0] addr_bus;
    	wire [7:0] data_bus;
    
    	CU ControlUnit (
    	    .clk(clk),
    	    .rst(rst),
    	    .opCode(data_bus[7:4]),
    	    .data_in(data_in),
    	    .alu_op(alu_op),
    	    .mem_read(mem_read),
    	    .mem_write(mem_write),
    	    .pc_inc(pc_inc),
    	    .addr_bus(addr_bus),
    	    .data_bus(data_bus)
    	);
    
    	registers RegisterFile (
    	    .clk(clk),
    	    .rst(rst),
    	    .pc_inc(pc_inc),
    	    .data_in(data_bus),
    	    .data_out(data_bus),
    	    .addr_reg(addr_bus)
    	);
    
    	ALU ArithmeticLogicUnit (
    	    .clk(clk),
    	    .A(data_bus),
    	    .B(data_bus),
    	    .aluOp(alu_op),
    	    .aluOut(data_bus)
    	);
endmodule