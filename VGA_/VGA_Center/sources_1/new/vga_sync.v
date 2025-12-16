`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.11.2025 11:43:21
// Design Name: 
// Module Name: vga_sync
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


// ============================================================================
// VGA SYNC MODULE
// ============================================================================
module vga_sync(
     input wire clk,
     input wire reset,
     output wire hsync,
     output wire vsync,
     output wire videoon,
     output wire [9:0] x,
     output wire [9:0] y
);

    // VGA 640x480 @ 60Hz timing
    localparam hdisplay   = 640;
    localparam hlborder   = 48;
    localparam hrborder   = 16;
    localparam hretrace   = 96;
    localparam hmax       = hdisplay + hlborder + hrborder + hretrace - 1;
    localparam starthretrace = hdisplay + hrborder;
    localparam endhretrace   = starthretrace + hretrace - 1;

    localparam vdisplay   = 480;
    localparam vtborder   = 10;
    localparam vbborder   = 33;
    localparam vretrace   = 2;
    localparam vmax       = vdisplay + vtborder + vbborder + vretrace - 1;
    localparam startvretrace = vdisplay + vbborder;
    localparam endvretrace   = startvretrace + vretrace - 1;

    reg [9:0] hcountreg, vcountreg;
    reg hsyncreg, vsyncreg;

    wire hsyncnext, vsyncnext;
    reg [9:0] hcountnext, vcountnext;

    // Counters
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            hcountreg <= 0;
            vcountreg <= 0;
            hsyncreg <= 0;
            vsyncreg <= 0;
        end else begin
            hcountreg <= hcountnext;
            vcountreg <= vcountnext;
            hsyncreg <= hsyncnext;
            vsyncreg <= vsyncnext;
        end
    end

    always @(*) begin
        hcountnext = (hcountreg == hmax) ? 0 : hcountreg + 1;
        vcountnext = (hcountreg == hmax) ?
                        ((vcountreg == vmax) ? 0 : vcountreg + 1) :
                        vcountreg;
    end

    // Active-low sync pulses
    assign hsyncnext = (hcountreg >= starthretrace) && (hcountreg <= endhretrace);
    assign vsyncnext = (vcountreg >= startvretrace) && (vcountreg <= endvretrace);

    // Visible area
    assign videoon = (hcountreg < hdisplay) && (vcountreg < vdisplay);

    // Output sync (inverted)
    assign hsync = ~hsyncreg;
    assign vsync = ~vsyncreg;

    // Coordinates
    assign x = hcountreg;
    assign y = vcountreg;

endmodule
