`timescale 1ns / 1ps

module control(
    input wire       clk,
    input wire       rst,
    input wire [5:0] opcode,

    output reg [1:0] wb,
    output reg [2:0] mem,
    output reg [3:0] ex
);

    // Control bus order:
    // wb  = {RegWrite, MemToReg}
    // mem = {Branch, MemRead, MemWrite}
    // ex  = {RegDst, ALUOp[1:0], ALUSrc}

    // clk is retained to match the professor's template.
    // This module is combinational, so it does not use clk.

    always @(*) begin
        // Defaults also cover reset and unsupported opcodes.
        wb  = 2'b00;
        mem = 3'b000;
        ex  = 4'b0000;

        if (!rst) begin
            case (opcode)
                6'b000000: begin // R-format
                    wb  = 2'b10;
                    mem = 3'b000;
                    ex  = 4'b1100;
                end

                6'b100011: begin // LW
                    wb  = 2'b11;
                    mem = 3'b010;
                    ex  = 4'b0001;
                end

                6'b101011: begin // SW
                    wb  = 2'b00;
                    mem = 3'b001;
                    ex  = 4'b0001;
                end

                6'b000100: begin // BEQ
                    wb  = 2'b00;
                    mem = 3'b100;
                    ex  = 4'b0010;
                end

                default: begin
                    wb  = 2'b00;
                    mem = 3'b000;
                    ex  = 4'b0000;
                end
            endcase
        end
    end

endmodule
