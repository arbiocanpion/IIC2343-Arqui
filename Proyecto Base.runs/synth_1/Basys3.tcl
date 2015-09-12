# 
# Synthesis run script generated by Vivado
# 

set_param xicom.use_bs_reader 1
debug::add_scope template.lib 1
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a35tcpg236-1

set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir {Y:/Grupo 1/SegundoAvance/Proyecto Base.cache/wt} [current_project]
set_property parent.project_path {Y:/Grupo 1/SegundoAvance/Proyecto Base.xpr} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
read_vhdl -library xil_defaultlib {
  {Y:/Grupo 1/SegundoAvance/Proyecto Base.srcs/sources_1/imports/sources_1/imports/new/HA.vhd}
  {Y:/Grupo 1/SegundoAvance/Proyecto Base.srcs/sources_1/imports/sources_1/imports/new/FA.vhd}
  {Y:/Grupo 1/SegundoAvance/Proyecto Base.srcs/sources_1/new/ShiftLeft.vhd}
  {Y:/Grupo 1/SegundoAvance/Proyecto Base.srcs/sources_1/new/ShiftRight.vhd}
  {Y:/Grupo 1/SegundoAvance/Proyecto Base.srcs/sources_1/imports/sources_1/new/Adder.vhd}
  {Y:/Grupo 1/SegundoAvance/Proyecto Base.srcs/sources_1/new/ALU.vhd}
  {Y:/Grupo 1/SegundoAvance/Proyecto Base.srcs/sources_1/new/Reg.vhd}
  {Y:/Grupo 1/SegundoAvance/Proyecto Base.srcs/sources_1/new/Clock_Divider.vhd}
  {Y:/Grupo 1/SegundoAvance/Proyecto Base.srcs/sources_1/new/Led_Driver.vhd}
  {Y:/Grupo 1/SegundoAvance/Proyecto Base.srcs/sources_1/new/Basys3.vhd}
}
read_xdc {{Y:/Grupo 1/SegundoAvance/Proyecto Base.srcs/constrs_1/new/Basys3.xdc}}
set_property used_in_implementation false [get_files {{Y:/Grupo 1/SegundoAvance/Proyecto Base.srcs/constrs_1/new/Basys3.xdc}}]

synth_design -top Basys3 -part xc7a35tcpg236-1
write_checkpoint -noxdef Basys3.dcp
catch { report_utilization -file Basys3_utilization_synth.rpt -pb Basys3_utilization_synth.pb }
