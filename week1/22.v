`timescale 1 ns/100ps
module t_Simple_Circuit_prop_delay;
wire F;
reg A,B,C,D,E;

Simple_Circuit_prop_delay M1(A,B,C,D,E,F);

initial
	begin
		E=1'b0; A=1'b0; B=1'b0; C=1'b0; D=1'b0;
        #200 E=1'b0; A=1'b0; B=1'b0; C=1'b1; D=1'b1;
        #200 E=1'b0; A=1'b0; B=1'b1; C=1'b0; D=1'b0;
        #200 E=1'b0; A=1'b0; B=1'b1; C=1'b0; D=1'b1;
        #200 E=1'b0; A=1'b1; B=1'b1; C=1'b0; D=1'b0;
        #200 E=1'b0; A=1'b0; B=1'b1; C=1'b1; D=1'b1;
        #200 E=1'b0; A=1'b1; B=1'b0; C=1'b0; D=1'b0;
        #200 E=1'b0; A=1'b1; B=1'b0; C=1'b0; D=1'b1;
        #200 E=1'b0; A=1'b1; B=1'b0; C=1'b1; D=1'b0;
        #200 E=1'b0; A=1'b0; B=1'b0; C=1'b0; D=1'b1;
        #200 E=1'b0; A=1'b1; B=1'b0; C=1'b1; D=1'b1;
        #200 E=1'b1; A=1'b1; B=1'b1; C=1'b0; D=1'b0;
        #200 E=1'b1; A=1'b0; B=1'b0; C=1'b0; D=1'b1;
        #200 E=1'b0; A=1'b1; B=1'b1; C=1'b0; D=1'b1;
        #200 E=1'b1; A=1'b0; B=1'b1; C=1'b0; D=1'b1;
        #200 E=1'b0; A=1'b0; B=1'b0; C=1'b1; D=1'b0;
        #200 E=1'b1; A=1'b0; B=1'b1; C=1'b1; D=1'b1;
        #200 E=1'b0; A=1'b1; B=1'b1; C=1'b1; D=1'b1;
        #200 E=1'b1; A=1'b0; B=1'b0; C=1'b0; D=1'b0;
        #200 E=1'b0; A=1'b1; B=1'b1; C=1'b1; D=1'b0;
        #200 E=1'b1; A=1'b0; B=1'b0; C=1'b1; D=1'b0;
        #200 E=1'b0; A=1'b0; B=1'b1; C=1'b1; D=1'b0;
        #200 E=1'b1; A=1'b1; B=1'b1; C=1'b0; D=1'b1;
        #200 E=1'b1; A=1'b0; B=1'b0; C=1'b1; D=1'b1;
        #200 E=1'b1; A=1'b0; B=1'b1; C=1'b0; D=1'b0;
        #200 E=1'b1; A=1'b1; B=1'b0; C=1'b0; D=1'b0;
        #200 E=1'b1; A=1'b1; B=1'b0; C=1'b0; D=1'b1;
        #200 E=1'b1; A=1'b1; B=1'b0; C=1'b1; D=1'b0;
	end
initial #5400 $finish;
initial $dumpvars;
endmodule