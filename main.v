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

module main (
  input clock
);

  /*
   *
   * DECLARACAO DE FIOS DO COMPONENTE
   *
   */
  // HELPERS PRA ADD
  reg [31:0] FOUR = 4;
  reg [3:0] ADD_CODE = 4'b0010;

  // FIO QUE SAI DO PC
  wire [31:0] readAdress; // Endereco da Instrucao que o PC resolve
  // FIO QUE SAI DO INSTRUCTION MEMORY
  wire [31:0] instruction; // Instrucao -> Binario de 32 bits que será executado.

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
  wire alu1Zero; // FIO QUE RECEBE ZEOR DA ALU ENTRE REGISTERS E DATA MEMORY
  wire [31:0] alu2; // FIO QUE SAI DA ALU QUE RECEBE O PC/4 (ADD)
  wire [31:0] alu3; // FIO QUE SAI DA ALU QUE RECEBE O SHIFT LEFT (ADD)

  // FIOS DE INPUT DAS ALUs (Se necessários)
  wire [31:0] alu3Input;

  // FIO AUXILIAR PRA COMPONENTES NAO UTILIZADAS
  wire aux;

  /*
   *
   * CHAMANDO E CONECTANDO COMPONENTES
   *
   */

  always @(posedge clock) begin
  end

  // PROGRAM COUNTER
  pc PC(
    mux4, // Lembrar de comentar essas coisas...
    readAdress
  );

  // INSTRUCTION MEMORY
  instructionMemory IM(
    clock,
    readAdress,
    instruction
  );

  // CONTROL
  instructionControl IC(
    instruction[31:26], // OpCode
    regDest,
    branch,
    memRead,
    memToReg,
    aluOp,
    memWrite,
    aluSrc,
    regWrite
  );

  // MUX ENTRADA REGISTERS
  mux5Bits2 MUX1(
    instruction[15:11],
    instruction[20:16],
    regDest,
    mux1
  );

  // REGISTERS
  registers REGS(
    regWrite,
    instruction[25:21],
    instruction[20:16],
    mux1,
    mux2,
    readData1,
    readData2
  );

  // SIGNEXTEND
  signExtend SIGNEXTEND(
    instruction[15:0],
    signExtendWire
  );

  // MUX DA SAIDA DE REGISTERS
  mux32Bits2 MUX3(
    signExtendWire,
    readData2,
    aluSrc,
    mux3
  );

  // ALU CONTROL
  aluControl ALUCONT(
    aluOp,
    instruction[5:0],
    aluControlWire
  );

  // ALU SAIDA DE REGISTERS, ENTRADA DE DATA MEMORY
  alu ALU1(
    readData1,
    mux3,
    aluControlWire,
    alu1,
    alu1Zero
  );

  // DATA MEMORY
  dataMemory DM(
    alu1,
    readData2,
    memRead,
    readDataMemory
  );

  // MUX SAIDA DATA MEMORY
  mux32Bits2 MUX2(
    readDataMemory,
    alu1,
    memToReg,
    mux2
  );

  // SHIFT LEFT 2
  assign alu3Input = signExtendWire << 2;
  // ZERO AND BRANCH
  assign mux4Input = (alu1Zero & branch);

  // ALU ADD + 4 DO PC
  alu ALU2(
    readAdress,
    FOUR,
    ADD_CODE,
    alu2,
    helper
  );

  // ALU "ADD ALU RESULT"
  alu ALU3(
    alu2,
    alu3Input,
    ADD_CODE,
    alu3,
    helper
  );

  // MUX SAIDA DAS DUAS ALUS PARA O PC
  mux32Bits2 MUX4(
    alu3,
    alu2,
    mux4Input,
    mux4
  );
endmodule
