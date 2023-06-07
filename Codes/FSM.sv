module FSM (input  logic clk,
            input  logic reset,  
            input  logic [6:0]  op,
            output logic [1:0] ALUSrcA, ALUSrcB,
            output logic [1:0] ResultSrc,
			   output logic [1:0] ALUOp,
            output logic AdrSrc,
				output logic PCUpdate,
				output logic Branch,
            output logic IRWrite,
            output logic RegWrite, 
				output logic MemWrite);
				
				
				logic [3:0] state;
				logic [3:0] next_state;
						
				always_ff @ (posedge clk)
						begin
							if (reset) state <= 0;
							else state <= next_state;
						end
						
				always_comb
					begin
					  
						case (state)
						
							0: begin
							
								next_state = 1;
								ALUSrcA = 2'b00;
								ALUSrcB = 2'b10;
								ALUOp = 2'b00;
								AdrSrc = 0;
								ResultSrc = 2'b10;
								RegWrite = 0;
								MemWrite = 0;
								IRWrite = 1;
								PCUpdate = 1;
								Branch = 0;
								
								end
								
							1: begin
							
								 case (op)
									7'b0000011: next_state = 2; // lw
									7'b0100011: next_state = 2; // sw
									7'b0110011: next_state = 6; // R-type
									7'b0010011: next_state = 8; // I-type ALU
									7'b1101111: next_state = 9; // jal
									7'b1100011: next_state = 10; // beq
									default: next_state = 0;
								 endcase
								 
								ALUSrcA = 2'b01;
								ALUSrcB = 2'b01;
								ALUOp = 2'b00;
								AdrSrc = 0;
								ResultSrc = 0;
								RegWrite = 0;
								MemWrite = 0;
								IRWrite = 0;
								PCUpdate = 0;
								Branch = 0;
								
								end
								
							 2: begin
							 
								 case (op)
									7'b0000011: next_state = 3; // lw
									7'b0100011: next_state = 5; // sw
									default: next_state = 0;
						   	 endcase
								 
								 ALUSrcA = 2'b10;
								 ALUSrcB = 2'b01;
								 ALUOp = 2'b00;
								 AdrSrc = 0;
								 ResultSrc = 0;
								 RegWrite = 0;
								 MemWrite = 0;
								 IRWrite = 0;
								 PCUpdate = 0;
								 Branch = 0;
								 
								end
								
							  3: begin
							  
						  		  next_state = 4;
								  ALUSrcA = 0;
								  ALUSrcB = 0;
								  ALUOp = 0;
								  AdrSrc = 1;
								  ResultSrc = 2'b00;
								  RegWrite = 0;
								  MemWrite = 0;
								  IRWrite = 0;
								  PCUpdate = 0;
								  Branch = 0;
								  
								  end
								  
								4: begin
								
									next_state = 0;
									ALUSrcA = 0;
									ALUSrcB = 0;
									ALUOp = 0;
									AdrSrc = 0;
									ResultSrc = 2'b01;
									RegWrite = 1;
									MemWrite = 0;
									IRWrite = 0;
									PCUpdate = 0;
									Branch = 0;
									
									end
									
								5: begin
								
									next_state = 0;
									ALUSrcA = 0;
									ALUSrcB = 0;
									ALUOp = 0;
									AdrSrc = 1;
									ResultSrc = 2'b00;
									RegWrite = 0;
									MemWrite = 1;
									IRWrite = 0;
									PCUpdate = 0;
									Branch = 0;
									
									end
									
								6: begin
								
									next_state = 7;
									ALUSrcA = 2'b10;
									ALUSrcB = 2'b00;
									ALUOp = 2'b10;
									AdrSrc = 0;
									ResultSrc = 0;
									RegWrite = 0;
									MemWrite = 0;
									IRWrite = 0;
									PCUpdate = 0;
									Branch = 0;
									
									end
									
								7: begin
								
									next_state = 0;
									ALUSrcA = 0;
									ALUSrcB = 0;
									ALUOp = 0;
									AdrSrc = 0;
									ResultSrc = 2'b00;
									RegWrite = 1;
									MemWrite = 0;
									IRWrite = 0;
									PCUpdate = 0;
									Branch = 0;
									
									end
									
								8: begin
								
									next_state = 7;
									ALUSrcA = 2'b10;
									ALUSrcB = 2'b01;
									ALUOp = 2'b10;
									AdrSrc = 0;
									ResultSrc = 0;
									RegWrite = 0;
									MemWrite = 0;
									IRWrite = 0;
									PCUpdate = 0;
									Branch = 0;
									
									end
									
								9: begin
								
									next_state = 7;
									ALUSrcA = 2'b01;
									ALUSrcB = 2'b10;
									ALUOp = 2'b00;
									AdrSrc = 0;
									ResultSrc = 2'b00;
									RegWrite = 0;
									MemWrite = 0;
									IRWrite = 0;
									PCUpdate = 1;
									Branch = 0;
									
									end
									
								10: begin
								
									next_state = 0;
									ALUSrcA = 2'b10;
									ALUSrcB = 2'b00;
									ALUOp = 2'b01;
									AdrSrc = 0;
									ResultSrc = 2'b00;
									RegWrite = 0;
									MemWrite = 0;
									IRWrite = 0;
									PCUpdate = 0;
									Branch = 1;
									
									end
								 default: next_state = 0;
							endcase
								
					end
				
endmodule
