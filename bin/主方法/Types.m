%���� Matlab�������ڲ����ݽṹ

%% ����
global md;

% Tick   
%������Ҫ��ѯIF1409�����¼۵ķ���: NPrice.IF1409,�õ�NaN���������¼�
global ExchangeTime; %������ʱ���(char)
global LocalTime; % ����ʱ���(char)
global NPrice; %���¼� 
global BPrice; %��1��
global BQuant; %��1��
global APrice; %��1��
global AQuant; %��1��
global Volume; %�ɽ���
global Turnover; %�ɽ����
global OpenInterest; %�ֲ���
global MaxP; %���յ������߼� 
global MinP; %���յ������ͼ� 
global UpperLimitPrice; %�������ͣ��
global LowerLimitPrice; %����ĵ�ͣ��

% KLine
%������Ҫ��ѯIF1409��3����K�ߵ���߼ۣ�HighestPrice.IF1409.M3
global ExchangeTime_KLine;
global OpenPrice;
global HighestPrice;
global LowestPrice;
global ClosePrice;
global Volume_KLine;
global OpenInterest_KLine;

%% ����
global td;

%�ʽ��˻�
%����Ͷ�����˻�Ϊ00000015,�����±�����keyΪ'account00000015',
global FundAvailable; %�����ʽ�
global CloseProfit; %ƽ��ӯ��
global PositionProfit; %�ֲ�ӯ��
global Commission; %������
global FrozenCommission; %����������
global CurrMargin; %��֤���ܶ�
global FrozenMargin; %����ı�֤��
global Deposit; %�����
global Withdraw; %������
global PreEquity; %����Ȩ��
global CurrentEquity; %���ն�̬Ȩ��
global RiskRatio; %������

% ���ñ���
global AvailableOrderPrice_BuyOpen; %�򿪵��ľ���
global AvailableOrderHands_BuyOpen; %�򿪵�������
global AvailableOrderPrice_BuyClose;
global AvailableOrderHands_BuyClose;
global AvailableOrderPrice_BuyCloseToday;
global AvailableOrderHands_BuyCloseToday;
global AvailableOrderPrice_SellOpen;
global AvailableOrderHands_SellOpen;
global AvailableOrderPrice_SellClose;
global AvailableOrderHands_SellClose;
global AvailableOrderPrice_SellCloseToday;
global AvailableOrderHands_SellCloseToday;

% ���б���
global AllOrderPrice_BuyOpen; %�򿪵��ľ���
global AllOrderHands_BuyOpen; %�򿪵�������
global AllOrderPrice_BuyClose;
global AllOrderHands_BuyClose;
global AllOrderPrice_BuyCloseToday;
global AllOrderHands_BuyCloseToday;
global AllOrderPrice_SellOpen;
global AllOrderHands_SellOpen;
global AllOrderPrice_SellClose;
global AllOrderHands_SellClose;
global AllOrderPrice_SellCloseToday;
global AllOrderHands_SellCloseToday;

% �ɽ���
global TradePrice_BuyOpen;
global TradeHands_BuyOpen;
global TradePrice_BuyClose;
global TradeHands_BuyClose;
global TradePrice_BuyCloseToday;
global TradeHands_BuyCloseToday;
global TradePrice_SellOpen;
global TradeHands_SellOpen;
global TradePrice_SellClose;
global TradeHands_SellClose;
global TradePrice_SellCloseToday;
global TradeHands_SellCloseToday;

%�ֲ�
global TLPos; %�ܶ��
global ALPos; %���ö��
global OLPos; %�򿪶��
global NLPos; %�񿪶��
global ANLPos; %�񿪿��ö��
global LPosAvgPrice; %��־���

global TSPos; %�ܿղ�
global ASPos; %���ÿղ�
global OSPos; %�򿪿ղ�
global NSPos; %�񿪿ղ�
global ANSPos; %�񿪿��ÿղ�
global SPosAvgPrice; %�ղ־���


%{
global AllInstruments; %{'', '', '', ...}
global KLineOfAllInstruments; %
%global longshort;
%}
