`timescale 1 ns/100ps
module t_c1;
wire F;
reg A,B,C,D;

c1 M1(A,B,C,D,F);

initial
	begin
		A=1'b0; B=1'b0; C=1'b0; D=1'b0;
        #200 A=1'b0; B=1'b0; C=1'b0; D=1'b1;
        #200 A=1'b0; B=1'b0; C=1'b1; D=1'b0;
        #200 A=1'b0; B=1'b0; C=1'b1; D=1'b1;
        #200 A=1'b0; B=1'b1; C=1'b0; D=1'b0;
        #200 A=1'b0; B=1'b1; C=1'b0; D=1'b1;
        #200 A=1'b0; B=1'b1; C=1'b1; D=1'b0;
        #200 A=1'b0; B=1'b1; C=1'b1; D=1'b1;
        #200 A=1'b1; B=1'b0; C=1'b0; D=1'b0;
        #200 A=1'b1; B=1'b0; C=1'b0; D=1'b1;
        #200 A=1'b1; B=1'b0; C=1'b1; D=1'b0;
        #200 A=1'b1; B=1'b0; C=1'b1; D=1'b1;
        #200 A=1'b1; B=1'b1; C=1'b0; D=1'b0;
        
	end
initial #2600 $finish;
initial $dumpvars;
endmodule
		
