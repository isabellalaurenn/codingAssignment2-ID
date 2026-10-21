`timescale 1ps/1ps
`include "../src/signExt.v"

module signExtTB(

);
reg [15:0] imm;
wire [31:0] ext;

signExt DUT (
    .extended(ext),
    .immediate(imm)
);

initial begin
    $dumpfile("signExt.vcd");
    $dumpvars(0, signExtTB); // variables to be kept track of, 0 means we track all variables in this module
end

initial begin
    imm = 16'b1000000000000011;
    #1;
    imm = 16'b1000000000110000;
    #1;
    imm = 16'b0000000000111111;
    #1;
    imm = 16'b0000000000111011;
    #1;
    $display("Test Complete");
    $finish;
end

initial begin
    $monitor("Time=%0t imm=%b extended=%b",
        $time, imm, ext);
    
end
endmodule
