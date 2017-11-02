#ifndef _TRADE_DATA_H_
#define _TRADE_DATA_H_

#include "CTP\ThostFtdcUserApiStruct.h"
#include "Types.h"

enum wdOrderType;

//! ��½��Ϣ
struct QUANTBOX_API wdConnectInfo
{
	wdConnectType type;
	wdConnectionStatus status;
	CThostFtdcRspUserLoginField loginField;
	TThostFtdcErrorMsgType	ErrorMsg;

	wdConnectInfo(wdConnectType t, wdConnectionStatus s, CThostFtdcRspUserLoginField *l = nullptr, TThostFtdcErrorMsgType e = nullptr);
};

//! �ʽ��˻�
struct QUANTBOX_API wdTradingAccount
{
	///�����ʽ�
	double FundAvailable; 	
	///ƽ��ӯ��
	double CloseProfit; 
	///�ֲ�ӯ��
	double PositionProfit; 
	///������
	double Commission; 
	///����������
	double FrozenCommission; 
	///��֤���ܶ�
	double CurrMargin; 
	///����ı�֤��
	double FrozenMargin; 
	///�����
	double Deposit; 
	///������
	double Withdraw; 
	///����Ȩ��
	double PreEquity; 
	///���ն�̬Ȩ��
	double CurrentEquity; 
	///������
	double RiskRatio; 

	void update(const CThostFtdcTradingAccountField *pTradingAccount);
};

struct QUANTBOX_API wdOrderKey
{
	///ǰ�ñ��
	TThostFtdcFrontIDType	FrontID;
	///�Ự���
	TThostFtdcSessionIDType	SessionID;
	///��������
	TThostFtdcOrderRefType	OrderRef;

	wdOrderKey() { memset(this, 0, sizeof(wdOrderKey));}
	wdOrderKey(TThostFtdcFrontIDType, TThostFtdcSessionIDType, const TThostFtdcOrderRefType);
	wdOrderKey(char **values); // �����ݿ����ݹ��챨����ֵ
	wdOrderKey(const wdOrderKey &other);
	wdOrderKey &operator=(const wdOrderKey &other);
	bool operator<(const wdOrderKey &other) const ;
};

//! ����
struct QUANTBOX_API wdOrder
{
	///ǰ�ñ��
	TThostFtdcFrontIDType		FrontID;
	///�Ự���
	TThostFtdcSessionIDType		SessionID;
	///��������
	TThostFtdcOrderRefType		OrderRef;

	///�������
	TThostFtdcOrderSysIDType	OrderSysID;	
	///��������
	wdOrderType					Type;
	///��Լ����
	TThostFtdcInstrumentIDType	InstrumentID;
	///����
	wdDirectionType				Dir;
	///��ƽ
	wdOffsetFlagType			Offset;
	///״̬
	wdOrderStatus				Status;
	///�����۸�
	double						Price; 
	///��������
	int							Hands;	
	///δ�ɽ�����
	int							AvaHands;
	///�ɽ�����
	int							TradedHands;
	///ί��ʱ��
	TThostFtdcTimeType			InsertTime;
	///״̬��Ϣ
	TThostFtdcErrorMsgType		StatusMsg;
	///����������
	TThostFtdcExchangeIDType	ExchangeID;

	wdOrder() { memset(this, 0, sizeof(wdOrder));}
	wdOrder(char **values); // �����ݿ����ݹ��챨��
	wdOrder &update(const CThostFtdcInputOrderField *, wdOrderStatus, const char *);
	wdOrder &update(const CThostFtdcOrderField *);
	wdOrder &update(const CThostFtdcInputOrderActionField *, const char *);
	wdOrder &update(const CThostFtdcOrderActionField *, const char *);
	operator CThostFtdcInputOrderActionField();
};

