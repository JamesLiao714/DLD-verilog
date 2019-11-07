//sr latch////
`timescale 1 ns/100ps
//USR

module USR(s0, s1, A, I, clear, clk, msb_in, lsb_in);

input s0, s1;
input clear;
input [3:0]I;
input clk;
output [3:0]A;
reg [3:0] A;
input msb_in, lsb_in;


always @(posedge clk or negedge clear)
begin
    if(clear == 1'b0)
    	A <= 0;
	else if(s0 == 0 & s1 == 0) //no change
		A <= A;
	else if(s0 == 1 & s1 == 0)//sr
		A <= {msb_in, A[3:1]};
	else if(s0 == 0 & s1 == 1)//sl
		A <= {A[2:0], lsb_in};
	else if(s0 == 1 & s1 ==1) //parallel
		A <= I;
end
endmodule


/////////////testbench///////////
module USR_TB();
	reg s0, s1, clear, clk;
	wire [3:0]A_usr;
	wire [3:0]A_bc;
	reg [3:0]I;
	reg msb_in, lsb_in;
	reg cnt, ld;
	//
	USR usr(s0, s1, A_usr, I, clear, clk, msb_in, lsb_in);
	bc_4bit bc(cnt, ld, A_bc, I, clear, clk);
	//

initial 
begin
	clk = 0;
	repeat (50)
	#50 clk = ~clk;
end
initial
    begin
    	s0 = 1; s1 = 1; I = 4'b1111; clear = 1; msb_in = 1; lsb_in = 1; cnt= 0; ld = 0;
    	#100 s0 = 0; s1 = 0; I = 4'b0001; clear = 1;msb_in = 1; lsb_in = 1; cnt = 1; ld = 1;
    	#100 s0 = 1; s1 = 0; I = 4'b0010; clear = 1;msb_in = 1; lsb_in = 1; cnt = 1; ld =0;
    	#100 s0 = 0; s1 = 1; I = 4'b0011; clear = 1; msb_in = 1; lsb_in = 1;cnt = 1; ld = 0;
    	#100 s0 = 1; s1 = 0; I = 4'b0100; clear = 1;msb_in = 1; lsb_in = 1; cnt = 1; ld = 0;
    	#100 s0 = 1; s1 = 1; I = 4'b0101; clear = 1;msb_in = 1; lsb_in = 1; cnt = 1; ld =0;
    	#100 s0 = 1; s1 = 0; I = 4'b1111; clear = 1;msb_in = 1; lsb_in = 1; cnt = 1; ld =0;
    	#100 s0 = 0; s1 = 0; I = 4'b0001; clear = 1;msb_in = 1; lsb_in = 1; cnt = 1; ld = 0;
    	#100 s0 = 0; s1 = 1; I = 4'b0010; clear = 1;msb_in = 1; lsb_in = 1; cnt = 1; ld =0;
    	#100 s0 = 1; s1 = 0; I = 4'b0011; clear = 1; msb_in = 1; lsb_in = 1;cnt = 1; ld = 0;
    	#100 s0 = 1; s1 = 0; I = 4'b0100; clear = 1;msb_in = 1; lsb_in = 1; cnt = 1; ld = 0;
    	#100 s0 = 1; s1 = 0; I = 4'b0101; clear = 1;msb_in = 1; lsb_in = 1; cnt = 1; ld =0;
    	#100 s0 = 1; s1 = 1; I = 4'b1111; clear = 1;msb_in = 1; lsb_in = 1; cnt = 1; ld =0;
    	#100 s0 = 0; s1 = 1; I = 4'b0010; clear = 1;msb_in = 1; lsb_in = 1; cnt = 1; ld =0;
    	#100 s0 = 0; s1 = 0; I = 4'b0011; clear = 1; msb_in = 1; lsb_in = 1;cnt = 1; ld = 0;
    	#100 s0 = 1; s1 = 0; I = 4'b0100; clear = 1;msb_in = 1; lsb_in = 1; cnt = 0; ld = 1;
    	#100 s0 = 1; s1 = 1; I = 4'b0101; clear = 1;msb_in = 1; lsb_in = 1; cnt = 0; ld = 1;
    	#100 s0 = 1; s1 = 1; I = 4'b1111; clear = 0;msb_in = 1; lsb_in = 1; cnt = 0; ld =0;
    end
initial #2000 $finish;
initial $dumpvars;
endmodule






module bc_4bit(cnt, ld, A, I, clear, clk);
input cnt, ld;
input clear;
input [3:0]I;
input clk;
output [3:0]A;
reg [3:0] A;


always @(posedge clk or negedge clear)
begin
    if(clear == 1'b0)
    	A <= 0;
	else if(ld == 1) //load
		A <= I;
	else if(ld == 0 & cnt == 1 & A == 4'b1111)//+1
		A <= 0;
	else if(ld == 0 & cnt == 1)//+1
		A <= A + 1'b1;
	else if(ld == 0 & cnt == 0)//no change
		A <= A;
	
end
endmodule
