function OnRspQryInstrumentCommissionRate( ~, arg )
%�����ѯ��Լ����������Ӧ

if arg.pRspInfo.ErrorID ~= 0
    str = sprintf('��ѯ��Լ��������ʧ�ܣ�%s', arg.pRspInfo.ErrorMsg);
    disp(str);
    return;
end

str = sprintf('������������(%f),ƽ����������(%f),ƽ����������(%f)', arg.pInstrumentCommissionRate.OpenRatioByMoney, arg.pInstrumentCommissionRate.CloseRatioByMoney, arg.pInstrumentCommissionRate.CloseTodayRatioByMoney);
disp(str);

if arg.bIsLast == true
   str = sprintf('��ѯ��Լ%s�����������', char(arg.pInstrumentCommissionRate.InstrumentID));
    disp(str);
end




end

