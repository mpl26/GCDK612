// This module defines the connectrules for elect2logic_2 and logic2elect_2

connectrules mixedsignal_18;
connect logic2elect_2 #(.voh(1.8),.thresh(0.9),.tr(100p),.tf(100p),.td(0));
connect elect2logic_2 #(.thresholdLo(0.4),.thresholdHi(0.9));
connect oz_bidir #(.vzdrive(0.9),.vhdrive(1.8),.vxdrive(0.9),.thresholdLo(0.55),.thresholdHi(1.3));
endconnectrules
