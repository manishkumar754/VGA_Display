`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.11.2025 10:18:57
// Design Name: 
// Module Name: vga_sync

//////////////////////////////////////////////////////////////////////////////////

module vga_sync(
     input wire clk,
     input wire reset,
     output wire hsync,
     output wire vsync,
     output wire videoon,
     output wire [9:0] x,
     output wire [9:0] y
    );
    
    // VGA 640x480 @ 60Hz Timing Parameters
     localparam hdisplay = 640;
     localparam hlborder = 48;
     localparam hrborder = 16;
     localparam hretrace = 96;
     localparam hmax = hdisplay + hlborder + hrborder + hretrace - 1;
     localparam starthretrace = hdisplay + hrborder;
     localparam endhretrace = starthretrace + hretrace - 1;
     
     localparam vdisplay = 480;
     localparam vtborder = 10;
     localparam vbborder = 33;
     localparam vretrace = 2;
     localparam vmax = vdisplay + vtborder + vbborder + vretrace - 1;
     localparam startvretrace = vdisplay + vbborder;
     localparam endvretrace = startvretrace + vretrace - 1;
     
     // Registers for counters and sync signals
     reg [9:0] hcountreg, vcountreg;
     reg vsyncreg, hsyncreg;
     
     // Next state logic wires
     wire hsyncnext, vsyncnext;
     reg [9:0] hcountnext, vcountnext;
     
     // Sequential logic: horizontal/vertical counters and sync polarity
     
     always @(posedge clk or posedge reset) begin
        if (reset) begin
            hcountreg <= 0;
            vcountreg <= 0;
            hsyncreg <= 0;
            vsyncreg <= 0;
         end 
         else begin
            hcountreg <= hcountnext;
            vcountreg <= vcountnext;
            hsyncreg <= hsyncnext;
            vsyncreg <= vsyncnext;
          end
      end
      
     // Combinational logic for next counter values
     always @(*) begin
         hcountnext = (hcountreg == hmax) ? 0 : hcountreg + 1;
         vcountnext = (hcountreg == hmax) ? 
((vcountreg == vmax) ? 0 : vcountreg + 1) : 
vcountreg;
     end

    // Horizontal and vertical sync signal generation (active low)
    assign hsyncnext = (hcountreg >= starthretrace) && (hcountreg <= endhretrace);
    assign vsyncnext = (vcountreg >= startvretrace) && (vcountreg <= endvretrace);
    
     // Video-on region: display area only (640x480)
     assign videoon = (hcountreg < hdisplay) && (vcountreg < vdisplay);
     
     // Output sync signals (inverted due to active-low VGA)
     assign hsync = ~hsyncreg;
     assign vsync = ~vsyncreg;
     
     // Current pixel coordinates
     assign x = hcountreg;
     assign y = vcountreg;

endmodule
