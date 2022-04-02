module stack (
	clk,
	reset,
	q,
	d,
	push,
	pop,
	overflow_o,	//sticky
	underflow_o	//sticky
);

	parameter WIDTH = 11;
	parameter DEPTH = 7;

	input                    clk;
	input                    reset;
	input      [WIDTH - 1:0] d;
	output reg [WIDTH - 1:0] q;
	input                    push;
	input                    pop;
	output	wire		 overflow_o;
	output	wire		 underflow_o;

	reg [DEPTH - 1:0]   ptr;
	//reg [WIDTH - 1:0] stack [0:(1 << DEPTH) - 1];
	reg [WIDTH - 1:0]   stack [0:(2**DEPTH) - 1];
	reg		    overflow;
	reg		    underflow;
	
	
	always @(posedge clk) begin
		if (reset)    begin
			ptr <= 0;
			overflow <= 0;
			underflow <= 0;
		end	
		else if (!(overflow || underflow))	begin
			if (push)
			ptr <= ptr + 1;
			else if (pop)
			ptr <= ptr - 1;
		end	
	end

	always @(posedge clk) begin
		if(overflow || underflow)
		$display("Error State!!");
		
		else if (push || pop) begin
			if(push)
			stack[ptr] <= q;

			q <= stack[ptr - 1];
		end
	end
	
	always @(posedge clk) begin
		if ((ptr == 1'b0) && (pop))
			underflow <= 1'b1;
		else if (&ptr && push)
			overflow <= 1'b1;
	end
	
	assign	overflow_o  = overflow;
	assign	underflow_o = underflow;
	
endmodule
