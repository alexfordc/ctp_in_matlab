function  OnRspQryInstrumentMarginRate( ~, arg )
%�����ѯ��Լ��֤������Ӧ

if arg.pRspInfo.ErrorID ~= 0
    str = sprintf('��ѯ��Լ��֤����ʧ�ܣ�%s', arg.pRspInfo.ErrorMsg);
    disp(str);
    return;
end

str = sprintf('��Լ����(%s), ��ͷ��֤����(%f),��ͷ��֤����(%f)', char(arg.pInstrumentMarginRate.InstrumentID), arg.pInstrumentMarginRate.LongMarginRatioByMoney,arg.pInstrumentMarginRate.ShortMarginRatioByMoney);
disp(str);

if arg.bIsLast == true
   str = sprintf('��ѯ��Լ%s��֤�������', char(arg.pInstrumentMarginRate.InstrumentID));
    disp(str);
end


end

