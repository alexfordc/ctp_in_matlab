function  OnRspOrderAction( ~, arg )
%��������

str = sprintf('��������: ��Լ����(%s),��������(%s),����(%s)', char(arg.pInputOrderAction.InstrumentID), char(arg.pInputOrderAction.OrderRef), char(arg.pRspInfo.ErrorMsg));
disp(str)

end

