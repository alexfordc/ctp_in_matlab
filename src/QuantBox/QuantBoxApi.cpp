
#include "QuantBoxApi.h"
#include "CTPLastInfos.h"
#include "CTPMdApi.h"
#include "CTPTdApi.h"
#include "toolkit.h"
#include "Enums.h"
#include "GlobalVars.h"

//ע������ص�=======================================
QUANTBOX_API void __stdcall CTP_RegOnRtnDepthMarketData_Tick(fnOnTick pCallback)
{
	g_fnOnRtnDepthMarketData_Tick = pCallback;
}

QUANTBOX_API void __stdcall CTP_RegOnRtnDepthMarketData_KLine(fnOnKLine pCallback)
{
	g_fnOnRtnDepthMarketData_KLine = pCallback;
}

QUANTBOX_API void __stdcall CTP_RegOnHistory_Tick(fnOnTick pCallback)
{
	g_fnOnHistory_Tick = pCallback;
}

QUANTBOX_API void __stdcall CTP_RegOnHistory_KLine(fnOnKLine pCallback)
{
	g_fnOnHistory_KLine = pCallback;
}

QUANTBOX_API void __stdcall CTP_RegOnConnect(fnOnConnect pCallback)
{
	g_fnOnMdConnect = pCallback;
}


QUANTBOX_API void __stdcall CTP_RegOnRspError(fnOnError pCallback)
{
	g_fnOnMdRspError = pCallback;
}

//����ӿ�===========================================
QUANTBOX_API void __stdcall MD_Connect()
{
	CCTPMdApi::instance()->Connect();
}

QUANTBOX_API void __stdcall MD_Subscribe(const char *szInstrumentIds, const char *period)
{
	CCTPMdApi::instance()->Subscribe(szInstrumentIds, period);
}

QUANTBOX_API void __stdcall MD_Unsubscribe(const char *szInstrumentIds, const char *period)
{
	CCTPMdApi::instance()->Unsubscribe(szInstrumentIds, period);
}

QUANTBOX_API void __stdcall MD_SubscribeHistory(const char *beginTime, const char *endTime, const char *szInstrumentIDs, const char *period)
{
	CCTPMdApi::instance()->SubscribeHistory(beginTime, endTime, szInstrumentIDs, period);
}

QUANTBOX_API void __stdcall MD_Disconnect()
{
	CCTPMdApi::instance()->Disconnect();
}


QUANTBOX_API wdTick __stdcall GetLastTick(const char *Instrument, bool isHistory)
{
	return wdCTPLastInfos::instance()->GetLastTick(Instrument, isHistory);
}

// ��ȡĳ����Լ�����¼�
QUANTBOX_API void __stdcall GetLastTick(const char *Instrument, int Num, std::vector<wdTick> &vecLastTicks, bool isHistory)
{
	wdCTPLastInfos::instance()->GetLastTick(Instrument, Num, vecLastTicks, isHistory);
}

// ��ȡĳ����Լ��ĳ��period������һ��K��
QUANTBOX_API wdKLine __stdcall GetLastKLine(const char *szInstrumentID, const char *period, bool isHistory)
{
	return wdCTPLastInfos::instance()->GetLastKLine(szInstrumentID, period, isHistory);
}

QUANTBOX_API void __stdcall GetLastKLine(const char *Instrument, const char *period, int Num, std::vector<wdKLine> &vecLastKLines, bool isHistory)
{
	wdCTPLastInfos::instance()->GetLastKLine(Instrument, period, Num, vecLastKLines, isHistory);
}

QUANTBOX_API wdTradingAccount __stdcall GetTradingAccount(const char *szAccountID)
{
	return wdCTPLastInfos::instance()->GetTradingAccount(szAccountID);
}


//ע�ύ�׻ص�====================================================================



QUANTBOX_API void __stdcall CTP_RegOnRspQryInstrument(fnOnInstrument pCallback)
{
	g_fnOnRspQryInstrument = pCallback;
}


QUANTBOX_API void __stdcall CTP_RegOnRspQryInvestorPosition(fnOnPosition pCallback)
{
	g_fnOnRspQryInvestorPosition = pCallback;
}

