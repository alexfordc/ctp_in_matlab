function  OnErrRtnOrderAction( ~,  arg)
%��������

str = sprintf('����ʧ�ܣ��������(%d),������Ϣ(%s),��Լ����(%s),��������(%s)', arg.pRspInfo.ErrorID, char(arg.pRspInfo.ErrorMsg), char(arg.pInputOrder.InstrumentID), char(arg.pInputOrder.OrderRef));
disp(str)

end

