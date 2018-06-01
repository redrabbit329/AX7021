## This file is a general .xdc for the ALINX AX7021 board
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used signals according to the project
#Clock signal
set_property PACKAGE_PIN Y9 [get_ports sys_clk]
set_property IOSTANDARD LVCMOS33 [get_ports sys_clk]
create_clock -period 20.000 -waveform {0.000 10.000} [get_ports sys_clk]

##LCD Interface J15
set_property PACKAGE_PIN T21 [get_ports {lcd_int}]
set_property PACKAGE_PIN U21 [get_ports {lcd_bl_pwm}]
set_property PACKAGE_PIN U20 [get_ports {lcd_scl}]
set_property PACKAGE_PIN V20 [get_ports {lcd_sda}]
set_property PACKAGE_PIN Y19 [get_ports {lcd_hsync}]
set_property PACKAGE_PIN AA19 [get_ports {lcd_vsync}]
set_property PACKAGE_PIN J21 [get_ports {lcd_dclk}]
set_property PACKAGE_PIN J22 [get_ports {lcd_de}]
set_property PACKAGE_PIN K21 [get_ports {lcd_b[6]}]
set_property PACKAGE_PIN J20 [get_ports {lcd_b[7]}]
set_property PACKAGE_PIN P16 [get_ports {lcd_b[4]}]
set_property PACKAGE_PIN R16 [get_ports {lcd_b[5]}]
set_property PACKAGE_PIN M17 [get_ports {lcd_b[2]}]
set_property PACKAGE_PIN L17 [get_ports {lcd_b[3]}]
set_property PACKAGE_PIN T18 [get_ports {lcd_b[0]}]
set_property PACKAGE_PIN R18 [get_ports {lcd_b[1]}]
set_property PACKAGE_PIN P20 [get_ports {lcd_g[6]}]
set_property PACKAGE_PIN P21 [get_ports {lcd_g[7]}]
set_property PACKAGE_PIN T19 [get_ports {lcd_g[4]}]
set_property PACKAGE_PIN R19 [get_ports {lcd_g[5]}]
set_property PACKAGE_PIN P15 [get_ports {lcd_g[2]}]
set_property PACKAGE_PIN N15 [get_ports {lcd_g[3]}]
set_property PACKAGE_PIN M16 [get_ports {lcd_g[0]}]
set_property PACKAGE_PIN M15 [get_ports {lcd_g[1]}]
set_property PACKAGE_PIN AB19 [get_ports {lcd_r[6]}]
set_property PACKAGE_PIN AB20 [get_ports {lcd_r[7]}]
set_property PACKAGE_PIN W22 [get_ports {lcd_r[4]}]
set_property PACKAGE_PIN V22 [get_ports {lcd_r[5]}]
set_property PACKAGE_PIN W21 [get_ports {lcd_r[2]}]
set_property PACKAGE_PIN W20 [get_ports {lcd_r[3]}]
set_property PACKAGE_PIN AA21 [get_ports {lcd_r[0]}]
set_property PACKAGE_PIN AB21 [get_ports {lcd_r[1]}]


set_property IOSTANDARD LVCMOS33 [get_ports {lcd_int}]
set_property IOSTANDARD LVCMOS33 [get_ports lcd_bl_pwm]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_scl}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_sda}]
set_property IOSTANDARD LVCMOS33 [get_ports lcd_hsync]
set_property IOSTANDARD LVCMOS33 [get_ports lcd_vsync]
set_property IOSTANDARD LVCMOS33 [get_ports lcd_dclk]
set_property IOSTANDARD LVCMOS33 [get_ports lcd_de]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_b[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_b[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_b[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_b[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_b[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_b[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_b[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_b[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_g[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_g[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_g[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_g[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_g[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_g[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_g[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_g[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_r[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_r[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_r[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_r[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_r[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_r[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_r[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_r[1]}]