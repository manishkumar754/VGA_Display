`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.11.2025 11:42:09
// Design Name: 
// Module Name: memory_data
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

module memory_data( 
    input wire clk, 
    input wire reset, 
    output hsync, 
    output vsync, 
    output wire [11:0] rgb 
);

    wire [11:0] rgb_middle;
    wire videoon;
    wire [9:0] x, y; // VGA pixel coordinates
    wire [15:0] addr; // Memory address
    wire in_image_area; // High when x,y inside image

    // Image size
    localparam IMG_W = 300;
    localparam IMG_H = 200;

    // VGA size
    localparam VGA_W = 640;
    localparam VGA_H = 480;

    // Center offsets
    localparam X_OFFSET = (VGA_W - IMG_W) / 2; // 170
    localparam Y_OFFSET = (VGA_H - IMG_H) / 2; // 140

    // 25 MHz clock generation from input clock
    reg [1:0] div_cnt = 0;
    reg clk_25mhz = 0;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            div_cnt <= 0;
            clk_25mhz <= 0;
        end else begin
            if (div_cnt == 1) begin
                clk_25mhz <= ~clk_25mhz;
                div_cnt <= 0;
            end else begin
                div_cnt <= div_cnt + 1;
            end
        end
    end

    // VGA sync module
    vga_sync syncunit (
        .clk(clk_25mhz),
        .reset(reset),
        .hsync(hsync),
        .vsync(vsync),
        .videoon(videoon),
        .x(x),
        .y(y)
    );

    // Image area detection (centered)
    assign in_image_area =
        (x >= X_OFFSET) && (x < X_OFFSET + IMG_W) &&
        (y >= Y_OFFSET) && (y < Y_OFFSET + IMG_H);

    // Local (image-relative) coordinates
    wire [9:0] local_x = x - X_OFFSET;
    wire [9:0] local_y = y - Y_OFFSET;

    // Memory address mapping
    assign addr = in_image_area ? (local_y * IMG_W + local_x) : 16'd0;

    // Block memory fetch
    block_memory_wrapper m1 (
        .clka_0(clk_25mhz),
        .addra_0(addr),
        .douta_0(rgb_middle),
        .ena_0(videoon && in_image_area)
    );

    // Black outside image area
    assign rgb = (videoon && in_image_area) ? rgb_middle : 12'h000;

endmodule


