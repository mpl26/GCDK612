### Flow Commands ###
input_type {pr_lef}
setvar library_name libgen_lef
setvar tech_file icecaps/icecaps.tch

generic_power_names 1.0 {VDD}
generic_power_names 2.5 {VDD25 VDDIOR}

generic_ground_names 0.0 {VSS GND VSS25 VSSIOR}

setvar generate_port_powerview TRUE


### Input Commands ###
gds_file_list_file {}
lef_file_list_file {all.lef}

cell_list {*}
include gds.layermap
include lefdef.layermap

####### End of File #########
