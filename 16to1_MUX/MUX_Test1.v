`timescale 1ns/1ps

module test_mux16_1;
	reg a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,sel3,sel2,sel1,sel0;
	wire out;
	mux_16to1_8 MUX1(a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,sel3,sel2,sel1,sel0,out);
	
	initial begin
		sel0=0;
		sel1=0;
		sel2=0;
		sel3=0;
		a=0;b=1;c=0;d=0;e=1;f=1;g=0;h=1;i=0;j=1;k=0;l=0;m=1;n=0;o=0;p = 0;
		
		#5 
		sel0=0;
		sel1=1;
		sel2=0;
		sel3=0;
		a=0;b=1;c=0;d=0;e=1;f=1;g=0;h=1;i=0;j=0;k=0;l=0;m=1;n=0;o=0;p = 0;
		
		#5 
		sel0=0;
		sel1=0;
		sel2=0;
		sel3=1;
		a=0;b=1;c=0;d=0;e=1;f=1;g=0;h=1;i=0;j=0;k=0;l=0;m=1;n=0;o=0;p = 0;
		
		#5 
		sel0=0;
		sel1=1;
		sel2=1;
		sel3=0;
		a=0;b=1;c=0;d=0;e=1;f=1;g=0;h=1;i=0;j=0;k=0;l=0;m=1;n=0;o=0;p = 0;
		
		#5 
		sel0=1;
		sel1=0;
		sel2=0;
		sel3=1;
		a=0;b=1;c=0;d=0;e=1;f=1;g=0;h=1;i=0;j=0;k=0;l=0;m=1;n=0;o=0;p = 0;
		
		#5 
		sel0=1;
		sel1=0;
		sel2=1;
		sel3=0;
		a=0;b=1;c=0;d=0;e=1;f=1;g=0;h=1;i=0;j=0;k=0;l=0;m=1;n=0;o=0;p = 0;
		
		#5 
		sel0=1;
		sel1=1;
		sel2=0;
		sel3=0;
		a=0;b=1;c=0;d=0;e=1;f=1;g=0;h=1;i=0;j=0;k=0;l=0;m=1;n=0;o=0;p = 0;
		
		#5 $finish;
	end
endmodule