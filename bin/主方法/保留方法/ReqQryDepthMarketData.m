function  ReqQryDepthMarketData( Instrument )
%��ѯ��������
% <param name="Instrument">��Լ���룺��','��';'��������Ϊ�գ�������</param>

%������ 
% ReqQryDepthMarketData('IF1406')
% ReqQryDepthMarketData('IF1406, cu1409, ME501; ME502,  ME503')
% ReqQryDepthMarketData('')

    global td;
    if nargin<1 || strcmp(Instrument, '')
        td.ReqQryDepthMarketData('');
        return;
    end
    
    instruments = strrep(Instrument, ',', ' ');
    instruments = strrep(instruments, ';', ' ');
    
    [first, rest] = strtok(instruments);
    while ~strcmp(first, '')
        td.ReqQryDepthMarketData(first);
        [first, rest] = strtok(rest);
    end
end