QUANTBOX_API void __stdcall CTP_RegOnRspQryOrder(fnOnOrder pCallback)
{
	g_fnOnRspQryOrder = pCallback;
}

QUANTBOX_API void __stdcall CTP_RegOnRspQryTrade(fnOnTrade pCallback)
{
	g_fnOnRspQryTrade = pCallback;
}

QUANTBOX_API void __stdcall CTP_RegOnRspQrySettlementInfo(fnOnSettlementInfo pCallback)
{
	g_fnOnRspQrySettlementInfo = pCallback;
}

//���׽ӿ�===================================================
QUANTBOX_API void __stdcall TD_Connect()
{
	CCTPTdApi::instance()->Connect();
}

QUANTBOX_API void __stdcall TD_SendLimitOrder(const char *Instrument, double Price, int Volume,	wdDirectionType Direction, wdOffsetFlagType OffsetFlag)
{
	CCTPTdApi::instance()->SendLimitOrder(Instrument, Price, Volume, Direction, OffsetFlag);
}

QUANTBOX_API void __stdcall TD_SendMarketOrder(const char *Instrument, int Volume, wdDirectionType Direction, wdOffsetFlagType OffsetFlag)
{
	CCTPTdApi::instance()->TD_SendMarketOrder(Instrument, Volume, Direction, OffsetFlag);
}

QUANTBOX_API void __stdcall TD_SendContingentOrder(const char *Instrument, double Price, int Volume, wdDirectionType Direction, wdOffsetFlagType OffsetFlag,
												   wdContingentConditionType ContingentCondition, double StopPrice)
{
	CCTPTdApi::instance()->TD_SendContingentOrder(Instrument, Price, Volume, Direction, OffsetFlag, ContingentCondition, StopPrice);
}

QUANTBOX_API void __stdcall TD_CancelOrder(const char *Instrument, wdDirectionType Direction, wdOffsetFlagType OffsetFlag)
{
	CCTPTdApi::instance()->CancelOrder(Instrument, Direction, OffsetFlag);
}

QUANTBOX_API void __stdcall TD_CancelOrder(const wdOrder &order)
{
	wdOrder _order = order;
	CCTPTdApi::instance()->CancelOrder(_order);
}

QUANTBOX_API void __stdcall TD_ReqQryInvestorPosition(const char *szInstrumentId)
{
	CCTPTdApi::instance()->ReqQryInvestorPosition(szInstrumentId);
}

QUANTBOX_API void __stdcall TD_ReqQryInvestorPositionDetail(const char *szInstrumentId)
{
	CCTPTdApi::instance()->ReqQryInvestorPositionDetail(NULL==szInstrumentId?"":szInstrumentId);
}

QUANTBOX_API void __stdcall TD_ReqQryInstrument(const char *szInstrumentId)
{
	CCTPTdApi::instance()->ReqQryInstrument(szInstrumentId);
}

QUANTBOX_API void __stdcall TD_ReqQryInstrumentCommissionRate(const char *szInstrumentId)
{
	CCTPTdApi::instance()->ReqQryInstrumentCommissionRate(szInstrumentId);
}

QUANTBOX_API void __stdcall TD_ReqQryInstrumentMarginRate(const char *szInstrumentId, TThostFtdcHedgeFlagType HedgeFlag)
{
	CCTPTdApi::instance()->ReqQryInstrumentMarginRate(szInstrumentId,HedgeFlag);
}

QUANTBOX_API void __stdcall TD_ReqQrySettlementInfo(const char *szTradingDay)
{
	CCTPTdApi::instance()->ReqQrySettlementInfo(szTradingDay);
}

//��ί��
QUANTBOX_API void __stdcall TD_ReqQryOrder(const char *szInstrumentId)
{
	CCTPTdApi::instance()->ReqQryOrder(szInstrumentId);
}

//��ɽ�
QUANTBOX_API void __stdcall TD_ReqQryTrade(const char *szInstrumentId)
{
	CCTPTdApi::instance()->ReqQryTrade(szInstrumentId);
}

QUANTBOX_API void __stdcall TD_Disconnect()
{
	CCTPTdApi::instance()->Disconnect();
}
