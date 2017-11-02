function  OnRspQryTradingAccount( ~ ,arg )
%�����ʽ��˻�

if arg.pRspInfo.ErrorID ~= 0
   str = sprintf('��ѯ�ʽ��˻�ʧ�ܣ�%s', arg.pRspInfo.ErrorMsg); 
   disp(str);
   return;
end

Types;
AccountID = ['account' , char(arg.pTradingAccount.AccountID)]; %Ͷ�����˺�

FundAvailable = setfield(FundAvailable, AccountID, arg.pTradingAccount.Available); %�����ʽ�
CloseProfit = setfield(CloseProfit, AccountID, arg.pTradingAccount.CloseProfit); %ƽ��ӯ��
PositionProfit = setfield(PositionProfit, AccountID, arg.pTradingAccount.PositionProfit); %�ֲ�ӯ��
Commission = setfield(Commission, AccountID, arg.pTradingAccount.Commission); %������
FrozenCommission = setfield(FrozenCommission, AccountID, arg.pTradingAccount.FrozenCommission); %����������
CurrMargin = setfield(CurrMargin, AccountID, arg.pTradingAccount.CurrMargin); %��֤���ܶ�
FrozenMargin = setfield(FrozenMargin, AccountID, arg.pTradingAccount.FrozenMargin); %����ı�֤��
Deposit = setfield(Deposit, AccountID, arg.pTradingAccount.Deposit); %�����
Withdraw = setfield(Withdraw, AccountID, arg.pTradingAccount.Withdraw); %������
PreEquity = setfield(PreEquity, AccountID, arg.pTradingAccount.PreBalance); %����Ȩ��

%��̬Ȩ��=���ս��㣨����Ȩ�棩-������+�����
sEquity = arg.pTradingAccount.PreBalance - arg.pTradingAccount.Withdraw + arg.pTradingAccount.Deposit;
%��̬Ȩ��=��̬Ȩ��+ ƽ��ӯ��+ �ֲ�ӯ��- ������
dEquity = sEquity + arg.pTradingAccount.CloseProfit + arg.pTradingAccount.PositionProfit - arg.pTradingAccount.Commission;
CurrentEquity = setfield(CurrentEquity, AccountID, dEquity); %���ն�̬Ȩ��

%������ = ��֤�� / ���ն�̬Ȩ��
RiskRatio = setfield(RiskRatio, AccountID, arg.pTradingAccount.CurrMargin / dEquity); %������

if arg.bIsLast == true
    disp('���ʽ��˻����')
end

str = sprintf('�����ʽ��˻���Ͷ�����ʺ�(%s), �����ʽ�(%f)', char(arg.pTradingAccount.AccountID), arg.pTradingAccount.Available);
disp(str)

end

