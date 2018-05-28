`include "alu.v"
`include "aluControl.v"
`include "dataMemory.v"
`include "instructionControl.v"
`include "instructionMemory.v"
`include "mux_2-1.v"
`include "mux_6-1.v"
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
  reg FOUR = 4;
  reg ADD_CODE = 4'b0010;

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
  wire mux1; // Fio output do Mux na entrada de Registers
  wire mux2; // Fio output do Mux na saida de Data Memory
  wire mux3; // Fio output do Mux na saida de Registers
  wire mux4; // Fio output do Mux na saida do Add ALU Result

  // FIOS DE INPUT DOS MUXs (Se necessários)
  wire mux4Input;

  // FIOS DE OUTPUT DAS ALUs
  wire alu1; // FIO QUE SAI DA ALU ENTRE REGISTERS E DATA MEMORY
  wire alu1Zero; // FIO QUE RECEBE ZEOR DA ALU ENTRE REGISTERS E DATA MEMORY
  wire alu2; // FIO QUE SAI DA ALU QUE RECEBE O PC/4 (ADD)
  wire alu3; // FIO QUE SAI DA ALU QUE RECEBE O SHIFT LEFT (ADD)

  // FIOS DE INPUT DAS ALUs (Se necessários)
  wire alu3Input;

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
  pc(
    mux4, // Lembrar de comentar essas coisas...
    readAdress
  );

  // INSTRUCTION MEMORY
  instructionMemory(
    clock,
    readAdress,
    instruction
  );

  // CONTROL
  instructionControl(
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
  mux2_1 MUX1(
    instrucao[15:11],
    instrucao[20:16],
    regDest,
    mux1
  );

  // REGISTERS
  registers(
    regWrite,
    instrucao[25:21],
    instrucao[20:16],
    mux1,
    mux2,
    readData1,
    readData2
  );

  // SIGNEXTEND
  signExtend(
    instrucao[15:0],
    signExtendWire
  );

  mux2_1 MUX3(
    signExtend,
    readData2,
    mux3
  );

  // ALU CONTROL
  aluControl(
    aluOp,
    instrucao[5:0],
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
  dataMemory(
    alu1,
    readData2,
    memRead,
    readDataMemory
  );

  // MUX SAIDA DATA MEMORY
  mux2_1 MUX2(
    readDataMemory,
    alu1,
    memToReg,
    mux2
  );

  // SHIFT LEFT 2
  assign alu3Input = signExtend << 2;
  // ZERO AND BRANCH
  assign mux4Input = (alu1Zero & branch);

  // ALU ADD + 4 DO PC
  alu ALU2(
    readAdress,
    FOUR,
    ADD_CODE,
    alu2
  );

  // ALU "ADD ALU RESULT"
  alu ALU3(
    alu2,
    alu3Input,
    ADD_CODE,
    alu3
  );

  // MUX SAIDA DAS DUAS ALUS PARA O PC
  mux2_1 MUX4(
    alu3,
    alu2,
    mux4Input,
    mux4
  );
endmodule
