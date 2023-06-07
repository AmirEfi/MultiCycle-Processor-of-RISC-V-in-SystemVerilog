module mem (input logic clk, we,
				 input logic [31:0] a, wd,
				 output logic [31:0] rd);
				 
			logic [31:0] RAM[63:0];
			
			initial 
					$readmemh("E:\\Uni\\Term 4 - Spring 1401\\Computer Architecture\\Project\\ans\\riscvtest.txt",RAM);
			
			assign rd = RAM[a[31:2]]; // word aligned
			
			always_ff @(posedge clk)
				if (we) RAM[a[31:2]] <= wd;
endmodule
