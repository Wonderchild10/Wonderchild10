/*Rising edge capture
  clk_i is faster than pulse	
  rise_o is asserted once detected a rising edge, stays asserted for one clock cycle*/
module rising_edge(
input clk_i, 
input pulse, 
output reg rise_o);

	reg s1;
	always@(posedge clk_i) begin
		if(pulse & (~s1))
			rise_o <= 1'b1;
		else
			rise_o <= 1'b0;
	
		s1 <= pulse;
		
	end
	
endmodule

/*falling edge capture
  clk_i is faster than pulse	
  fall_o is asserted once detected a falling edge, stays asserted for one clock cycle*/
module falling_edge(
input clk_i, 
input pulse, 
output reg fall_o);

	reg s1;
	always@(posedge clk_i) begin
		if((~pulse) & s1)
			fall_o <= 1'b1;
		else
			fall_o <= 1'b0;
	
		s1 <= pulse;
		
	end
	
endmodule

/*edge capture on both edges
  clk_i is faster than pulse	
  edge_o is asserted once detected a rising or falling edge, stays asserted for one clock cycle*/
module edge_detector (
input clk_i, 
input pulse, 
output reg edge_o);

	reg s1;
	always@(posedge clk_i) begin
		if(pulse ^ s1)
			edge_o <= 1'b1;
		else
			edge_o <= 1'b0;
	
		s1 <= pulse;
		
	end
	
endmodule


