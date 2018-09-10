// TEM QUE COMENTAR PRA RODAR NA FPGA
`include "alu.v"
`include "aluControl.v"
`include "dataMemory.v"
`include "instructionControl.v"
`include "instructionMemory.v"
`include "mux5Bits2.v"
`include "mux32Bits2.v"
`include "mux32Bits3.v"
`include "mux32Bits6.v"
`include "pc.v"
`include "registers.v"
`include "signExtend.v"
`include "shiftLeft.v"
`include "if_id.v"
`include "id_ex.v"
`include "ex_mem.v"
`include "mem_wb.v"
`include "fowarding.v"

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
  wire [31:0] muxUla;

  // FIO AUXILIAR PRA COMPONENTES NAO UTILIZADAS
  wire helper;

  // Fios control WB MEM EX
  wire [3:0] exControl;
  wire [2:0] memControl;
  wire [1:0] wbControl;

  // FIOS QUE SAEM DO ID/EX
  wire regDest;
  wire [1:0] aluOp;
  wire aluSrc;
  wire branch;
  wire memRead;
  wire memWrite;
  wire memToReg;
  wire regWrite;
  wire [31:0] readDataIdEx1;
  wire [31:0] readDataIdEx2;
  wire [31:0] signExtendIdEx;
  wire [4:0] rd;
  wire [4:0] rt;
  wire [31:0] ifId;

  wire [2:0] memControlIdEx;
  wire [1:0] wbControlIdEx;


  // FIOS QUE SAEM DE EX/MEM
  wire [1:0] wbControlExMem;
  wire branchExMem;
  wire memReadExMem;
  wire memWriteExMem;

  wire [31:0] aluResult;
  wire [31:0] aluZero;
  wire [31:0] pc;
  wire [31:0] registerData;
  wire [31:0] writeRegister;

  // FIOS QUE SAEM DE MEM/WB
  input wire regWriteMemWb;
  input wire memToRegMemWb;

  input wire readDataMemoryMemWb;
  input wire aluResultMemWb;
  input wire writeRegisterMemWb;

  // FIOS QUE SAEM DA UNIDADE DE FOWARDING
  wire [1:0] fowardA;
  wire [1:0] fowardB;

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
    .exControl(exControl),
    .memControl(memControl),
    .wbControl(wbControl)
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
  idEx ID_EX(
    .clock(clock),

    // Inputs
    // EX
    .regDestInput(exControl[3]),
    .aluOpInput(exControl[2:1]),
    .aluSrcInput(exControl[0]),

    // MEM
    .memControlInput(memControl),

    // WB
    .wbControlInput(wbControl),

    // ID_EX
    .readData1Input(readData1),
    .readData2Input(readData2),
    .signExtendWireInput(signExtendWire),
    .rdInput(outInstruction[15:11]),
    .rtInput(outInstruction[20:16]),
    .ifIdInput(outPc),

    // Outputs
    // EX
    .regDest(regDest),
    .aluOp(aluOp),
    .aluSrc(aluSrc),

    // MEM
    .memControlIdEx(memControlIdEx),

    // WB
    .wbControlIdEx(wbControlIdEx),

    // ID_EX
    .readData1(readDataIdEx1),
    .readData2(readDataIdEx2),
    .signExtendWire(signExtendIdEx),
    .rd(rd),
    .rt(rt),
    .ifId(ifId)
  );

  // MUX ENTRADA REGISTERS
  mux5Bits2 MUX1(
    .entrada1(rd),
    .entrada2(rt),
    .seletor(regDest),
    .saida(mux1)
  );

  // MUX DA SAIDA DE REGISTERS
  mux32Bits3 MUX3(
    .entrada1(readData2),
    .entrada2(alu1),
    .entrada2(mux2),
    .seletor(fowardB),
    .saida(mux3)
  );

  // ALU CONTROL
  aluControl ALUCONT(
    .aluOp(aluOp),
    .funct(outInstruction[5:0]),
    .saida(aluControlWire)
  );

  // MUX FOWARDING-ULA
  mux32bits3 MUXULA(
    .entrada1(readData1),
    .entrada2(alu1),
    .entrada3(mux2),
    .seletor(fowardA),
    .saida(muxUla)
  );

  // ALU SAIDA DE REGISTERS, ENTRADA DE DATA MEMORY
  // ULA PRINCIPAL
  alu ALU1(
    .entrada1(muxUla),
    .entrada2(mux3),
    .unidadeControle(aluControlWire),
    .saida(alu1),
    .zero(alu1Zero)
  );

  // UNIDADE DE FOWARDING
  fowarding FOWARDING(
    .clock(clock),

    // INPUTS
    .rs(),
    .rt(rt),

    // EX/MEM
    // .rdExMem(),
    // .memControlInput(),
    //
    // // MEM/WB
    // .wbControlInput(),
    // .rdMemWb(),


    // OUTPUTS
    .fowardA(fowardA),
    .fowardB(fowardB)
  );

  // EX_MEM
  exMem EX_MEM(
    .clock(clock),

    // INPUTS
    // MEM
    .memControlInput(memControlIdEx),

    // WB
    .wbControlInput(wbControlIdEx),

    // EX_MEM
    .aluResultInput(alu1),
    .aluZeroInput(alu1Zero),
    .pcInput(alu3),
    .registerDataInput(readDataIdEx2),
    .writeRegisterInput(mux1),


    // OUTPUTS
    .wbControlExMem(wbControlExMem),
    .branch(branchExMem),
    .memRead(memReadExMem),
    .memWrite(memWriteExMem),

    .aluResult(aluResult),
    .aluZero(aluZero),
    .pc(pc),
    .registerData(registerData),
    .writeRegister(writeRegister)
  );

  // DATA MEMORY
  dataMemory DM(
    .address(aluResult),
    .writeData(registerData),
    .memRead(memReadExMem),
    .memWrite(memWriteExMem),
    .readData(readDataMemory)
  );

  // IMPLEMENTAR MEM_WB
  memWb MEMWB(
    .clock(clock),

    // INPUTS
    .readDataMemoryInput(readDataMemory),
    .aluResultInput(aluResult),
    .writeRegisterInput(writeRegister),

    // OUTPUTS
    .regWrite(regWriteMemWb),
    .memToReg(memToRegMemWb),
    .readDataMemory(readDataMemoryMemWb),
    .aluResult(aluResultMemWb),
    .writeRegister(writeRegisterMemWb)
  );

  // MUX SAIDA DATA MEMORY
  mux32Bits2 MUX2(
    .entrada1(readDataMemory),
    .entrada2(alu1),
    .seletor(memToReg),
    .saida(mux2)
  );

  // ZERO AND BRANCH
  assign mux4Input = (aluZero && branchExMem);

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
