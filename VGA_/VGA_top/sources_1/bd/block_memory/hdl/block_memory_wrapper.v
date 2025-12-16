//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.1 (win64) Build 2188600 Wed Apr  4 18:40:38 MDT 2018
//Date        : Wed Nov 26 10:34:32 2025
//Host        : LAPTOP-7SDAUN6R running 64-bit major release  (build 9200)
//Command     : generate_target block_memory_wrapper.bd
//Design      : block_memory_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module block_memory_wrapper
   (addra_0,
    clka_0,
    douta_0,
    ena_0);
  input [15:0]addra_0;
  input clka_0;
  output [11:0]douta_0;
  input ena_0;

  wire [15:0]addra_0;
  wire clka_0;
  wire [11:0]douta_0;
  wire ena_0;

  block_memory block_memory_i
       (.addra_0(addra_0),
        .clka_0(clka_0),
        .douta_0(douta_0),
        .ena_0(ena_0));
endmodule
