`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.11.2025 10:17:33
// Design Name: 
// Module Name: memory_data
// Project Name: 

//////////////////////////////////////////////////////////////////////////////////

module memory_data( input wire clk, 
    input wire reset, 
    output hsync, 
    output vsync, 
    output wire [11:0] rgb );
    wire [11:0] rgb_middle;
    wire videoon;
    wire [9:0] x, y; // VGA pixel coordinates
    wire [15:0] addr; // Memory address
    wire in_image_area; // High when x,y is inside image
    // 25 MHz clock generation from input clock
    reg [1:0] div_cnt = 0;
    reg clk_25mhz = 0;
always @(posedge clk or posedge reset) begin
    if (reset) begin
         div_cnt <= 0;
         clk_25mhz <= 0;
    end 
    else begin
        if (div_cnt == 1) begin
            clk_25mhz <= ~clk_25mhz;
            div_cnt <= 0;
        end 
        else begin
            div_cnt <= div_cnt + 1;
        end
    end
end

// VGA sync unit - generates video timing signals and coordinates
vga_sync syncunit (
 .clk(clk_25mhz),
 .reset(reset),
 .hsync(hsync),
 .vsync(vsync),
 .videoon(videoon),
 .x(x),
 .y(y)
);

    // Enable signal: only when pixel is inside the 300x200 image
    assign in_image_area = (x < 300) && (y < 200);
    // Calculate linear memory address from 2D (x,y)
    assign addr = in_image_area ? (y * 300 + x) : 16'b0;
    // Memory block - fetch pixel data from memory
block_memory_wrapper m1 (
 .clka_0(clk_25mhz),
 .addra_0(addr),
 .douta_0(rgb_middle),
 .ena_0(videoon && in_image_area)
);

// RGB output only when video and pixel are valid
assign rgb = (videoon && in_image_area) ? rgb_middle : 12'b0000_0000_0000;

endmodule

