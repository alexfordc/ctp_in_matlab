function OnRtnOrder(~, arg)
%������Ӧ��һ�����ί�гɹ��ύ����������
    
str = sprintf('������Ӧ: ���ر������(%s),��Լ����(%s),����������(%s),�������(%s),�����ύ״̬(%s),����״̬(%s),״̬��Ϣ(%s)',char(arg.pOrder.OrderLocalID),char(arg.pOrder.InstrumentID), char(arg.pOrder.ExchangeID), char(arg.pOrder.OrderSysID), char(arg.pOrder.OrderSubmitStatus), char(arg.pOrder.OrderStatus),char(arg.pOrder.StatusMsg));
disp(str);

end