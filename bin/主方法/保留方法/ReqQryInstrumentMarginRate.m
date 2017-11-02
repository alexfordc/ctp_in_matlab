function ReqQryInstrumentMarginRate(Instrument)
%�����ѯ��Լ��֤����
% <param name="Instrument">��Լ���룺��','��';'����</param>

%������ 
% ReqQryInstrumentMarginRate('IF1406')
% ReqQryInstrumentMarginRate('IF1406, IF1409')

    global td;
    if nargin<1 || strcmp(Instrument, '')
        td.ReqQryInstrumentMarginRate('',  QuantBox.CSharp2CTP.TThostFtdcHedgeFlagType.Speculation); %��������
        return;
    end
    
    instruments = strrep(Instrument, ',', ' ');
    instruments = strrep(instruments, ';', ' ');

    [first, rest] = strtok(instruments);
    while ~strcmp(first, '')
        td.ReqQryInstrumentMarginRate(first,  QuantBox.CSharp2CTP.TThostFtdcHedgeFlagType.Speculation);
        [first, rest] = strtok(rest);
    end

end
