function  OnRspQryTrade( ~, arg )
%��ɽ���Ӧ

if arg.pRspInfo.ErrorID == 0
    str = sprintf('��Լ����(%s),��������(%s),�ɽ����(%s),�������(%s),�ɽ�ʱ��(%s %s)', char(arg.pTrade.InstrumentID), char(arg.pTrade.OrderRef), char(arg.pTrade.TradeID), char(arg.pTrade.OrderSysID), char(arg.pTrade.TradeDate), char(arg.pTrade.TradeTime));
    disp(str);
    if arg.bIsLast == true
        ReqQryInvestorPosition(char(arg.pTrade.InstrumentID)); % ���²�ֲ�
        disp('��ѯ�ɽ����'); 
    end
else
    str = sprintf('��ɽ�ʧ��:%s', arg.pRspInfo.ErrorMsg);
    disp(str);
end

end