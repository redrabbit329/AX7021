onbreak {quit -f}
onerror {quit -f}

vsim -voptargs="+acc" -t 1ps -pli "D:/Xilinx/Vivado/2015.4/lib/win64.o/libxil_vsim.dll" -L unisims_ver -L unimacro_ver -L secureip -L xil_defaultlib -lib xil_defaultlib xil_defaultlib.system xil_defaultlib.glbl

do {wave.do}

view wave
view structure
view signals

do {system.udo}

run -all

quit -force
