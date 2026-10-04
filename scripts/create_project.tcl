# Create the Vivado project for the 8-bit memory-mapped microcomputer.
# Run this file from the Vivado Tcl Console:
#   source scripts/create_project.tcl

set project_name "8Bit_Memory_Mapped_Microcomputer"
set project_dir [file normalize [file join [pwd] "vivado_project"]]
set part_name "xc7a35tcsg324-1"

if {[file exists $project_dir]} {
    file delete -force $project_dir
}

create_project $project_name $project_dir -part $part_name

add_files [file normalize [file join [pwd] "rtl" "COMPUTER_SYSTEM_DESIGN.v"]]
set_property top computer_system_top [current_fileset]

add_files -fileset sim_1 [file normalize [file join [pwd] "tb" "COMPUTER_SYSTEM_DESIGN_TB.v"]]
set_property top COMPUTER_SYSTEM_DESIGN_TB [get_filesets sim_1]

update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

save_project_as $project_name $project_dir/$project_name.xpr -force

puts ""
puts "Project created successfully."
puts "Project: $project_dir/$project_name.xpr"
puts "Device:  $part_name"
puts "RTL top: computer_system_top"
puts "Sim top: COMPUTER_SYSTEM_DESIGN_TB"
puts ""
puts "Run Behavioral Simulation from the Vivado GUI."
