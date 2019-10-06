`timescale 1 ns/100ps
module c1(A,B,C,D,F);
output F;
input A,B,C,D;
wire w1,w2,w3,w4,w5,w6;

not #(10)G1(w5,B);//b'
not #(10)G2(w6,C);//c'
nand #(30)G3(w1,C,D);
nand #(30)G4(w2,w5,w1);
nand #(30)G5(w3,A,w2);
nand #(30)G6(w4,B,w6);
nand #(30)G7(F,w3,w4);
endmodule

