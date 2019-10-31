//sr latch////
lalalalalalalala
sdsdsdsdsdsdsd
`timescale 1 ns/100ps
//SR latch
module SRlatch(S, R, Q, _Q);

	input S,R;
	output Q, _Q;


	nand #(10) g1(Q,_Q, S);
	nand #(10) g2(_Q,R, Q);
endmodule 



/////////////testbench///////////
module w4_TB();
	reg D, clk;
	wire ETQ;
	wire MSQ;
	//
	MS_D ms1(D, clk, MSQ);
	ET_D et1(D, clk, ETQ);
	//
initial 
begin
	clk = 0;
	repeat (6)
	#100 clk = ~clk;
end
initial
    begin
    	D = 0;
    	#100 D = 1;
    	#100 D = 1;
    	#100 D = 0;
    	#100 D = 0;
    	#100 D = 0;
    end
initial #800 $finish;
initial $dumpvars;
endmodule


//D-latch
module Dlatch(D, en, Q, _Q);
	input D, en;
	output Q, _Q;

	wire _D;
	not #(5) n1(_D, D);
	wire w1, w2;
	nand #(10) g1(w1, en, D);
	nand #(10) g2(w2, en, _D);
	SRlatch sr1(w1, w2, Q, _Q);
endmodule 

//master slave
module MS_D(D, clk, Q);
	input D, clk;
	output Q;

	wire w1, w2, w3, _c;
	not #(10) n2(_c, clk);
	Dlatch master(D, _c, w1, w2);
	Dlatch slave(w1, clk, Q, w3);
endmodule


//et D flip-flop
module ET_D(D, clk, Q);
	input D, clk;
	output Q, _Q;

	nand #(10) n1(w1, D, w2);
	nand #(15) n2(w2, w1, clk, w3);
	nand #(10) n3(w3, clk, w4);
	nand #(10) n4(w4, w1, w3);

	SRlatch sr(w3, w2, Q, _Q);
endmodule





