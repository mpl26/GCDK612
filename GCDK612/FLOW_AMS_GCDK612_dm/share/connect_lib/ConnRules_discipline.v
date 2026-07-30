// This module defines the connectrules for elect2logic and logic2elect

`include "constants.vams"
`include "disciplines.vams"
discipline LOGIC_H
 domain discrete ;
enddiscipline

discipline LOGIC_L
 domain discrete ;
enddiscipline

connectrules discipline_connect;
    connect LOGIC_L, LOGIC_H resolveto LOGIC_H;
    connect elect2logic  #(.vthresh(2.5)) output LOGIC_H , input electrical; 
    connect logic2elect  #(.vhi(5)) output electrical ,  input LOGIC_H ;
    connect elect2logic  #(.vthresh(1.8)) output LOGIC_L , input electrical;
    connect logic2elect  #(.vhi(3.6), .tr(100n)) output electrical ,  input LOGIC_L ;
endconnectrules
