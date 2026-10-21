// regfile.v - If regwrite is 1 then writedata write into rd. If it is 0 then it reads the values of rs and rt and extracts them

module regFile(
    input wire          clk,
                        rst,
                        regwrite,
    input wire [4:0]    rs, // 5-bit register source
                        rt, // 5-bit register target
                        rd, // 5-bit register destination
    input wire[31:0]    writedata, // 32-bits of data to be stored
    output reg [31:0]   A_readdat1, //32-bits of register rs data
                        B_readdat2 // 32-bits of register rt data
);

// Create an internal register called REG that is 32 bit wide regs with 32 addr
reg [31:0] REG [31:0]; // variable type "reg" that is 32-bits and named REG, then we create an array of 32-bit registers

// Initialize REG[0] - REG[9] contents
initial begin
    //$readmemh({/regData.mem"}, REG);
    REG[0] = 'h002300AA;
    REG[1] = 'h10654321;
    REG[2] = 'h00100022;
    REG[3] = 'h8C123456;
    REG[4] = 'h8F123456;
    REG[5] = 'hAD654321;
    REG[6] = 'h60000066;
    REG[7] = 'h13012345;
    REG[8] = 'hAC654321;
    REG[9] = 'h12012345;
end

// Need to use non-blocking assignments (<=) since this is in a clocked always block. This is sequential logic.
always @(posedge clk) begin
    if (rst) begin
        // Set A_readdat1 and B_readdat2 to 32 bits of 0's
        A_readdat1 <= 32'b0;
        B_readdat2 <= 32'b0;
    end
    else begin
        if (regwrite) begin
            //overwrite the value location rd within REG with writedata
            REG[rd] <= writedata;
        end
        else begin
            // Set A_readdat1 to the value at location rs within REG
            A_readdat1 <= REG[rs];
            // Set B_readdat2 to the value at location rt within REG
            B_readdat2 <= REG[rt];
        end

    end
end

endmodule


