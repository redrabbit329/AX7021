# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7z010clg400-2

set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir D:/test/ad7606_test_v2/axi_adc/axi_adc.cache/wt [current_project]
set_property parent.project_path D:/test/ad7606_test_v2/axi_adc/axi_adc.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property vhdl_version vhdl_2k [current_fileset]
read_ip D:/test/ad7606_test_v2/axi_adc/src/adc_buf/adc_buf.xci
set_property used_in_implementation false [get_files -all d:/test/ad7606_test_v2/axi_adc/src/adc_buf/adc_buf.dcp]
set_property is_locked true [get_files D:/test/ad7606_test_v2/axi_adc/src/adc_buf/adc_buf.xci]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]
synth_design -top adc_buf -part xc7z010clg400-2 -mode out_of_context
rename_ref -prefix_all adc_buf_
write_checkpoint -noxdef adc_buf.dcp
catch { report_utilization -file adc_buf_utilization_synth.rpt -pb adc_buf_utilization_synth.pb }
if { [catch {
  file copy -force D:/test/ad7606_test_v2/axi_adc/axi_adc.runs/adc_buf_synth_1/adc_buf.dcp D:/test/ad7606_test_v2/axi_adc/src/adc_buf/adc_buf.dcp
} _RESULT ] } { 
  send_msg_id runtcl-3 error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
  error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
}
if { [catch {
  write_verilog -force -mode synth_stub D:/test/ad7606_test_v2/axi_adc/src/adc_buf/adc_buf_stub.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a Verilog synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}
if { [catch {
  write_vhdl -force -mode synth_stub D:/test/ad7606_test_v2/axi_adc/src/adc_buf/adc_buf_stub.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a VHDL synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}
if { [catch {
  write_verilog -force -mode funcsim D:/test/ad7606_test_v2/axi_adc/src/adc_buf/adc_buf_sim_netlist.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the Verilog functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}
if { [catch {
  write_vhdl -force -mode funcsim D:/test/ad7606_test_v2/axi_adc/src/adc_buf/adc_buf_sim_netlist.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the VHDL functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}

if {[file isdir D:/test/ad7606_test_v2/axi_adc/axi_adc.ip_user_files/ip/adc_buf]} {
  catch { 
    file copy -force D:/test/ad7606_test_v2/axi_adc/src/adc_buf/adc_buf_stub.v D:/test/ad7606_test_v2/axi_adc/axi_adc.ip_user_files/ip/adc_buf
  }
}

if {[file isdir D:/test/ad7606_test_v2/axi_adc/axi_adc.ip_user_files/ip/adc_buf]} {
  catch { 
    file copy -force D:/test/ad7606_test_v2/axi_adc/src/adc_buf/adc_buf_stub.vhdl D:/test/ad7606_test_v2/axi_adc/axi_adc.ip_user_files/ip/adc_buf
  }
}
