//downscale clock to 1/6 of its frequency
module clock_downscale (
	input  clk_i,
	output reg clk_o
);
	
	//count to 3 and toggle 
	reg [1:0] counter; 
	
	always@(posedge clk_i)	begin
		counter <= counter + 1'b1; 
		if(counter == 2'd2)	begin
			clk_o <= ~clk_o;
			counter <= 2'd0;
		end
	end

endmodule 
