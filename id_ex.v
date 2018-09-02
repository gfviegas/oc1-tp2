module ID_EX (
    input wire clock,

    // ID_EX
    output reg [31:0] readData1,
    output reg [31:0] readData2,
    output reg [31:0] signExtendWire,
    output reg [4:0] rd,
    output reg [4:0] rt,
    output reg [31:0] if_id,

    // WB
    output reg regWrite,
    output reg memToReg,

    // Memory Access
    output reg branch,
    output reg memRead,
    output reg memWrite,

    // EX
    output reg regDest,
    output reg aluOp,
    output reg aluSrc,

    // Output ID_EX
    output reg [0:31] outReadData1,
    output reg [0:31] outReadData2,
    output reg [0:31] outSignExtendWire,
    output reg [4:0] outRd,
    output reg [4:0] outRt,
    output reg [31:0] outIf_id,

    // Output WB
    output reg outRegWrite,
    output reg outMemToReg,

    // Output Memory Access
    output reg outBranch,
    output reg outMemRead,
    output reg outMemWrite,

    // Output EX
    output reg outRegDest,
    output reg [1:0] outAluOp,
    output reg outAluSrc
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
