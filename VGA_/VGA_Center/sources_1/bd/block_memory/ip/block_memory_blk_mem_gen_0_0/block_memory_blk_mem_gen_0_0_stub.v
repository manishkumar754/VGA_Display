// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.1 (win64) Build 2188600 Wed Apr  4 18:40:38 MDT 2018
// Date        : Wed Nov 26 11:58:08 2025
// Host        : LAPTOP-7SDAUN6R running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/manis/Desktop/RISC-V/VGA/vga_center_top/vga_center_top.srcs/sources_1/bd/block_memory/ip/block_memory_blk_mem_gen_0_0/block_memory_blk_mem_gen_0_0_stub.v
// Design      : block_memory_blk_mem_gen_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_1,Vivado 2018.1" *)
module block_memory_blk_mem_gen_0_0(clka, ena, addra, douta)
/* synthesis syn_black_box black_box_pad_pin="clka,ena,addra[15:0],douta[11:0]" */;
  input clka;
  input ena;
  input [15:0]addra;
  output [11:0]douta;
endmodule
