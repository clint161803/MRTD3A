`include "OpCodes.v"

module CU (
    	input 			clk, rst,
    	input [3:0] 		opCode,
    	input [7:0] 		data_in,
    	output reg [3:0] 	alu_op,
    	output reg 		we, oe,
    	output reg 		pc_inc,
    	output reg 		mem_read, mem_write,
    	output reg [7:0] 	addr_bus,
    	inout [7:0] 		data_bus
);
    	parameter FETCH = 2'b00;
    	parameter DECODE = 2'b01;
    	parameter EXECUTE = 2'b10;
    	reg [1:0] state;
    
    	reg [7:0] pc, mdr, mar;
    	reg [11:0] ir;
    	wire [3:0] opcode = ir[11:8];
    	wire [7:0] operand = ir[7:0];
    
    	always @(posedge clk or posedge rst) begin
        	if (rst) begin
            		state <= FETCH;
            		pc_inc <= 0;
            		we <= 0;
            		oe <= 0;
            		alu_op <= `NOOP;
            		mem_read <= 0;
            		mem_write <= 0;
        	end else begin
            		case (state)

                		FETCH : begin
                    			we <= 1;
                	    		mar <= addr_bus;
                	    		state <= DECODE;
                		end

                		DECODE : begin
                    			ir <= {opCode, data_in};
                    			state <= EXECUTE;
                		end

                		EXECUTE: begin
                    			case (opcode)

                        			`NOOP: state <= FETCH;

                        			`LOADW: begin
                            				mdr <= data_in;
                            					state <= FETCH;
                        			end

                        			`MOVW: begin
                            				mdr <= operand;
                            				pc_inc <= 1;
                            				state <= FETCH;
                        			end

                        			`MOVWM: begin
                            				mem_write <= 1;
                            				mar <= operand;
                            				data_bus <= mdr;
                            				pc_inc <= 1;
                            				state <= FETCH;
						end

                        			`MOVMW: begin
                            				mem_read <= 1;
                            				mar <= operand;
                            				mdr <= data_bus;
                            				pc_inc <= 1;
                            				state <= FETCH;
                        			end

                        			`ADDW: begin
                            				alu_op <= `ADD;
                            				mdr <= alu_out[7:0];
                            				pc_inc <= 1;
                            				state <= FETCH;
                        			end

                        			default: state <= FETCH;
                    			endcase
                		end
            		endcase
        	end
    	end
endmodule