module calculator (
	io_in,
	io_out
);
	
	input wire [7:0] io_in;
	output reg [7:0] io_out;

	reg clock;
	reg reset;
	reg en;
	reg [2:0] in;
	reg [1:0] arithmeticOperation;

	always @(*) begin
		clock = io_in[0];
		reset = io_in[1];
		en = io_in[2];
		in = io_in[5:3];
		arithmeticOperation = io_in[7:6];
	end

	wire enable;
	reg state;
	reg nextState;

	always @(posedge clock)
		if (reset)
			io_out <= 0;
		else if (enable)			
			case (arithmeticOperation)
				2'b00: io_out <= io_out + {5'b00000, in};
				2'b01: io_out <= io_out - {5'b00000, in};
				2'b10: io_out <= io_out ^ {5'b00000, in};
				2'b11: io_out <= io_out << {5'b00000, in};
			endcase

	always @(posedge clock)
		if (reset)
			state <= 1'd0;
		else
			state <= nextState;

	assign enable = (state == 1'd0) && (nextState == 1'd1);

	always @(*) begin		
		if (state == 1'd0)
			nextState = (en ? 1'd1 : 1'd0);
		else
			nextState = (en ? 1'd1 : 1'd0);
	end
	
endmodule
