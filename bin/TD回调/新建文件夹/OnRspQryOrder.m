function  OnRspQryOrder( ~, arg )
%��ί����Ӧ

if arg.pRspInfo.ErrorID == 0
    str = sprintf('��Լ�ڽ������Ĵ���(%s)����������(%s)�������(%s)�����ύ״̬(%s)����״̬(%s)״̬��Ϣ(%s)', char(arg.pOrder.ExchangeInstID), char(arg.pOrder.ExchangeID), char(arg.pOrder.OrderSysID), char(arg.pOrder.OrderSubmitStatus), char(arg.pOrder.OrderStatus), char(arg.pOrder.StatusMsg));
    disp(str);
    if arg.bIsLast == true
        disp('��ѯί�����'); 
    end
else
    str = sprintf('��ί��ʧ��:%s', char(arg.pRspInfo.ErrorMsg));
    disp(str);
end

end

