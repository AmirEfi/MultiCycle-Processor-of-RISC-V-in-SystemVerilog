module alu (input logic [31:0] srcA, 
				input logic [31:0] srcB, 
				input logic [2:0] cntrl,
				output logic [31:0] out, 
				output logic zero);
				
    logic [31:0]tmp;
	 
    always @(srcA, srcB, cntrl)
        begin
			case(cntrl)
				3'b000: out = srcA + srcB; // add
				3'b001: out = srcA - srcB; // sub
				3'b011: out = srcA | srcB; // or
				3'b010: out = srcA & srcB; // and
				3'b101:							// slt
					begin
							tmp = srcA - srcB;
							out[31:1] = 31'h0;
							out[0] = (tmp[31] ==  1'b1);
					end
			endcase
			
       if (out == 32'h00000000)
           zero = 1;
       else
           zero = 0;
    end
endmodule
