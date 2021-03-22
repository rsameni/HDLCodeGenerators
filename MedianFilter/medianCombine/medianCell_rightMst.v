																			  //				macros:
//					"DATA_LENGTH" , "LOG_WMAX" and "WMAX" are  macros(global constant) that is defined in "macro.vh" 
//					and you can run "script.py" and create "top.v" and "macro.vh" and set  their values .		
//					"DATA_LENGTH" determine length of each eleman of input signal for example 32 bits
//					"WMAX" is maximum size of median window that you can set it when run "script.py" and henceforth you just set input W less than WMAX.
//					"LOG_WMAX" is logarithm of WMAX that use for  determine number of bits that has needed for counter. 
//-----------------------------------------------------------------------------
`timescale 1 ns / 1 ps	  
`include "macro.vh"


module medianCell_rightMst(X , clk, reset, Z_L, R_L, T_L, R_old, R, T);
	
	input [`DATA_LENGTH-1:0]  X, R_L, R_old;
		
	input 	clk, reset;
	input	T_L, Z_L;
	
	
	output 	T;	  
	output 	[`DATA_LENGTH -1:0] R;
		
	wire [`DATA_LENGTH-1:0] muxData_R;	 	
		
	wire [1:0] S;
		
	reg  [`DATA_LENGTH-1:0] R;
		
	data_comparator dataCompOld(R_old, R, Z);
		
	mux4_1_data muxData( .in1(R), .in2(X), .in3(R_L), .in4(`DATA_LENGTH'b0), .out(muxData_R), .sel1(S[1:1]), .sel2(S[0:0]));		
	control_rightMst ctr(.Ti(T), .Ti_L(T_L), .Yi(Z), .Z_L(Z_L), .s(S));			  	
	data_comparator dataComp(X, R, T);
	
	always @(posedge clk)
	begin
		if(reset)
		begin
			R <= 0;			
		end
		else
		begin
			R <= muxData_R;				
		end
	end

endmodule		
							
			
			
			
			
			
			
				
							
						
					
					