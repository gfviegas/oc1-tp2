module shiftLeft (shift_input, shift_output);

	input [31:0] shift_input;
	output wire [31:0] shift_output;

    // é preciso de um auxiliar para não interferir no resto do circuito
	reg [31:0] aux;

	always @(*) begin
		aux = shift_input << 2; // shift left de 2
	end

	assign shift_output = aux;

endmodule