//! �ɽ���
struct QUANTBOX_API wdTradeTicket
{
	///�ɽ����
	TThostFtdcTradeIDType		TradeID;
	///�������
	TThostFtdcOrderSysIDType	OrderSysID;
	///��Լ����
	TThostFtdcInstrumentIDType	InstrumentID;
	///����
	wdDirectionType				Dir;
	///��ƽ
	wdOffsetFlagType			Offset;
	///�ɽ�����
	double						Price; 
	///�ɽ���
	int							Hands;	
	///�ɽ�����
	TThostFtdcTradeTypeType		TradeType;
	///�ɽ�ʱ��
	TThostFtdcTimeType			TradeTime;	
	///����������
	TThostFtdcExchangeIDType	ExchangeID;
	///Ͷ���ױ���־
	TThostFtdcHedgeFlagType		HedgeFlag;

	wdTradeTicket() { memset(this, 0, sizeof(wdTradeTicket));}
	wdTradeTicket &update(const CThostFtdcTradeField *pTrade);
};

struct QUANTBOX_API wdPositionKey
{
	///��Լ��
	TThostFtdcInstrumentIDType	InstrumentID;
	///���
	wdDirectionType				Dir;

	wdPositionKey() { memset(this, 0, sizeof(wdPositionKey));}
	wdPositionKey(const TThostFtdcInstrumentIDType inst, TThostFtdcDirectionType d);
	bool operator<(const wdPositionKey &other) const;
};

//! �ֲ� 
struct QUANTBOX_API wdPosition
{
	///��Լ��
	TThostFtdcInstrumentIDType	InstrumentID;
	///���
	wdDirectionType				Dir;

	///�ܲ�
	int		TPos; 
	///���ò�
	int		APos; 
	///���־���
	double	PosAvgPrice; 
	
	wdPosition() { memset(this, 0, sizeof(wdPosition));}
	void update(const CThostFtdcTradeField *pTrade); 
	void update(const CThostFtdcInvestorPositionField *);
};

//! �ǵ�ͣ��
struct QUANTBOX_API wdLimitPrice
{
	///��ͣ��
	double	UpperLimitPrice;
	///��ͣ��
	double	LowerLimitPrice;

	wdLimitPrice(double UpperLimitPrice = 0., double LowerLimitPrice = 0.);
};
//! ��Լ��Ϣ
struct QUANTBOX_API wdInstrument
{
	///��Ʒ����
	TThostFtdcInstrumentIDType	ProductID;
	///��Լ����
	TThostFtdcInstrumentIDType	InstrumentID;
	///��Լ����
	TThostFtdcInstrumentNameType	InstrumentName;
	///����������
	TThostFtdcExchangeIDType	ExchangeID;
	///��Լ��������
	TThostFtdcVolumeMultipleType	VolumeMultiple;
	///��С�䶯��λ
	TThostFtdcPriceType	PriceTick;
	///��Ʒ����
	TThostFtdcProductClassType	ProductClass;
	///������
	TThostFtdcDateType	ExpireDate;
	///��ͷ��֤����
	TThostFtdcRatioType	LongMarginRatioByMoney;
	///��ͷ��֤����
	TThostFtdcRatioType	ShortMarginRatioByMoney;
	///������������
	TThostFtdcRatioType	OpenRatioByMoney;
	///ƽ����������
	TThostFtdcRatioType	CloseRatioByMoney;
	///ƽ����������
	TThostFtdcRatioType	CloseTodayRatioByMoney;
	///��Լ����״̬
	TThostFtdcInstrumentStatusType	InstrumentStatus;
	wdLimitPrice				LimitPrice;

	wdInstrument() { memset(this, 0, sizeof(wdInstrument));}
	void update(const CThostFtdcInstrumentField *);
	void update(const CThostFtdcInstrumentMarginRateField *);
	void update(const CThostFtdcInstrumentCommissionRateField *);
	void update(const CThostFtdcInstrumentStatusField *);
	void update(const CThostFtdcDepthMarketDataField *);
};


#endif