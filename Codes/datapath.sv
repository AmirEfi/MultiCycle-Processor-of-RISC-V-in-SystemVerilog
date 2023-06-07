module datapath (input logic clk, reset,
					  input logic [1:0] ResultSrc,
					  input logic [1:0] ImmSrc,
					  input logic [2:0] ALUControl,
					  input logic [1:0] ALUSrcA,
					  input logic [1:0] ALUSrcB,
					  input logic [31:0] rd,
					  input logic AdrSrc, 
					  input logic RegWrite, IRWrite,
					  input logic PCWrite, MemWrite,
					  output logic Zero,
					  output logic [31:0] Adr, Instr,
					  output logic [31:0] WriteData);
					  
				logic [31:0] OldPC, PC;
				logic [31:0] ImmExt;
				logic [31:0] SrcA, SrcB;
				logic [31:0] Result; // PCNext = Result
				logic [31:0] Data;
				logic [31:0] A;
				logic [31:0] rd1, rd2;
				logic [31:0] ALUResult, ALUOut;
				
				
				// next PC logic
				flopenr #(32) pcreg(clk, reset, PCWrite, Result, PC);
				mux2 #(32) pcmux(PC, Result, AdrSrc, Adr);
				flopenr #(64) oldpc_instr(clk, reset, IRWrite, {PC, rd} ,{OldPC, Instr} );
				flopr #(32) data(clk, reset, rd, Data);
				
				// register file logic
				regfile rf(clk, RegWrite, Instr[19:15], Instr[24:20], Instr[11:7], Result, rd1, rd2);
				extend ext(Instr[31:7], ImmSrc, ImmExt);
				flopr #(64) regist(clk, reset, {rd1, rd2} , {A, WriteData} );
				
				// 2 mux after register file
				mux3 #(32) muxA(PC, OldPC, A, ALUSrcA, SrcA);
				mux3 #(32) muxB(WriteData, ImmExt, 32'd4, ALUSrcB, SrcB); 
				
				// ALU logic
				alu alu(SrcA, SrcB, ALUControl, ALUResult, Zero);
				flopr #(32) fp_alu(clk, reset, ALUResult, ALUOut);
				mux3 #(32) resultmux( ALUOut, Data, ALUResult, ResultSrc, Result);
endmodule
