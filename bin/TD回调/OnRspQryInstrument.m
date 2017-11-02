function  OnRspQryInstrument( ~, arg )
%��ѯ��Լ��Ӧ

if arg.pRspInfo.ErrorID ~= 0
    str = sprintf('��ѯ��Լ%sʧ�ܣ�%s', char(arg.pInstrument.InstrumentID), char(arg.pRspInfo.ErrorMsg));
    disp(str);
    return;
end

global AllInstruments;
AllInstruments{size(AllInstruments, 2) + 1} = char(arg.pInstrument.InstrumentID);

global KLineOfAllInstruments;
KLineOfAllInstruments = setfield(KLineOfAllInstruments, char(arg.pInstrument.InstrumentID), {});

global VolumeMultiple;
VolumeMultiple = setfield(VolumeMultiple, char(arg.pInstrument.InstrumentID), arg.pInstrument.VolumeMultiple);

end
