`timescale 1 ns/100ps
module Simple_Circuit_prop_delay(A,B,C,D,E,F);
output F;
input A,B,C,D,E;
wire w1,w2,w3;


nand #(30)G1(w1,A,B);
nand #(30)G2(w2,C,D);
not #(10)G3(w3,E);
and #(20)G4(F,w1,w2,w3);
endmodule