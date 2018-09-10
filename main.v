// TEM QUE COMENTAR PRA RODAR NA FPGA
`include "alu.v"
`include "aluControl.v"
`include "dataMemory.v"
`include "instructionControl.v"
`include "instructionMemory.v"
`include "mux5Bits2.v"
`include "mux32Bits2.v"
`include "mux32Bits6.v"
`include "pc.v"
`include "registers.v"
`include "signExtend.v"
`include "shiftLeft.v"
`include "if_id.v"
`include "id_ex.v"
`include "ex_mem.v"
`include "mem_wb.v"

module main (clock, instr, reset);

  /*
   *
   * DECLARACAO DE FIOS DO COMPONENTE
   *
   */

  input wire clock;
  output wire reset;
  output reg [31:0] instr;
  // HELPERS PRA ADD
  reg [31:0] FOUR = 4;
  reg [3:0] ADD_CODE = 4'b0000;

  // PROGRAM COUNTER PLACEHOLDER
  wire [31:0] readAddress; // Endereco da Instrucao que o PC resolve

  // FIO QUE SAI DO INSTRUCTION MEMORY
  wire [31:0] instruction; // Instrucao -> Binario de 32 bits que será executado.
  wire [31:0] outInstruction; // Instrucao da saída do IF_ID

  // FIOS QUE SAEM DO CONTROL
  wire regDest;
  wire branch;
  wire memRead;
  wire memToReg;
  wire [1:0] aluOp;
  wire memWrite;
  wire aluSrc;
  wire regWrite;

  // FIOS QUE SAEM DO REGISTERS
  wire [31:0] readData1;
  wire [31:0] readData2;

  // FIO QUE SAI DO SIGNEXTEND
  wire [31:0] signExtendWire;

  // FIO QUE SAI DO ALUCONTROL
  wire [3:0] aluControlWire;

  // FIO QUE SAI DO DATA MEMORY
  wire [31:0] readDataMemory;

  // FIOS DE OUTPUT DOS MUXs
  wire [4:0] mux1; // Fio output do Mux na entrada de Registers
  wire [31:0] mux2; // Fio output do Mux na saida de Data Memory
  wire [31:0] mux3; // Fio output do Mux na saida de Registers
  wire [31:0] mux4; // Fio output do Mux na saida do Add ALU Result

  // FIOS DE INPUT DOS MUXs (Se necessários)
  wire mux4Input;

  // FIOS DE OUTPUT DAS ALUs
  wire [31:0] alu1; // FIO QUE SAI DA ALU ENTRE REGISTERS E DATA MEMORY
  wire alu1Zero; // FIO QUE RECEBE ZERO DA ALU ENTRE REGISTERS E DATA MEMORY
  wire [31:0] alu2; // FIO QUE SAI DA ALU QUE RECEBE O PC/4 (ADD)
  wire [31:0] alu3; // FIO QUE SAI DA ALU QUE RECEBE O SHIFT LEFT (ADD)
  wire [31:0] outPc; // Recebe resultado da ALU3 antes de ir para o PC

  // FIOS DE INPUT DAS ALUs (Se necessários)
  wire [31:0] alu3Input;

  // FIO AUXILIAR PRA COMPONENTES NAO UTILIZADAS
  wire helper;


  /*
   *
   * CHAMANDO E CONECTANDO COMPONENTES
   *
   */
   // PROGRAM COUNTER
   pc PC(
    .nextAddress(mux4),
    .clock(clock),
    .readAddress(readAddress)
   );

  // always @(posedge clock) begin
  //   if (reset)
  //     begin
  //
  //     end
  // end

  // INSTRUCTION MEMORY
  instructionMemory IM(
    .reset(reset),
    .readAddress(readAddress),
    .instruction(instruction)
  );

  // IF_ID
  ifId IFID(
    .pc(alu3),
    .instruction(instruction),
    .clock(clock),
    .outPc(outPc),
    .outInstruction(outInstruction)
  );

  // CONTROL
  instructionControl IC(
    .opCode(outInstruction[31:26]), // OpCode
    .regDest(regDest),
    .branch(branch),
    .memRead(memRead),
    .memToReg(memToReg),
    .aluOp(aluOp),
    .memWrite(memWrite),
    .aluSrc(aluSrc),
    .regWrite(regWrite)
  );

  // MUX ENTRADA REGISTERS
  mux5Bits2 MUX1(
    .entrada1(outInstruction[15:11]),
    .entrada2(outInstruction[20:16]),
    .seletor(regDest),
    .saida(mux1)
  );

  // REGISTERS
  registers REGS(
    .regWrite(regWrite),
    .register1(outInstruction[25:21]),
    .register2(outInstruction[20:16]),
    .writeRegister(mux1),
    .writeData(mux2),
    .readData1(readData1),
    .readData2(readData2)
  );

  // SIGNEXTEND
  signExtend SIGNEXTEND(
    .entrada(outInstruction[15:0]),
    .saida(signExtendWire)
  );

  // IMPLEMENTAR ID_EX
  // Somente para auxiliar na conexão dos fios
  // instructionControl IC(
  //   .opCode(outInstruction[31:26]), // OpCode
  //   .regDest(regDest),
  //   .branch(branch),
  //   .memRead(memRead),
  //   .memToReg(memToReg),
  //   .aluOp(aluOp),
  //   .memWrite(memWrite),
  //   .aluSrc(aluSrc),
  //   .regWrite(regWrite)
  // );
  //.entrada1(outInstruction[15:11]),
  //.entrada2(outInstruction[20:16]),

  // MUX DA SAIDA DE REGISTERS
  mux32Bits2 MUX3(
    .entrada1(signExtendWire),
    .entrada2(readData2),
    .seletor(aluSrc),
    .saida(mux3)
  );

  // ALU CONTROL
  aluControl ALUCONT(
    .aluOp(aluOp),
    .funct(outInstruction[5:0]),
    .saida(aluControlWire)
  );

  // ALU SAIDA DE REGISTERS, ENTRADA DE DATA MEMORY
  alu ALU1(
    .entrada1(readData1),
    .entrada2(mux3),
    .unidadeControle(aluControlWire),
    .saida(alu1),
    .zero(alu1Zero)
  );

  // IMPLEMENTAR EX_MEM
  exMem EX_MEM(
    // .clock(clock),
    // .readALU(alu1),
    // .PC(alu3),
    // .readWriteData(readData2),
    // .readWB(),
    // .readBranchAddress(),
    // .readRD(),
    // .readMem(memRead),
    // .readZF(),
    // .readBNE(),
    //
    // .aluResult(alu1),
    // .writeData(readData2),
    // .branchAddress(),
    // .rd(),
    // .wb(),
    // .ZF(),
    // .memRead(memRead),
    // .memWrite(memWrite),
    // .branch(),
    // .BNE()
  );

  // DATA MEMORY
  dataMemory DM(
    .address(alu1),
    .writeData(readData2),
    .memRead(memRead),
    .memWrite(memWrite),
    .readData(readDataMemory)
  );

  // IMPLEMENTAR MEM_WB
  memWb MEMWB(

  );

  // MUX SAIDA DATA MEMORY
  mux32Bits2 MUX2(
    .entrada1(readDataMemory),
    .entrada2(alu1),
    .seletor(memToReg),
    .saida(mux2)
  );

  // ZERO AND BRANCH
  assign mux4Input = (alu1Zero && branch);

  shiftLeft Shift(
    .shift_input(signExtendWire),
    .shift_output(alu3Input)
  );

  // ALU ADD + 4 DO PC
  alu ALU2(
    .entrada1(readAddress),
    .entrada2(FOUR),
    .unidadeControle(ADD_CODE),
    .saida(alu2),
    .zero(helper)
  );

  // ALU "ADD ALU RESULT"
  alu ALU3(
    .entrada1(alu2),
    .entrada2(alu3Input),
    .unidadeControle(ADD_CODE),
    .saida(alu3),
    .zero(helper)
  );

  // MUX SAIDA DAS DUAS ALUS PARA O PC
  mux32Bits2 MUX4(
    .entrada1(alu3),
    .entrada2(alu2),
    .seletor(mux4Input),
    .saida(mux4)
  );

  always @(posedge clock ) begin
    instr <= outInstruction;
  end
endmodule


module setSeg(in, out);
	input wire[3:0]in;
	output reg[6:0] out = 7'b1000000;

	always @ * begin
		case(in)
			4'b0000: out = 7'b1000000; //0
			4'b0001: out = 7'b1111001; //1
			4'b0010: out = 7'b0100100; //2
			4'b0011: out = 7'b0110000; //3
			4'b0100: out = 7'b0011001; //4
			4'b0101: out = 7'b0010010; //5
			4'b0110: out = 7'b0000010; //6
			4'b0111: out = 7'b1111000; //7
			4'b1000: out = 7'b0000000; //8
			4'b1001: out = 7'b0011000; //9
			4'b1010: out = 7'b0001000; //A
			4'b1011: out = 7'b0000011; //B
			4'b1100: out = 7'b1000110; //C
			4'b1101: out = 7'b0100001; //D
			4'b1110: out = 7'b0000110; //E
			4'b1111: out = 7'b0001110; //F

		endcase
	end
endmodule
