function  OnRspQrySettlementInfo(~, arg)
%�������Ӧ

if arg.pRspInfo.ErrorID == 0
    str = sprintf('������(%s),������(%d),��Ϣ����(%s)', char(arg.pSettlementInfo.TradingDay), arg.pSettlementInfo.SettlementID, char(arg.pSettlementInfo.Content));
    disp(str);
else
    str = sprintf('�����ʧ��:%s', arg.pRspInfo.ErrorMsg);
    disp(str);
end

end

