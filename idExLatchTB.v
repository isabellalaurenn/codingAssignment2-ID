`timescale 1ns / 1ps

module idExLatch_tb;

    reg clk;
    reg rst;

    reg [1:0] ctl_wb;
    reg [2:0] ctl_mem;
    reg [3:0] ctl_ex;

    reg [31:0] npc;
    reg [31:0] readdat1;
    reg [31:0] readdat2;
    reg [31:0] sign_ext;

    reg [4:0] instr_bits_20_16;
    reg [4:0] instr_bits_15_11;

    wire [1:0] wb_out;
    wire [2:0] mem_out;
    wire [3:0] ctl_out;

    wire [31:0] npc_out;
    wire [31:0] readdat1_out;
    wire [31:0] readdat2_out;
    wire [31:0] sign_ext_out;

    wire [4:0] instr_bits_20_16_out;
    wire [4:0] instr_bits_15_11_out;

    // Total width: 2 + 3 + 4 + (4 * 32) + 5 + 5 = 147
    wire [146:0] actual;
    reg  [146:0] expected;

    integer errors;

    idExLatch dut(
        .clk(clk),
        .rst(rst),
        .ctl_wb(ctl_wb),
        .ctl_mem(ctl_mem),
        .ctl_ex(ctl_ex),
        .npc(npc),
        .readdat1(readdat1),
        .readdat2(readdat2),
        .sign_ext(sign_ext),
        .instr_bits_20_16(instr_bits_20_16),
        .instr_bits_15_11(instr_bits_15_11),

        .wb_out(wb_out),
        .mem_out(mem_out),
        .ctl_out(ctl_out),
        .npc_out(npc_out),
        .readdat1_out(readdat1_out),
        .readdat2_out(readdat2_out),
        .sign_ext_out(sign_ext_out),
        .instr_bits_20_16_out(instr_bits_20_16_out),
        .instr_bits_15_11_out(instr_bits_15_11_out)
    );

    assign actual = {
        wb_out, mem_out, ctl_out,
        npc_out, readdat1_out, readdat2_out, sign_ext_out,
        instr_bits_20_16_out, instr_bits_15_11_out
    };

    always #5 clk = ~clk;

    task check;
        begin
            if (actual !== expected) begin
                errors = errors + 1;
                $display("FAIL at time %0t", $time);
                $display("Expected: %h", expected);
                $display("Actual:   %h", actual);
            end
        end
    endtask

    initial begin
        $dumpfile("idExLatch_tb.vcd");
        $dumpvars(0, idExLatch_tb);

        clk = 0;
        rst = 0;
        errors = 0;
        expected = 147'b0;

        ctl_wb = 0;
        ctl_mem = 0;
        ctl_ex = 0;
        npc = 0;
        readdat1 = 0;
        readdat2 = 0;
        sign_ext = 0;
        instr_bits_20_16 = 0;
        instr_bits_15_11 = 0;

        // Assert reset between clock edges.
        #1 rst = 1;
        #1;
        check;

        // Release reset and apply first instruction's data.
        rst = 0;

        ctl_wb = 2'b11;
        ctl_mem = 3'b010;
        ctl_ex = 4'b0001;
        npc = 32'h00000004;
        readdat1 = 32'h11111111;
        readdat2 = 32'h22222222;
        sign_ext = 32'hFFFFFFFC;
        instr_bits_20_16 = 5'd8;
        instr_bits_15_11 = 5'd9;

        // Outputs must still contain reset values.
        #1;
        check;

        @(posedge clk);
        #1; // Allow nonblocking assignments to finish.

        expected = {
            2'b11, 3'b010, 4'b0001,
            32'h00000004, 32'h11111111,
            32'h22222222, 32'hFFFFFFFC,
            5'd8, 5'd9
        };
        check;

        // Change every field between rising edges.
        ctl_wb = 2'b10;
        ctl_mem = 3'b000;
        ctl_ex = 4'b1100;
        npc = 32'h00000008;
        readdat1 = 32'hAAAAAAAA;
        readdat2 = 32'h55555555;
        sign_ext = 32'h00000010;
        instr_bits_20_16 = 5'd3;
        instr_bits_15_11 = 5'd17;

        #1;
        check; // Must still hold the first instruction.

        @(negedge clk);
        #1;
        check; // Falling edge must not update outputs.

        @(posedge clk);
        #1;

        expected = {
            2'b10, 3'b000, 4'b1100,
            32'h00000008, 32'hAAAAAAAA,
            32'h55555555, 32'h00000010,
            5'd3, 5'd17
        };
        check;

        // Asynchronous reset must clear stored data immediately.
        #1 rst = 1;
        #1;
        expected = 147'b0;
        check;

        // Reset must also keep outputs zero at a rising edge.
        @(posedge clk);
        #1;
        check;

        // After reset, capture the still-present inputs again.
        @(negedge clk);
        rst = 0;

        @(posedge clk);
        #1;

        expected = {
            2'b10, 3'b000, 4'b1100,
            32'h00000008, 32'hAAAAAAAA,
            32'h55555555, 32'h00000010,
            5'd3, 5'd17
        };
        check;

        if (errors == 0)
            $display("PASS: All ID/EX latch tests passed.");
        else
            $display("FAIL: %0d ID/EX latch tests failed.", errors);

        $finish;
    end

endmodule
