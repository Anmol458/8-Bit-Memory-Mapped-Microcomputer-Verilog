`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.04.2026 23:20:53
// Design Name: 
// Module Name: COMPUTER_SYSTEM_DESIGN_TB
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


module COMPUTER_SYSTEM_DESIGN_TB(

    );

// ================= SIGNALS =================
reg clock;
reg reset;

// input ports
reg [7:0] port_in_00, port_in_01, port_in_02, port_in_03;
reg [7:0] port_in_04, port_in_05, port_in_06, port_in_07;
reg [7:0] port_in_08, port_in_09, port_in_10, port_in_11;
reg [7:0] port_in_12, port_in_13, port_in_14, port_in_15;

// output ports
wire [7:0] port_out_00, port_out_01, port_out_02, port_out_03;
wire [7:0] port_out_04, port_out_05, port_out_06, port_out_07;
wire [7:0] port_out_08, port_out_09, port_out_10, port_out_11;
wire [7:0] port_out_12, port_out_13, port_out_14, port_out_15;

// ================= DUT =================
computer_system_top DUT (
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
    .port_out_14(port_out_14), .port_out_15(port_out_15)
);

// ================= CLOCK =================
initial begin
    clock = 0;
    forever #5 clock = ~clock;   // 10ns period
end

// ================= TEST SEQUENCE =================
initial begin
    // Initialize inputs
    port_in_00 = 8'h00; port_in_01 = 8'h00;
    port_in_02 = 8'h00; port_in_03 = 8'h00;
    port_in_04 = 8'h00; port_in_05 = 8'h00;
    port_in_06 = 8'h00; port_in_07 = 8'h00;
    port_in_08 = 8'h00; port_in_09 = 8'h00;
    port_in_10 = 8'h00; port_in_11 = 8'h00;
    port_in_12 = 8'h00; port_in_13 = 8'h00;
    port_in_14 = 8'h00; port_in_15 = 8'h00;

    // Apply reset
    reset = 0;
    #20;
    reset = 1;

    // Run simulation
    #500;

    // Finish simulation
    //$stop;
end

// ================= MONITOR =================
initial begin
    $monitor("Time=%0t | OUT00=%h OUT01=%h OUT02=%h OUT03=%h",
              $time, port_out_00, port_out_01, port_out_02, port_out_03);
end

endmodule
