// This module defines the connectrules for elect2logic_2 and logic2elect_2

connectrules mixedsignal_33;
    connect logic2elect_2  #(.voh(3.3),.thresh(1.65));
    connect elect2logic_2  #(.thresholdLo(0.99),.thresholdHi(2.31));
endconnectrules
