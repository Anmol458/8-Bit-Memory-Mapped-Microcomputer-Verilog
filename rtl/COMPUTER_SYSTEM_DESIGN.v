`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dev
// 
// Create Date: 18.04.2026 22:32:00
// Design Name: 
// Module Name: COMPUTER_SYSTEM_DESIGN
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module program_memory(address,clk,data_out);
input [7:0]address;
input clk;
output reg [7:0]data_out;

parameter LDA_IMM = 8'h86; 
parameter LDA_DIR = 8'h87; 
parameter LDB_IMM = 8'h88; 
parameter LDB_DIR = 8'h89; 
parameter STA_DIR = 8'h96; 
parameter STB_DIR = 8'h97; 
parameter ADD_AB = 8'h43; 
parameter SUB_AB = 8'h44; 
parameter OR_AB = 8'h45; 
parameter AND_AB = 8'h46; 
parameter XOR_AB = 8'h81; 
parameter NOT_A = 8'h82; 
parameter LEFT_A = 8'h83; 
parameter RIGHT_A = 8'h84; 
//parameter INCA = 8'h46; 
//parameter INCB = 8'h47; 
parameter BRA =8'h85;
//parameter BMI =8'h21; 
//parameter BPL =8'h22; 
parameter BEQ = 8'h90;
//parameter BNE =8'h24; 
//parameter BVS =8'h25; 
//parameter BVC =8'h26; 
//parameter BCS =8'h27; 
//parameter BCC =8'h28; 

//iNTIALISING ROM MEMORY TO EACH INSTRUCTIONS

reg[7:0] ROM[0:127];
reg enb;
initial
    begin
       /* ROM[0] = LDA_IMM;
        ROM[1] = 8'hAA;
        ROM[2] = STA_DIR;
        ROM[3] = 8'hE0;
        ROM[4] = BRA;
        ROM[5] = 8'h00;
        ROM[6] = LDA_IMM;
        ROM[7] = 8'h00;
        ROM[8] = LDB_IMM;
        ROM[9] = 8'h00;
        ROM[10] = ADD_AB;
        ROM[11] = SUB_AB;
        ROM[12] = AND_AB;
        ROM[13] = NOT_A;
        ROM[14] = OR_AB;
        ROM[15] = XOR_AB;
        ROM[16] = BEQ;
        ROM[17] = 8'h00;
        ROM[18] = LEFT_A;
        ROM[19] = RIGHT_A;*/
        //initial begin
    // ===== LOAD VALUES =====
    ROM[0]  = LDA_IMM;  // A = 0x05
    ROM[1]  = 8'h05;

    ROM[2]  = LDB_IMM;  // B = 0x03
    ROM[3]  = 8'h03;

    // ===== ADD =====
    ROM[4]  = ADD_AB;   // A = A + B = 08
    ROM[5]  = STA_DIR;
    ROM[6]  = 8'hE0;    // OUT0 = 08

    // ===== SUB =====
    ROM[7]  = SUB_AB;   // A = A - B = 05
    ROM[8]  = STA_DIR;
    ROM[9]  = 8'hE1;    // OUT1 = 05

    // ===== AND =====
    ROM[10] = AND_AB;   // A = A & B
    ROM[11] = STA_DIR;
    ROM[12] = 8'hE2;

    // ===== OR =====
    ROM[13] = OR_AB;
    ROM[14] = STA_DIR;
    ROM[15] = 8'hE3;

    // ===== XOR =====
    ROM[16] = XOR_AB;
    ROM[17] = STA_DIR;
    ROM[18] = 8'hE4;

    // ===== NOT =====
    ROM[19] = NOT_A;
    ROM[20] = STA_DIR;
    ROM[21] = 8'hE5;

    // ===== LEFT SHIFT =====
    ROM[22] = LEFT_A;
    ROM[23] = STA_DIR;
    ROM[24] = 8'hE6;

    // ===== RIGHT SHIFT =====
    ROM[25] = RIGHT_A;
    ROM[26] = STA_DIR;
    ROM[27] = 8'hE7;

    // ===== STORE B =====
    ROM[28] = STB_DIR;
    ROM[29] = 8'hE8;

    // ===== LOAD DIRECT TEST =====
    ROM[30] = LDA_DIR;
    ROM[31] = 8'hE0;   // load from OUT0 (08)
    ROM[32] = STA_DIR;
    ROM[33] = 8'hE9;

    // ===== BRANCH TEST =====
    ROM[34] = BEQ;     // if zero → jump
    ROM[35] = 8'h38;   // jump target

    // ===== FORCE ZERO =====
    ROM[36] = SUB_AB;  // A = A - B (may become zero)
    ROM[37] = BEQ;
    ROM[38] = 8'h40;   // jump

    // ===== NO JUMP PATH =====
    ROM[39] = LDA_IMM;
    ROM[40] = 8'hFF;
    ROM[41] = STA_DIR;
    ROM[42] = 8'hEA;

    // ===== JUMP TARGET =====
    ROM[43] = LDA_IMM;
    ROM[44] = 8'h11;
    ROM[45] = STA_DIR;
    ROM[46] = 8'hEB;

    // ===== INFINITE LOOP =====
    ROM[47] = BRA;
    ROM[48] = 8'h2F;   // loop back to itself
//end
    
    end
always@(posedge clk)
    begin
        if(address>=0 && address<=127)
            //enb=1'b1;
        //else
            //enb=1'b0;
    //end
    
//always@(posedge clk)
    //begin
        //if(enb)
            data_out=ROM[address];
    end
    
    
endmodule

//DATA MEMORY MODULE
module data_memory(address,data_in,clk,write,data_out);
input [7:0]address,data_in;
input clk,write;
output reg [7:0]data_out;

reg [7:0] RAM [128:223];
reg enb;

always@(address)
    begin
        if(address>=128 && address<=223)
            //enb<=1'b1;
        //else
            //enb<=1'b0;
    //end
    
//always@(posedge clk)
    //begin
        //if(enb && write)
            RAM[address]<=data_in;
        else if(!write) //&& enb)
            data_out<=RAM[address];
            
    end
  
endmodule

//Implementation of Output Ports 
module output_port(address,write,clock,reset,port_out_00,port_out_01,port_out_02,port_out_03,port_out_04,port_out_05,port_out_06,port_out_07,port_out_08,port_out_09,port_out_10,port_out_11,port_out_12,port_out_13,port_out_14,port_out_15,data_in);
input reset,clock ,write;
input [7:0]data_in,address;
output reg [7:0]port_out_00,port_out_01,port_out_02,port_out_03,port_out_04,port_out_05,port_out_06,port_out_07,port_out_08,port_out_09,port_out_10,port_out_11,port_out_12,port_out_13,port_out_14,port_out_15;

//-- port_out_00 (address E0)
always @ (posedge clock or negedge reset)
    begin
        if (!reset)
            port_out_00 <= 8'h00;
        else 
            if ((address == 8'hE0) && (write))
                port_out_00 <= data_in;
    end
    
always @ (posedge clock or negedge reset)
    begin
        if (!reset)
            port_out_01 <= 8'h00;
        else 
            if ((address == 8'hE1) && (write))
                port_out_01 <= data_in;
    end
always @ (posedge clock or negedge reset)
    begin
        if (!reset)
            port_out_02 <= 8'h00;
        else 
            if ((address == 8'hE2) && (write))
                port_out_02 <= data_in;
    end
always @ (posedge clock or negedge reset)
    begin
        if (!reset)
            port_out_03 <= 8'h00;
        else 
            if ((address == 8'hE3) && (write))
                port_out_03 <= data_in;
    end
    
always @ (posedge clock or negedge reset)
    begin
        if (!reset)
            port_out_04 <= 8'h00;
        else 
            if ((address == 8'hE4) && (write))
                port_out_04 <= data_in;
    end
    
always @ (posedge clock or negedge reset)
    begin
        if (!reset)
            port_out_05 <= 8'h00;
        else 
            if ((address == 8'hE5) && (write))
                port_out_05 <= data_in;
    end

always @ (posedge clock or negedge reset)
    begin
        if (!reset)
            port_out_06 <= 8'h00;
        else 
            if ((address == 8'hE6) && (write))
                port_out_06 <= data_in;
    end
    
always @ (posedge clock or negedge reset)
    begin
        if (!reset)
            port_out_07 <= 8'h00;
        else 
            if ((address == 8'hE7) && (write))
                port_out_07 <= data_in;
    end
    
always @ (posedge clock or negedge reset)
    begin
        if (!reset)
            port_out_08 <= 8'h00;
        else 
            if ((address == 8'hE8) && (write))
                port_out_08 <= data_in;
    end
    
always @ (posedge clock or negedge reset)
    begin
        if (!reset)
            port_out_09 <= 8'h00;
        else 
            if ((address == 8'hE9) && (write))
                port_out_09 <= data_in;
    end
    
always @ (posedge clock or negedge reset)
    begin
        if (!reset)
            port_out_10 <= 8'h00;
        else 
            if ((address == 8'hEA) && (write))
                port_out_10 <= data_in;
    end
    
always @ (posedge clock or negedge reset)
    begin
        if (!reset)
            port_out_11 <= 8'h00;
        else 
            if ((address == 8'hEB) && (write))
                port_out_11 <= data_in;
    end
    
always @ (posedge clock or negedge reset)
    begin
        if (!reset)
            port_out_12 <= 8'h00;
        else 
            if ((address == 8'hEC) && (write))
                port_out_12 <= data_in;
    end
    
    
always @ (posedge clock or negedge reset)
    begin
        if (!reset)
            port_out_13 <= 8'h00;
        else 
            if ((address == 8'hED) && (write))
                port_out_13 <= data_in;
    end
    
always @ (posedge clock or negedge reset)
    begin
        if (!reset)
            port_out_14 <= 8'h00;
        else 
            if ((address == 8'hEE) && (write))
                port_out_14 <= data_in;
    end
    
always @ (posedge clock or negedge reset)
    begin
        if (!reset)
            port_out_15 <= 8'h00;
        else 
            if ((address == 8'hEF) && (write))
                port_out_15 <= data_in;
    end
endmodule




//Input port implementation
module input_port(address,read,clock,reset, port_in_00,port_in_01,port_in_02,port_in_03,port_in_04,port_in_05,port_in_06,port_in_07,port_in_08,port_in_09,port_in_10,port_in_11,port_in_12, port_in_13,port_in_14,port_in_15,data_out);
    input [7:0] address;
    input read;
    input clock;
    input reset;

    input [7:0] port_in_00;
    input [7:0] port_in_01;
    input [7:0] port_in_02;
    input [7:0] port_in_03;
    input [7:0] port_in_04;
    input [7:0] port_in_05;
    input [7:0] port_in_06;
    input [7:0] port_in_07;
    input [7:0] port_in_08;
    input [7:0] port_in_09;
    input [7:0] port_in_10;
    input [7:0] port_in_11;
    input [7:0] port_in_12;
    input [7:0] port_in_13;
    input [7:0] port_in_14;
    input [7:0] port_in_15;

    output reg [7:0] data_out;

always @(posedge clock or negedge reset)
begin
    if (!reset)
        data_out <= 8'h00;
    else if (read)
    begin
        case(address)
            8'hF0: data_out <= port_in_00;
            8'hF1: data_out <= port_in_01;
            8'hF2: data_out <= port_in_02;
            8'hF3: data_out <= port_in_03;
            8'hF4: data_out <= port_in_04;
            8'hF5: data_out <= port_in_05;
            8'hF6: data_out <= port_in_06;
            8'hF7: data_out <= port_in_07;
            8'hF8: data_out <= port_in_08;
            8'hF9: data_out <= port_in_09;
            8'hFA: data_out <= port_in_10;
            8'hFB: data_out <= port_in_11;
            8'hFC: data_out <= port_in_12;
            8'hFD: data_out <= port_in_13;
            8'hFE: data_out <= port_in_14;
            8'hFF: data_out <= port_in_15;
            default: data_out <= 8'h00; // safe default
        endcase
    end
end

endmodule

module system_bus(
    input [7:0] address,

    // Inputs from different modules
    input [7:0] rom_data_out,
    input [7:0] ram_data_out,
    input [7:0] port_data_out,

    output reg [7:0] data_out
);

always @(*)   // combinational MUX
begin
    // Program Memory (0 - 127)
    if (address <= 8'd127)
        data_out = rom_data_out;

    // Data Memory (128 - 223)
    else if (address >= 8'd128 && address <= 8'd223)
        data_out = ram_data_out;

    // Input Ports (E0 - FF)
    else if (address >= 8'hF0 && address <= 8'hFF)
        data_out = port_data_out;

    // Default (unused region)
    else
        data_out = 8'h00;
end

endmodule

module main_memory (
    input  [7:0] address,
    input  [7:0] data_in,
    input        write,
    input        read,
    input        clock,
    input        reset,

    // 16 input ports (8-bit each)
    input  [7:0] port_in_00, port_in_01, port_in_02, port_in_03,
    input  [7:0] port_in_04, port_in_05, port_in_06, port_in_07,
    input  [7:0] port_in_08, port_in_09, port_in_10, port_in_11,
    input  [7:0] port_in_12, port_in_13, port_in_14, port_in_15,

    // 16 output ports (8-bit each)
    output [7:0] port_out_00, port_out_01, port_out_02, port_out_03,
    output [7:0] port_out_04, port_out_05, port_out_06, port_out_07,
    output [7:0] port_out_08, port_out_09, port_out_10, port_out_11,
    output [7:0] port_out_12, port_out_13, port_out_14, port_out_15,

    output [7:0] data_out
);

    // Internal wires
    wire [7:0] rom_data_out;
    wire [7:0] ram_data_out;
    wire [7:0] port_data_out;

    // =======================
    // ROM (Program Memory)
    // =======================
    program_memory ROM (
        .address(address),
        .clk(clock),
        .data_out(rom_data_out)
    );

    // =======================
    // RAM (Data Memory)
    // =======================
    data_memory RAM (
        .address(address),
        .data_in(data_in),
        .clk(clock),
        .write(write),
        .data_out(ram_data_out)
    );

    // =======================
    // OUTPUT PORTS
    // =======================
    output_port OUT_PORTS (
        .address(address),
        .data_in(data_in),
        .write(write),
        .clock(clock),
        .reset(reset),

        .port_out_00(port_out_00),
        .port_out_01(port_out_01),
        .port_out_02(port_out_02),
        .port_out_03(port_out_03),
        .port_out_04(port_out_04),
        .port_out_05(port_out_05),
        .port_out_06(port_out_06),
        .port_out_07(port_out_07),
        .port_out_08(port_out_08),
        .port_out_09(port_out_09),
        .port_out_10(port_out_10),
        .port_out_11(port_out_11),
        .port_out_12(port_out_12),
        .port_out_13(port_out_13),
        .port_out_14(port_out_14),
        .port_out_15(port_out_15)
    );

    // =======================
    // INPUT PORTS
    // =======================
    input_port IN_PORTS (
        .address(address),
        .read(read),
        .clock(clock),
        .reset(reset),

        .port_in_00(port_in_00),
        .port_in_01(port_in_01),
        .port_in_02(port_in_02),
        .port_in_03(port_in_03),
        .port_in_04(port_in_04),
        .port_in_05(port_in_05),
        .port_in_06(port_in_06),
        .port_in_07(port_in_07),
        .port_in_08(port_in_08),
        .port_in_09(port_in_09),
        .port_in_10(port_in_10),
        .port_in_11(port_in_11),
        .port_in_12(port_in_12),
        .port_in_13(port_in_13),
        .port_in_14(port_in_14),
        .port_in_15(port_in_15),

        .data_out(port_data_out)
    );

    // =======================
    // SYSTEM BUS (MUX)
    // =======================
    system_bus BUS (
        .address(address),
        .rom_data_out(rom_data_out),
        .ram_data_out(ram_data_out),
        .port_data_out(port_data_out),
        .data_out(data_out)
    );

endmodule


module data_path(IR_Load,MAR_Load,PC_Load,PC_Inc,A_Load, B_Load ,ALU_Sel,CCR_Load,Bus2_Sel,Bus1_Sel,from_memory,to_memory,address,IR,CCR_Result,clock,reset);
input IR_Load,MAR_Load,PC_Load,PC_Inc,A_Load, B_Load ,CCR_Load,clock,reset;
input wire [1:0] Bus2_Sel,Bus1_Sel;
input [7:0]from_memory;
input [2:0]ALU_Sel;
output reg [7:0]to_memory,address,IR;
output reg [3:0]CCR_Result;
reg [7:0]PC,A,B,MAR,Bus1,Bus2;
//reg [3:0]CCR;
reg [7:0]ALU_Result;
reg [3:0]NZVC;
always @ (Bus1_Sel, PC, A, B)
    begin: MUX_BUS1
        case (Bus1_Sel)
            2'b00 : Bus1 =PC;
            2'b01 : Bus1 =A;
            2'b10 : Bus1 =B;
            default :Bus1 =8'h00;
        endcase
        end
always @ (Bus2_Sel, ALU_Result, Bus1, from_memory)
    begin: MUX_BUS2
        case (Bus2_Sel)
            2'b00 : Bus2 =ALU_Result;
            2'b01 : Bus2 = Bus1;
            2'b10 : Bus2 = from_memory;
            default :Bus2 =8'h00;
        endcase
        end
always @ (Bus1, MAR)
    begin
        to_memory = Bus1;
        address = MAR;
    end
    
always @ (posedge clock or negedge reset)
    begin: INSTRUCTION_REGISTER
        if (!reset)
            IR <=8'h00;
        else
            if (IR_Load)
                IR <=Bus2;
    end
always @ (posedge clock or negedge reset)
    begin: MEMORY_ADDRESS_REGISTER
        if (!reset)
            MAR <=8'h00;
        else
            if (MAR_Load)
                MAR <= Bus2;
    end
always @ (posedge clock or negedge reset)
    begin: PROGRAM_COUNTER
        if (!reset)
            PC <=8'h00;
        else
            if (PC_Load)
                PC <=Bus2;
            else if (PC_Inc)
                PC <=PC+1;
    end
always @ (posedge clock or negedge reset)
    begin: A_REGISTER
        if (!reset)
            A<=8'h00;
        else
            if (A_Load)
                A<=Bus2;
    end
always @ (posedge clock or negedge reset)
    begin: B_REGISTER
        if (!reset)
            B<=8'h00;
        else
            if (B_Load)
                B<=Bus2;
    end
    
always @ (posedge clock or negedge reset)
    begin: CONDITION_CODE_REGISTER
        if (!reset)
            CCR_Result <= 4'h0;
        else
            if (CCR_Load)
                CCR_Result <= NZVC;
    end
 //alu    
always @ (A, B, ALU_Sel)
    begin
        case (ALU_Sel)
            3'b000 ://--Addition
                //-- Sum and Carry Flag
                {NZVC[0], ALU_Result} = A+ B;
            3'b001 :
                {NZVC[0], ALU_Result} = A - B;
            3'b010 :
                {NZVC[0], ALU_Result} = A & B;
            3'b011 :
                {NZVC[0], ALU_Result} = A | B;
           3'b100 :
                {NZVC[0], ALU_Result} = A ^ B;
           3'b110 :
                {NZVC[0], ALU_Result} = A << 1;
           3'b111 :
                {NZVC[0], ALU_Result} = A >> 1;
           3'b101 :
                {NZVC[0], ALU_Result} = ~A;
           default : begin
                ALU_Result =8'h00;
                NZVC =4'hX;
                end
        endcase
                
//-- Negative Flag
NZVC[3] = ALU_Result[7];
//-- Zero Flag
if (ALU_Result == 0)
NZVC[2] = 1;
else
NZVC[2] = 0;
//-- Two's Comp Overflow Flag
if (((A[7]==0) &&(B[7]==0) && (ALU_Result[7] == 1)) ||
((A[7]==1) && (B[7]==1) && (ALU_Result[7] == 0)) )
NZVC[1] =1;
else
NZVC[1] = 0;
end


endmodule





//Control Unit implementation
//Control Unit implementation
module control_unit(clock,reset,IR,CCR_Result,IR_Load,MAR_Load,PC_Load,PC_Inc,A_Load,B_Load,ALU_Sel,Bus1_Sel,Bus2_Sel,write,CCR_Load);
input clock,reset;
input [7:0] IR;
input [3:0] CCR_Result;
output reg IR_Load,MAR_Load,PC_Load,PC_Inc,A_Load,B_Load,write,CCR_Load;
output reg [1:0] Bus1_Sel,Bus2_Sel;
output reg [2:0] ALU_Sel;
reg [7:0] current_state,next_state;
parameter LDA_IMM = 8'h86; 
parameter LDA_DIR = 8'h87; 
parameter LDB_IMM = 8'h88; 
parameter LDB_DIR = 8'h89; 
parameter STA_DIR = 8'h96; 
parameter STB_DIR = 8'h97; 
parameter ADD_AB = 8'h43; 
parameter SUB_AB = 8'h44; 
parameter OR_AB = 8'h45; 
parameter AND_AB = 8'h46; 
parameter XOR_AB = 8'h81; 
parameter NOT_A = 8'h82; 
parameter LEFT_A = 8'h83; 
parameter RIGHT_A = 8'h84; 
//parameter INCA = 8'h46; 
//parameter INCB = 8'h47; 
parameter BRA =8'h85;
//parameter BMI =8'h21; 
//parameter BPL =8'h22; 
parameter BEQ = 8'h90;
//parameter BNE =8'h24; 
//parameter BVS =8'h25; 
//parameter BVC =8'h26; 
//parameter BCS =8'h27; 
//parameter BCC =8'h28; 
parameter S_FETCH_0 = 0, //--Opcodefetchstates
S_FETCH_1 = 8'h1,
S_FETCH_2 = 8'h2,
S_DECODE_3 = 8'h3, //--Opcodedecodestate
S_LDA_IMM_4 = 8'h4, //--LoadA(Immediate) states
S_LDA_IMM_5 = 8'h5,
S_LDA_IMM_6 = 8'h6,
S_LDA_DIR_4 = 8'h7, //--LoadA(Direct)states
S_LDA_DIR_5 = 8'h8,
S_LDA_DIR_6 = 8'h9,
S_LDA_DIR_7 = 8'h10,
S_LDA_DIR_8 = 8'h11,
S_STA_DIR_4 = 8'h12, //--Store A (Direct)States
S_STA_DIR_5 = 8'h13,
S_STA_DIR_6 = 8'h14,
S_STA_DIR_7 = 8'h15,
S_LDB_IMM_4 = 8'h16, //--Load B (Immediate) states
S_LDB_IMM_5 = 8'h17,
S_LDB_IMM_6 = 8'h18,
S_LDB_DIR_4 = 8'h19, //--Load B (Direct) states
S_LDB_DIR_5 = 8'h20,
S_LDB_DIR_6 = 8'h21,
S_LDB_DIR_7 = 8'h22,
S_LDB_DIR_8 = 8'h23,
S_STB_DIR_4 = 8'h24, //--Store B (Direct)States
S_STB_DIR_5 = 8'h25,
S_STB_DIR_6 = 8'h26,
S_STB_DIR_7 = 8'h27,
S_BRA_4 =8'h28, //--BranchAlwaysStates
S_BRA_5 =8'h29,
S_BRA_6 =8'h30,
S_BEQ_4 =8'h31, //--BranchifEqualStates
S_BEQ_5 =8'h32,
S_BEQ_6 =8'h33,
S_BEQ_7 =8'h34,
S_ADD_AB_4 = 8'h35, //--AdditionState
S_SUB_AB_4 = 8'h36,
S_OR_AB_4 = 8'h37, 
S_AND_AB_4 = 8'h38,
S_XOR_AB_4 = 8'h39,
S_NOT_A_4 = 8'h40,
S_LEFT_A_4 = 8'h41,
S_RIGHT_A_4 = 8'h42; 



always @ (posedge clock or negedge reset)
begin: STATE_MEMORY
if (!reset)
current_state <= S_FETCH_0;
else
current_state <= next_state;
end


always @ (current_state, IR, CCR_Result)
begin: NEXT_STATE_LOGIC
case (current_state)
S_FETCH_0 :next_state =S_FETCH_1; //--PathforFETCHinstruction
S_FETCH_1 :next_state =S_FETCH_2;
S_FETCH_2 :next_state =S_DECODE_3;
S_DECODE_3 : if (IR==LDA_IMM)next_state=S_LDA_IMM_4; //--Register A
else if (IR ==LDA_DIR)next_state = S_LDA_DIR_4;
else if (IR ==STA_DIR)next_state = S_STA_DIR_4;
else if (IR==LDB_IMM)next_state= S_LDB_IMM_4;//-- Register B
else if (IR ==LDB_DIR)next_state = S_LDB_DIR_4;
else if (IR ==STB_DIR)next_state = S_STB_DIR_4;
else if (IR ==BRA) next_state=S_BRA_4;
//-- Branch Always
else if (IR == BEQ) begin
    if (CCR_Result[2] == 1)   // Zero flag
        next_state = S_BEQ_4;
    else
        next_state = S_FETCH_0;
end
else if (IR ==ADD_AB) next_state = S_ADD_AB_4;//--ADD
else if (IR ==SUB_AB) next_state = S_SUB_AB_4; 
else if (IR ==OR_AB) next_state = S_OR_AB_4; 
else if (IR ==AND_AB) next_state = S_AND_AB_4; 
else if (IR ==NOT_A) next_state = S_NOT_A_4; 
else if (IR ==XOR_AB) next_state = S_XOR_AB_4; 
else if (IR ==LEFT_A) next_state = S_LEFT_A_4; 
else if (IR ==RIGHT_A) next_state = S_RIGHT_A_4; 
else
next_state = S_FETCH_0;
//-- others
S_LDA_IMM_4 : next_state = S_LDA_IMM_5; //-- Path for LDA_IMM instruction
S_LDA_IMM_5 : next_state = S_LDA_IMM_6;
S_LDA_IMM_6 : next_state = S_FETCH_0;

S_LDA_DIR_4 : next_state = S_LDA_DIR_5; //-- Path for LDA_DIR instruction
S_LDA_DIR_5 : next_state = S_LDA_DIR_6;
S_LDA_DIR_6 : next_state = S_LDA_DIR_7;
S_LDA_DIR_7 : next_state = S_LDA_DIR_8; //-- Path for LDA_DIR instruction
S_LDA_DIR_8 : next_state = S_FETCH_0;

S_STA_DIR_4 : next_state = S_STA_DIR_5; //-- Path for STA_DIR instruction
S_STA_DIR_5 : next_state = S_STA_DIR_6;
S_STA_DIR_6 : next_state = S_STA_DIR_7;
S_STA_DIR_7 : next_state = S_FETCH_0;

S_LDB_IMM_4 : next_state = S_LDB_IMM_5; //-- Path for LDB_IMM instruction
S_LDB_IMM_5 : next_state = S_LDB_IMM_6;
S_LDB_IMM_6 : next_state = S_FETCH_0;

S_LDB_DIR_4 : next_state = S_LDB_DIR_5; //-- Path for LDB_DIR instruction
S_LDB_DIR_5 : next_state = S_LDB_DIR_6;
S_LDB_DIR_6 : next_state = S_LDB_DIR_7;
S_LDB_DIR_7 : next_state = S_LDB_DIR_8; //-- Path for LDB_DIR instruction
S_LDB_DIR_8 : next_state = S_FETCH_0;

S_STB_DIR_4 : next_state = S_STB_DIR_5; //-- Path for STB_DIR instruction
S_STB_DIR_5 : next_state = S_STB_DIR_6;
S_STB_DIR_6 : next_state = S_STB_DIR_7;
S_STB_DIR_7 : next_state = S_FETCH_0;

S_BRA_4 : next_state = S_BRA_5; //-- Path for BRA instruction
S_BRA_5 : next_state = S_BRA_6;
S_BRA_6 : next_state = S_FETCH_0;

S_BEQ_4 : next_state = S_BEQ_5; //-- Path for BEQ instruction
S_BEQ_5 : next_state = S_BEQ_6;
S_BEQ_6 : next_state = S_FETCH_0;

S_ADD_AB_4 : next_state = S_FETCH_0;

S_SUB_AB_4 : next_state = S_FETCH_0;

S_AND_AB_4 : next_state = S_FETCH_0;

S_OR_AB_4 : next_state = S_FETCH_0;

S_XOR_AB_4 : next_state = S_FETCH_0;

S_NOT_A_4 : next_state = S_FETCH_0;

S_LEFT_A_4 : next_state = S_FETCH_0;

S_RIGHT_A_4 : next_state = S_FETCH_0;



endcase
end


always @ (current_state)
begin: OUTPUT_LOGIC

// ================= DEFAULTS (VERY IMPORTANT) =================
IR_Load  = 0;
MAR_Load = 0;
PC_Load  = 0;
PC_Inc   = 0;
A_Load   = 0;
B_Load   = 0;
CCR_Load = 0;
write    = 0;

Bus1_Sel = 2'b00;   // 00=PC, 01=A, 10=B
Bus2_Sel = 2'b00;   // 00=ALU, 01=Bus1, 10=Memory
ALU_Sel  = 3'b000;  // ADD default

case (current_state)

// ================= FETCH =================
S_FETCH_0: begin
    MAR_Load = 1;
    Bus1_Sel = 2'b00;   // PC
    Bus2_Sel = 2'b01;   // Bus1 → MAR
end

S_FETCH_1: begin
    PC_Inc = 1;
end

S_FETCH_2: begin
    IR_Load  = 1;
    Bus2_Sel = 2'b10;   // Memory → IR
end

// ================= LDA_IMM =================
S_LDA_IMM_4: begin
    MAR_Load = 1;
    Bus1_Sel = 2'b00;   // PC → MAR
    Bus2_Sel = 2'b01;
end

S_LDA_IMM_5: begin
    PC_Inc = 1;
end

S_LDA_IMM_6: begin
    A_Load   = 1;
    Bus2_Sel = 2'b10;   // Memory → A
end

// ================= LDA_DIR =================
S_LDA_DIR_4: begin
    MAR_Load = 1;
    Bus1_Sel = 2'b00;
    Bus2_Sel = 2'b01;
end

S_LDA_DIR_5: begin
    PC_Inc = 1;
end

S_LDA_DIR_6: begin
    MAR_Load = 1;
    Bus2_Sel = 2'b10;   // address from memory
end

S_LDA_DIR_7: begin
    // wait for memory
end

S_LDA_DIR_8: begin
    A_Load   = 1;
    Bus2_Sel = 2'b10;   // data → A
end

// ================= STA_DIR =================
S_STA_DIR_4: begin
    MAR_Load = 1;
    Bus1_Sel = 2'b00;
    Bus2_Sel = 2'b01;
end

S_STA_DIR_5: begin
    PC_Inc = 1;
end

S_STA_DIR_6: begin
    MAR_Load = 1;
    Bus2_Sel = 2'b10;
end

S_STA_DIR_7: begin
    write    = 1;
    Bus1_Sel = 2'b01;   // A → memory
end

// ================= LDB_IMM =================
S_LDB_IMM_4: begin
    MAR_Load = 1;
    Bus1_Sel = 2'b00;
    Bus2_Sel = 2'b01;
end

S_LDB_IMM_5: begin
    PC_Inc = 1;
end

S_LDB_IMM_6: begin
    B_Load   = 1;
    Bus2_Sel = 2'b10;
end

// ================= LDB_DIR =================
S_LDB_DIR_4: begin
    MAR_Load = 1;
    Bus1_Sel = 2'b00;
    Bus2_Sel = 2'b01;
end

S_LDB_DIR_5: begin
    PC_Inc = 1;
end

S_LDB_DIR_6: begin
    MAR_Load = 1;
    Bus2_Sel = 2'b10;
end

S_LDB_DIR_7: begin
    // wait
end

S_LDB_DIR_8: begin
    B_Load   = 1;
    Bus2_Sel = 2'b10;
end

// ================= STB_DIR =================
S_STB_DIR_4: begin
    MAR_Load = 1;
    Bus1_Sel = 2'b00;
    Bus2_Sel = 2'b01;
end

S_STB_DIR_5: begin
    PC_Inc = 1;
end

S_STB_DIR_6: begin
    MAR_Load = 1;
    Bus2_Sel = 2'b10;
end

S_STB_DIR_7: begin
    write    = 1;
    Bus1_Sel = 2'b10;   // B → memory
end

// ================= BRA =================
S_BRA_4: begin
    MAR_Load = 1;
    Bus1_Sel = 2'b00;
    Bus2_Sel = 2'b01;
end

S_BRA_5: begin
    PC_Load  = 1;
    Bus2_Sel = 2'b10;   // load new PC from memory
end

S_BRA_6: begin
    // done
end

// ================= BEQ =================
S_BEQ_4: begin
    MAR_Load = 1;
    Bus1_Sel = 2'b00;
    Bus2_Sel = 2'b01;
end

S_BEQ_5: begin
    PC_Load  = 1;
    Bus2_Sel = 2'b10;
end

S_BEQ_6: begin
    // done
end

// ================= ALU OPS =================
S_ADD_AB_4: begin
    Bus1_Sel = 2'b01;   // A
    ALU_Sel  = 3'b000;
    A_Load   = 1;
    CCR_Load = 1;
end

S_SUB_AB_4: begin
    Bus1_Sel = 2'b01;
    ALU_Sel  = 3'b001;
    A_Load   = 1;
    CCR_Load = 1;
end

S_AND_AB_4: begin
    Bus1_Sel = 2'b01;
    ALU_Sel  = 3'b010;
    A_Load   = 1;
end

S_OR_AB_4: begin
    Bus1_Sel = 2'b01;
    ALU_Sel  = 3'b011;
    A_Load   = 1;
end

S_XOR_AB_4: begin
    Bus1_Sel = 2'b01;
    ALU_Sel  = 3'b100;
    A_Load   = 1;
end

S_NOT_A_4: begin
    Bus1_Sel = 2'b01;
    ALU_Sel  = 3'b101;
    A_Load   = 1;
end

S_LEFT_A_4: begin
    Bus1_Sel = 2'b01;
    ALU_Sel  = 3'b110;
    A_Load   = 1;
end

S_RIGHT_A_4: begin
    Bus1_Sel = 2'b01;
    ALU_Sel  = 3'b111;
    A_Load   = 1;
end

// ================= DEFAULT =================
default: begin
    // safe idle
end

endcase
end
endmodule


module computer_system_top(
    input clock,
    input reset,

    // input ports (example)
    input [7:0] port_in_00, port_in_01, port_in_02, port_in_03,
    input [7:0] port_in_04, port_in_05, port_in_06, port_in_07,
    input [7:0] port_in_08, port_in_09, port_in_10, port_in_11,
    input [7:0] port_in_12, port_in_13, port_in_14, port_in_15,

    // output ports
    output [7:0] port_out_00, port_out_01, port_out_02, port_out_03,
    output [7:0] port_out_04, port_out_05, port_out_06, port_out_07,
    output [7:0] port_out_08, port_out_09, port_out_10, port_out_11,
    output [7:0] port_out_12, port_out_13, port_out_14, port_out_15
);

// ================= INTERNAL WIRES =================
wire IR_Load, MAR_Load, PC_Load, PC_Inc;
wire A_Load, B_Load, CCR_Load, write;

wire [2:0] ALU_Sel;
wire [1:0] Bus1_Sel, Bus2_Sel;

wire [7:0] IR;
wire [7:0] address;
wire [7:0] from_memory;
wire [7:0] to_memory;

wire [3:0] CCR_Result;

// ================= CONTROL UNIT =================
control_unit CU (
    .clock(clock),
    .reset(reset),
    .IR(IR),
    .CCR_Result(CCR_Result),

    .IR_Load(IR_Load),
    .MAR_Load(MAR_Load),
    .PC_Load(PC_Load),
    .PC_Inc(PC_Inc),
    .A_Load(A_Load),
    .B_Load(B_Load),
    .ALU_Sel(ALU_Sel),
    .Bus1_Sel(Bus1_Sel),
    .Bus2_Sel(Bus2_Sel),
    .write(write),
    .CCR_Load(CCR_Load)
);

// ================= DATA PATH =================
data_path DP (
    .IR_Load(IR_Load),
    .MAR_Load(MAR_Load),
    .PC_Load(PC_Load),
    .PC_Inc(PC_Inc),
    .A_Load(A_Load),
    .B_Load(B_Load),
    .ALU_Sel(ALU_Sel),
    .CCR_Load(CCR_Load),
    .Bus2_Sel(Bus2_Sel),
    .Bus1_Sel(Bus1_Sel),

    .from_memory(from_memory),
    .to_memory(to_memory),
    .address(address),
    .IR(IR),
    .CCR_Result(CCR_Result),

    .clock(clock),
    .reset(reset)
);

// ================= MAIN MEMORY =================
main_memory MEM (
    .address(address),
    .data_in(to_memory),
    .write(write),
    .read(~write),   // read when not writing
    .clock(clock),
    .reset(reset),

    .port_in_00(port_in_00), .port_in_01(port_in_01),
    .port_in_02(port_in_02), .port_in_03(port_in_03),
    .port_in_04(port_in_04), .port_in_05(port_in_05),
    .port_in_06(port_in_06), .port_in_07(port_in_07),
    .port_in_08(port_in_08), .port_in_09(port_in_09),
    .port_in_10(port_in_10), .port_in_11(port_in_11),
    .port_in_12(port_in_12), .port_in_13(port_in_13),
    .port_in_14(port_in_14), .port_in_15(port_in_15),

    .port_out_00(port_out_00), .port_out_01(port_out_01),
    .port_out_02(port_out_02), .port_out_03(port_out_03),
    .port_out_04(port_out_04), .port_out_05(port_out_05),
    .port_out_06(port_out_06), .port_out_07(port_out_07),
    .port_out_08(port_out_08), .port_out_09(port_out_09),
    .port_out_10(port_out_10), .port_out_11(port_out_11),
    .port_out_12(port_out_12), .port_out_13(port_out_13),
    .port_out_14(port_out_14), .port_out_15(port_out_15),

    .data_out(from_memory)
);

endmodule

