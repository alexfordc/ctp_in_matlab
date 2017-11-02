function  ReqQryInstrument( Instrument )
%��ѯ��Լ
% <param name="Instrument">��Լ���룺��','��';'��������Ϊ�գ�������</param>

% ReqQryInstrument('IF1406')
% ReqQryInstrument('IF1406, cu1409, ME501; ME502,  ME503')
% ReqQryInstrument('')

    global td;
    if nargin<1 || strcmp(Instrument, '')
        td.ReqQryInstrument('');
        return;
    end

    instruments = strrep(Instrument, ',', ' ');
    instruments = strrep(instruments, ';', ' ');

    [first, rest] = strtok(instruments);
    while ~strcmp(first, '')
        td.ReqQryInstrument(first);
        [first, rest] = strtok(rest);
    end

end

