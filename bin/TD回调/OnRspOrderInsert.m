function  OnRspOrderInsert( ~, arg )
%��������

str = sprintf('��������: ��Լ����(%s),��������(%s),����(%s)', char(arg.pInputOrder.InstrumentID), char(arg.pInputOrder.OrderRef), char(arg.pRspInfo.ErrorMsg));
disp(str)

end

