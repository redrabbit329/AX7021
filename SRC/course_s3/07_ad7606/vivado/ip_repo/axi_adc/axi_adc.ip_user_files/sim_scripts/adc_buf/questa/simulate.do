onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib adc_buf_opt

do {wave.do}

view wave
view structure
view signals

do {adc_buf.udo}

run -all

quit -force
