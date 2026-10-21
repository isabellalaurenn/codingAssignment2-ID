// signExt.v - this module takes a 16-bit input (immediate) and extends it to a 32-bit output (extended) using its MSB
// no clock needed
module signExt(
    input wire [15:0] immediate, // 16-bit (original) input 
    output wire [31:0] extended // 32-bit (extended) output
);

// pre-pend immediate with 16 bits of the MSB (immediate[15])
// the 16th bit of immediate (immediate[15]) is pre-extended 16 times in front of the original 16-bits of the immediate value
assign extended = 
{  
    {16{immediate[15]}}, immediate 
};

endmodule
