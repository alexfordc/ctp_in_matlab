function OnRspQryInvestorPositionDetail( ~ ,arg )
%��ѯͶ���ֲ߳���ϸ��Ӧ

str = sprintf('��ѯͶ���ֲ߳���ϸ��Ӧ: ��Լ����(%s),��������(%s),�ɽ����(%s),Volume(%d),���ּ�(%f)', arg.pInvestorPositionDetail.InstrumentID, arg.pInvestorPositionDetail.OpenDate, arg.pInvestorPositionDetail.TradeID, arg.pInvestorPositionDetail.Volume,arg.pInvestorPositionDetail.OpenPrice);
disp(str)

end

