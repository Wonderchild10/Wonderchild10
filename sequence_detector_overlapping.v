module seq_detect ( 
input wire clk, 
input wire  data_in, 
output wire data_out 
); 

reg [2:0] state;
reg hit;

//overlapping design
//target sequence is 10110
always@(posedge clk) begin
	case(state)	
			3'd0:	begin	//nothing
				if(data_in == 1'b1)
					state <= 3'd1;
			end
			
			3'd1:	begin	//1
				if(data_in == 1'b0)
					state <= 3'd2;
				else
					state <= 3'd1;
			end
			
			3'd2:	begin	//10
				if(data_in == 1'b1)
					state <= 3'd3;
				else
					state <= 3'd0;
			end
			
			3'd3:	begin	//101
				if(data_in == 1'b1)	
					state <= 3'd4;
				else
					state <= 3'd2;
			end
			
			3'd4:	begin	//1011
				if(data_in == 1'b0)	
					state <= 3'd2;
				else	
					state <= 3'd1;				
			end
	endcase
end

always@(posedge clk)	begin
	if((state == 3'd4) && (data_in == 1'b0))
		hit <= 1'b1;
	else
		hit <= 1'b0;
end

assign data_out = hit;

endmodule


