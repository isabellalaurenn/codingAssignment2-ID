//decode.v

 

`include "../src/control.v"
`include "../src/idExLatch.v"
`include "../src/regfile.v"
`include "../src/signExt.v"

module decode(
    input wire          clk,
                        rst,
                        wb_reg_write,
    input wire [4:0]    wb_write_reg_location,
    input wire  [31:0]  mem_wb_write_data,
                        if_id_instr,
                        if_id_npc,
    output wire [1:0]    id_ex_wb,
    output wire [2:0]    id_ex_mem,
    output wire [3:0]    id_ex_execute,
    output wire [31:0]   id_ex_npc,
                        id_ex_readdat1,
                        id_ex_readdat2,
                        id_ex_sign_ext,
    output wire [4:0]    id_ex_instr_bits_20_16,
                        id_ex_instr_bits_15_11
);

    //internal
    wire [31:0] sign_ext_internal,
                readdat1_internal,
                readdat2_internal;
    wire [1:0] wb_internal;
    wire [2:0] mem_internal;
    wire [3:0] ex_internal;


    signExtend sE0(
        //COMPLETE PARAMETERS
        .immediate(if_id_instr[15:0]),
        .extended(sign_ext_internal)
    );

    regfile rf0(
        //COMPLETE PARAMETERS
        .clk(),
        .rst(),
        .regwrite(),
        .rs(),
        .rt(),
        .rd(),
        .writedata(),
        .A_readdat1(),
        .B_readdat2()
    );

    control c0(
         //COMPLETE PARAMETERS
        .clk(),
        .rst(),
        .opcode(),
        .wb(),
        .mem(),
        .ex()
    ); 

    idExLatch iEL0(
         //COMPLETE PARAMETERS
        .clk(),                                  //inputs
        .rst(),
        .ctl_wb(),
        .ctl_mem(),
        .ctl_ex(),
        .npc(),
        .readdat1(),
        .readdat2(),
        .sign_ext(),
        .instr_bits_20_16(),
        .instr_bits_15_11(),
                                                    //outputs
        .wb_out(),
        .mem_out(),
        .ctl_out(),
        .npc_out(),
        .readdat1_out(),
        .readdat2_out(),
        .sign_ext_out(),
        .instr_bits_20_16_out(),
        .instr_bits_15_11_out()
    );

endmodule
