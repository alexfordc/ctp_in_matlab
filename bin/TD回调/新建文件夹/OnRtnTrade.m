function OnRtnTrade(~, arg)
%�ɽ���Ӧ

str = sprintf('�ɽ���Ӧ:����������(%s),�ɽ����(%s),�������(%s)', char(arg.pTrade.ExchangeID), char(arg.pTrade.TradeID), char(arg.pTrade.OrderSysID));
disp(str);

end
