`timescale 1 ns/100ps
module c2(A,B,C,D,F);
output F;
input A,B,C,D;
wire w1,w2,w3,w4,w5,w6,w7;

not #(10)G1(w1,A);//a'
not #(10)G2(w2,B);//b'
not #(10)G3(w3,D);//d'
nor #(30)G4(w4,w1,B);  
nor #(30)G5(w5,A,w2); 
nor #(30)G6(w6,C,w3);
nor #(30)G7(w7,w4,w5); 
nor #(30)G8(F,w7,w6);
endmodule

