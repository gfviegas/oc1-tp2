
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module main_TP2(

	//////////// CLOCK //////////
	CLOCK_50,
	CLOCK2_50,
	CLOCK3_50,

	//////////// LED //////////
	LEDG,
	LEDR,

	//////////// KEY //////////
	KEY,

	//////////// SW //////////
	SW,

	//////////// SEG7 //////////
	HEX0,
	HEX1,
	HEX2,
	HEX3,
	HEX4,
	HEX5,
	HEX6,
	HEX7
);

	//=======================================================
	//  PARAMETER declarations
	//=======================================================


	//=======================================================
	//  PORT declarations
	//=======================================================

	//////////// CLOCK //////////
	input 		          		CLOCK_50;
	input 		          		CLOCK2_50;
	input 		          		CLOCK3_50;

	//////////// LED //////////
	output		     [8:0]		LEDG;
	output		    [17:0]		LEDR;

	//////////// KEY //////////
	input 		     [3:0]		KEY;

	//////////// SW //////////
	input 		    [17:0]		SW;

	//////////// SEG7 //////////
	output		     [6:0]		HEX0;
	output		     [6:0]		HEX1;
	output		     [6:0]		HEX2;
	output		     [6:0]		HEX3;
	output		     [6:0]		HEX4;
	output		     [6:0]		HEX5;
	output		     [6:0]		HEX6;
	output		     [6:0]		HEX7;


	//=======================================================
	//  REG/WIRE declarations
	//=======================================================




	//=======================================================
	//  Structural coding
	//=======================================================

	wire [31:0] instr;
	reg [31:0] div_clock;
	reg clock;

	initial begin
			div_clock = 0;
			clock = 0;
	end

	always @ (posedge CLOCK_50) begin
		div_clock = div_clock + 1;
		if (div_clock == 50000000) begin
			div_clock = 0;
			clock = ~clock;
		end
	end

	main m (.clock(clock), .instr(instr), .reset(SW[0]));
	setSeg d1 (instr[31:28], HEX7);
	setSeg d2 (instr[27:24], HEX6);
	setSeg d3 (instr[23:20], HEX5);
	setSeg d4 (instr[19:16], HEX4);
	setSeg d5 (instr[15:12], HEX3);
	setSeg d6 (instr[11:8], HEX2);
	setSeg d7 (instr[7:4], HEX1);
	setSeg d8 (instr[3:0], HEX0);

endmodule
