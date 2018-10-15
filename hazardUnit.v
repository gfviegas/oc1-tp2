module hazardUnit (
    //INPUTS
    input wire reset, 
    input wire [4:0] rt, 
    input wire memRead, 
    input wire [31:0] instruction, 

    // OUTPUTS
    output reg controller, 
    output reg hzdPcWrite, 
    output reg hzdIfIdWrite
);

    always @(reset) begin
        hzdPcWrite <= 1'b0;
        hzdIfIdWrite <= 1'b0;
        controller <= 1'b1;
    end

    // Stall the pipeline if a hazard is detected;
    always @ (*) begin
        if (memRead && ((rt == instruction[25:21]) || (rt == instruction[20:16]))) begin
            hzdPcWrite <= 1'b0;
            hzdIfIdWrite <= 1'b0;
            controller <= 1'b1;
        end
        else begin
            hzdPcWrite <= 1'b1;
            hzdIfIdWrite <= 1'b1;
            controller <= 1'b0;
        end
    end
endmodule
