module queue (
	clk,
	reset,
	q,
	d,
	enqueue,
	dequeue,
	full,
	empty
);

	parameter WIDTH = 11;
	parameter DEPTH = 7;

	input                    clk;
	input                    reset;
	input      [WIDTH - 1:0] d;
	output reg [WIDTH - 1:0] q;
	output wire 			 full;
	output wire				 empty;
	input                    enqueue;
	input                    dequeue;

	reg [DEPTH - 1:0] eq_ptr;
	reg [DEPTH - 1:0] dq_ptr;
	reg [WIDTH - 1:0] stack [0:(1 << DEPTH) - 1];
	reg [1:0]		  op_prev; //record previous operation is enqueue or dequeue
	
	 
	always @(posedge clk) begin
		if (reset)    begin
			eq_ptr <= 0;
			dq_ptr <= 0;
			op_prev <= 2'b00;
		end	
		else if (enqueue) begin	//implement wrapping method
			op_prev <= 2'b01;
			if(!full)	begin
				//wrapping
				if(&eq_ptr)
				eq_ptr <= 0;
				else
				eq_ptr <= eq_ptr + 1;
			end
		end		
		else if (dequeue)	begin 
			op_prev <= 2'b10;
			if(!empty)	begin
				//wrapping 
				if(&dq_ptr)
				dq_ptr <= 0;
				else
				dq_ptr <= dq_ptr + 1;
			end
		end	
	end
	
	//to implement full and empty. ignore write when full and ignore read when empty
	always @(posedge clk) begin
		if (enqueue || dequeue) begin
			if(enqueue && (!full))
				stack[eq_ptr] <= q;
			if(dequeue && (!empty))
				q <= stack[dq_ptr];
		end
	end
	
	assign full =  (eq_ptr == dq_ptr)? ((op_prev == 2'b01)? 1:0):0;
	assign empty = (eq_ptr == dq_ptr)? ((op_prev == 2'b10)? 1:0):0;
	
endmodule