//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.1 (win64) Build 2188600 Wed Apr  4 18:40:38 MDT 2018
//Date        : Wed Nov 26 10:34:32 2025
//Host        : LAPTOP-7SDAUN6R running 64-bit major release  (build 9200)
//Command     : generate_target block_memory.bd
//Design      : block_memory
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "block_memory,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=block_memory,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=1,numReposBlks=1,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "block_memory.hwdef" *) 
module block_memory
   (addra_0,
    clka_0,
    douta_0,
    ena_0);
  input [15:0]addra_0;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.CLKA_0 CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.CLKA_0, CLK_DOMAIN block_memory_clka_0, FREQ_HZ 100000000, PHASE 0.000" *) input clka_0;
  output [11:0]douta_0;
  input ena_0;

  wire [15:0]addra_0_1;
  wire [11:0]blk_mem_gen_0_douta;
  wire clka_0_1;
  wire ena_0_1;

  assign addra_0_1 = addra_0[15:0];
  assign clka_0_1 = clka_0;
  assign douta_0[11:0] = blk_mem_gen_0_douta;
  assign ena_0_1 = ena_0;
  block_memory_blk_mem_gen_0_0 blk_mem_gen_0
       (.addra(addra_0_1),
        .clka(clka_0_1),
        .douta(blk_mem_gen_0_douta),
        .ena(ena_0_1));
endmodule
