module ID_EX (
    input wire clock,

    // ID_EX
    input wire [31:0] readData1,
    input wire [31:0] readData2,
    input wire [31:0] signExtendWire,
    input wire [4:0] rd,
    input wire [4:0] rt,
    input wire [31:0] if_id,

    // WB
    input wire regWrite,
    input wire memToReg,

    // Memory Access
    input wire branch,
    input wire memRead,
    input wire memWrite,

    // EX
    input wire regDest,
    input wire aluOp,
    input wire aluSrc,

    // Output ID_EX
    output wire [0:31] outReadData1,
    output wire [0:31] outReadData2,
    output wire [0:31] outSignExtendWire,
    output wire [4:0] outRd,
    output wire [4:0] outRt,
    output wire [31:0] outIf_id

    // Output WB
    output wire outRegWrite,
    output wire outMemToReg,

    // Output Memory Access
    output wire outBranch,
    output wire outMemRead,
    output wire outMemWrite,

    // Output EX
    output wire outRegDst,
    output wire [1:0] outAluOp,
    output wire outAluSrc,
);

    initial begin
        // ID_EX
        readData1 <= 0;
        readData2 <= 0;
        signExtendWire <= 0;
        rd <= 0;
        rt <= 0;
        if_id <= 0;

        // WB
        regWrite <= 0;
        memToReg <= 0;

        // Memory Access
        branch <= 0;
        memRead <= 0;
        memWrite <= 0;

        // EX
        regDest <= 0;
        aluOp <= 0;
        aluSrc <= 0;
    end

    always @(posedge clock) begin
        // ID_EX
        outReadData1 <= readData1;
        outReadData2 <= readData2;
        outSignExtendWire <= signExtendWire;
        outRd <= rd;
        outRt <= rt;
        outIf_id <= if_id;

        // WB
        outRegWrite <= regWrite;
        outMemToReg <= memToReg;

        // Memory Access
        outBranch <= branch;
        outMemRead <= memRead;
        outMemWrite <= memWrite;

        // EX
        outRegDest <= regDest;
        outAluOp <= aluOp;
        outAluSrc <= aluSrc;
    end

endmodule
