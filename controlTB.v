`timescale 1ns / 1ps

module control_tb;

    reg clk;
    reg rst;
    reg [5:0] opcode;

    wire [1:0] wb;
    wire [2:0] mem;
    wire [3:0] ex;

    integer errors;
    integer i;

    control dut(
        .clk(clk),
        .rst(rst),
        .opcode(opcode),
        .wb(wb),
        .mem(mem),
        .ex(ex)
    );

    always #5 clk = ~clk;

    task check;
        input [5:0] test_opcode;
        input [1:0] expected_wb;
        input [2:0] expected_mem;
        input [3:0] expected_ex;

        begin
            opcode = test_opcode;
            #1;

            if ({wb, mem, ex} !==
                {expected_wb, expected_mem, expected_ex}) begin

                errors = errors + 1;
                $display(
                    "FAIL opcode=%b: wb=%b mem=%b ex=%b",
                    opcode, wb, mem, ex
                );
            end
        end
    endtask

    initial begin
        $dumpfile("control_tb.vcd");
        $dumpvars(0, control_tb);

        clk = 0;
        rst = 1;
        opcode = 0;
        errors = 0;

        // Reset must force all control signals to zero.
        check(6'b100011, 2'b00, 3'b000, 4'b0000);

        rst = 0;

        check(6'b000000, 2'b10, 3'b000, 4'b1100); // R
        check(6'b100011, 2'b11, 3'b010, 4'b0001); // LW
        check(6'b101011, 2'b00, 3'b001, 4'b0001); // SW
        check(6'b000100, 2'b00, 3'b100, 4'b0010); // BEQ

        // Every unsupported opcode should disable side effects.
        for (i = 0; i < 64; i = i + 1) begin
            if ((i != 0)  && (i != 35) &&
                (i != 43) && (i != 4)) begin
                check(i[5:0], 2'b00, 3'b000, 4'b0000);
            end
        end

        // Reassert reset after a valid instruction.
        check(6'b100011, 2'b11, 3'b010, 4'b0001);
        rst = 1;
        check(6'b100011, 2'b00, 3'b000, 4'b0000);

        if (errors == 0)
            $display("PASS: All control tests passed.");
        else
            $display("FAIL: %0d control tests failed.", errors);

        $finish;
    end

endmodule
