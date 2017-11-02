function  ReqQryInstrumentCommissionRate(Instrument)
%�����ѯ��Լ��������
% <param name="Instrument">��Լ���룺��','��'��'����</param>

%������ 
% ReqQryInstrumentCommissionRate('IF1406')
% ReqQryInstrumentCommissionRate('IF1406, IF1409')
    
    global td;
    if nargin<1 || strcmp(Instrument, '')
        td.ReqQryInstrumentCommissionRate(''); %��������
        return;
    end
    
    instruments = strrep(Instrument, ',', ' ');
    instruments = strrep(instruments, ';', ' ');

    [first, rest] = strtok(instruments);
    while ~strcmp(first, '')
        td.ReqQryInstrumentCommissionRate(first);
        [first, rest] = strtok(rest);
    end

end

