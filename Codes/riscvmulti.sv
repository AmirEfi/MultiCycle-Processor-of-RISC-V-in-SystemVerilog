module riscvmulti(input  logic        clk, reset,
                  output logic        MemWrite,
                  output logic [31:0] Adr, WriteData,
                  input  logic [31:0] ReadData);
						
				
			logic [1:0] ResultSrc, ImmSrc, ALUSrcA, ALUSrcB;
			logic [2:0] ALUControl;
			logic AdrSrc, Zero;
			logic RegWrite, PCWrite, IRWrite;
			logic [31:0] Instr;

  
			datapath dp (clk, reset, ResultSrc, ImmSrc, ALUControl, ALUSrcA, ALUSrcB, ReadData, AdrSrc, 
								RegWrite, IRWrite, PCWrite, MemWrite, Zero, Adr, Instr, WriteData);
								
			controller c (clk , reset, Instr[6:0], Instr[14:12], Instr[30], Zero, ImmSrc,
								ALUSrcA, ALUSrcB, ResultSrc, AdrSrc, ALUControl, IRWrite, PCWrite, RegWrite, MemWrite);
endmodule
