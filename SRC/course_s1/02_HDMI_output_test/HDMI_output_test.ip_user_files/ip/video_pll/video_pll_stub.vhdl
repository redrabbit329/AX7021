-- Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2015.4 (win64) Build 1412921 Wed Nov 18 09:43:45 MST 2015
-- Date        : Fri Sep 22 13:14:59 2017
-- Host        : Mei-PC running 64-bit Service Pack 1  (build 7601)
-- Command     : write_vhdl -force -mode synth_stub
--               D:/AX7021/vivado_project/02_HDMI_output_test/HDMI_output_test.runs/video_pll_synth_1/video_pll_stub.vhdl
-- Design      : video_pll
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg484-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity video_pll is
  Port ( 
    clk_in1 : in STD_LOGIC;
    clk_out1 : out STD_LOGIC;
    clk_out2 : out STD_LOGIC;
    locked : out STD_LOGIC
  );

end video_pll;

architecture stub of video_pll is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_in1,clk_out1,clk_out2,locked";
begin
end;
