
//RCA & CLA
`timescale 1 ns/100ps
//-TestBench-
module Adder_TB ();
  reg [15:0]A;
  reg [15:0]B;
  wire [15:0]S1;
  wire [15:0]S2;
  wire Cout1;
  wire Cout2;
  reg Cin;
  
  RCA_16bit RCA(A,B,Cin,S1,Cout1);
  CLA_16bit CLA(A,B,Cin,S2,Cout2);
  
  initial
    begin
      #100
      A = 16'b0; B = 16'b0; Cin = 1'b0;
      #400 A = 16'b0001001101100100; B = 16'b000000010000; Cin = 1'b0;
      #400 A = 16'b0000000000001000; B = 16'b000000010000; Cin = 1'b0;
      #400 A = 16'b0000000000000010; B = 16'b000000010000; Cin = 1'b0; //2+16
      #400 A = 16'b1111111111111110; B = 16'b111111111111; Cin = 1'b0;
    end
initial #2000 $finish;
initial $dumpvars;
endmodule


//Full Adder 
module FullAdder(S, Co, x, y, Ci);
  input x , y , Ci;
  output S, Co;
  wire s1 , d1 , d2;

  xor #(20) g1(s1, x, y);
  and #(10) g2(d1, x, y);
  and #(10) g3(d2, Ci, s1);
  xor #(20) g4(S, Ci, s1);
  or #(15) g5(Co, d1, d2);
endmodule


//4-bit CLA 
module CLA_4bit(S , Cout , A , B , Cin);
  input [3:0]A;
  input [3:0]B; 
  input Cin;
  output Cout; 
  output[3:0]S;
  wire [3:1]C;
  wire [0:3]P; 
  wire [0:3]G;
  
  //G 
  and #(10) g0(G[0] , A[0] , B[0]);
  and #(10) g1(G[1] , A[1] , B[1]);
  and #(10) g2(G[2] , A[2] , B[2]);
  and #(10) g3(G[3] , A[3] , B[3]);
  
  //P
  xor #(20) p0(P[0] , A[0] , B[0]);
  xor #(20) p1(P[1] , A[1] , B[1]);
  xor #(20) p2(P[2] , A[2] , B[2]);
  xor #(20) p3(P[3] , A[3] , B[3]);
  
  //C1
  wire tmp1;
  and #(10) c11(tmp1 , P[0] , Cin);
  or #(15) c12(C[1] , G[0] , tmp1);
  //C2
  wire tmp2;
  wire tmp3;
  and #(10) c21(tmp2 , P[1] , G[0]);
  and #(15) c22(tmp3 , P[1] , P[0] , Cin);
  or #(20) c23(C[2] , tmp2 , tmp3 , G[1]);
  //C3
  wire tmp4;
  wire tmp5;
  wire tmp6;
  and #(10) c31(tmp4 , P[2] , G[1]);
  and #(15) c32(tmp5 , P[2] , P[1] , G[0]);
  and #(20) c33(tmp6 , P[2] , P[1] , P[0] , Cin);
  or #(25) c34(C[3] , tmp4 , tmp5 , tmp6 , G[2]);
  //Cout
  wire tmp7;
  wire tmp8;
  wire tmp9;
  wire tmp10;
  and #(10) c41(tmp7 , P[3] , G[2]);
  and #(15) c42(tmp8 , P[3] , P[2] , G[1]);
  and #(20) c43(tmp9 , P[3] , P[2] , P[1] , G[0]);
  and #(25) c44(tmp10 , P[3] , P[2] , P[1] , P[0] , Cin);
  or #(30) c45(Cout , tmp7 , tmp8 , tmp9 , tmp10 , G[3]);
  
  /// Making Sums
  xor #(20) s0(S[0] , P[0] , Cin);
  xor #(20) s1(S[1] , P[1] , C[1]);
  xor #(20) s2(S[2] , P[2] , C[2]);
  xor #(20) s3(S[3] , P[3] , C[3]);  
endmodule 

//RCA

module RCA_16bit(A,B,Cin,S,Cout); 
  input [15:0]A; 
  input [15:0]B; 
  input Cin; 
  output [15:0]S; 
  output Cout;  
  wire [15:1]carry;
  
  
  FullAdder f0(S[0] , carry[1] , A[0] , B[0] , Cin);
  FullAdder f1(S[1] , carry[2] , A[1] , B[1] , carry[1]);
  FullAdder f2(S[2] , carry[3] , A[2] , B[2] , carry[2]);
  FullAdder f3(S[3] , carry[4] , A[3] , B[3] , carry[3]);
  FullAdder f4(S[4] , carry[5] , A[4] , B[4] , carry[4]);
  FullAdder f5(S[5] , carry[6] , A[5] , B[5] , carry[5]);
  FullAdder f6(S[6] , carry[7] , A[6] , B[6] , carry[6]);
  FullAdder f7(S[7] , carry[8] , A[7] , B[7] , carry[7]);
  FullAdder f8(S[8] , carry[9] , A[8] , B[8] , carry[8]);
  FullAdder f9(S[9] , carry[10] , A[9] , B[9] , carry[9]);
  FullAdder f10(S[10] , carry[11] , A[10] , B[10] , carry[10]);
  FullAdder f11(S[11] , carry[12] , A[11] , B[11] , carry[11]);
  FullAdder f12(S[12] , carry[13] , A[12] , B[12] , carry[12]);
  FullAdder f13(S[13] , carry[14] , A[13] , B[13] , carry[13]);
  FullAdder f14(S[14] , carry[15] , A[14] , B[14] , carry[14]);
  FullAdder f15(S[15] , Cout , A[15] , B[15] , carry[15]);
  
endmodule 

// CLA

module CLA_16bit(A,B,Cin,S,Cout); 
  input [15:0]A; 
  input [15:0]B; 
  input Cin; 
  output [15:0]S; 
  output Cout;   
  wire [3:1]C;
  
  CLA_4bit F0_3 (S[3:0] , C[1] , A[3:0] , B[3:0] , Cin);
  CLA_4bit F4_7 (S[7:4] , C[2] , A[7:4] , B[7:4] , C[1]);
  CLA_4bit F8_11 (S[11:8] , C[3] , A[11:8] , B[11:8] , C[2]);
  CLA_4bit F12_15 (S[15:12] , Cout , A[15:12] , B[15:12] , C[3]);
  
endmodule
