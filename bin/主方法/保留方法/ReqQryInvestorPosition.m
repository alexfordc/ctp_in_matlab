function  ReqQryInvestorPosition(Instrument)
%��ѯͶ���ֲ߳֡��ֶ�ֺͿղ����֣����ܲ�λ�����ò֡��򿪲֡��񿪲֡��񿪿��ò֡���λ���۵�
% <param name="instrument" type="char">��Լ����:����-������</param>

%������ 
% ReqQryInvestorPosition('IF1406')
% ReqQryInvestorPosition('IF1406; IF1409')
% ReqQryInvestorPosition('')

    global td;
    if nargin<1 || strcmp(Instrument, '')
        td.ReqQryInvestorPosition('');
        return;
    end

    instruments = strrep(Instrument, ',', ' ');
    instruments = strrep(instruments, ';', ' ');

    [first, rest] = strtok(instruments);
    while ~strcmp(first, '')
        td.ReqQryInvestorPosition(first);
        [first, rest] = strtok(rest);
    end
    
end

