module ALU(
    	input       		clk,
    	input  [3:0] 		A, B, aluOp,
    	output reg [7:0] 	aluOut
);
	reg 		eqz, gtz, ltz, carry;
    	reg [3:0] 	result; 

	initial begin
        	{eqz, gtz, ltz} = 3'b000;
        	result = 4'b0000;
        	aluOut = 8'b0000_0000;
    	end

    	always @(posedge clk) begin
        	case(aluOp)
            		`ADD: {carry, result}	<= A + B;
            		`SUB: {carry, result} 	<= A - B;
            		`INC: {carry, result} 	<= A + 1;
            		`DEC: {carry, result} 	<= A - 1;
            		`AND: result 		<= A & B;
            		`OR : result 		<= A | B;
            		`NOT: result 		<= ~A;
            		`XOR: result 		<= A ^ B;
            		`SHL: {carry, result} 	<= {A, 1'b0} << B[1:0];
  			`SHR: {result, carry} 	<= {1'b0, A} >> B[1:0];
            		default: result <= 4'b0000;
        	endcase
        
        	eqz <= (result == 4'b0000);
        	gtz <= !result[3] && (result != 4'b0000);
        	ltz <= result[3];
                                                            
        	aluOut <= {gtz, ltz, eqz, carry, result};
    	end
endmodule