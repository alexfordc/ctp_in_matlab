function OnErrRtnOrderInsert( ~, arg )
%����¼�����ر�   ������ӿں���û������

str = sprintf('����¼�����ر�: �������(%d),������Ϣ(%s)����Լ����(%s),��������(%s),GTD����(%s)', arg.pRspInfo.ErrorID, char(arg.pRspInfo.ErrorMsg), char(arg.pInputOrder.InstrumentID), char(arg.pInputOrder.OrderRef), char(arg.pInputOrder.GTDDate));
disp(str);

end

