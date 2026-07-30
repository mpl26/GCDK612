// 'ConnRules_18V.vams' - Verilog-AMS 1.8 volt connection rules file.
// last revised:  10/22/02 (ronv)

// This file is a template for definition of rules for a particular 
// logic family.  Values for some typical parameters are defined here,
// then used in the three sets of connections rules below.
// See the "README.txt" file for a more complete usage description.

`define Vsup  1.8
`define Vthi  1.2
`define Vtlo  0.6
`define Tr    0.2n
`define Rlo   200
`define Rhi   200
`define Rx    40
`define Rz    10M


connectrules ConnRules_18V_mid;
  connect E2L #( .vsup(`Vsup), .vthi(`Vthi), .vtlo(`Vtlo), .tr(`Tr) );
  connect L2E_1 #( .vsup(`Vsup), .tr(`Tr), .rout(`Rlo) );
  connect Bidir_0 #( .vsup(`Vsup), .vthi(`Vthi), .vtlo(`Vtlo),
                   .tr(`Tr), .rout(`Rlo) );
endconnectrules

