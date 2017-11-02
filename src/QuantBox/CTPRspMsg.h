#ifndef _CTP_RSP_MSG_H_
#define _CTP_RSP_MSG_H_

#include <string>
#include <map>

enum E_CTPRspMsgType;
struct wdConnectInfo;
struct wdKLine;
struct wdTick;
struct wdOrder;
struct wdTradeTicket;
struct wdPosition;
struct wdInstrument;

// CTP���ص���Ϣ����
enum E_CTPRspMsgType
{
	E_fnOnConnectInfo,			// ����

	E_fnOnTick,			
	E_fnOnKLine,

	E_fnOnOrder,	
	E_fnOnTrade,
	E_fnOnPosition,

	E_fnOnInstrument,			// ��Լ��Ϣ(������Լ״̬����֤��������)
	E_fnOnSettlementInfo,		// ������Ϣ
	E_fnOnTradingAccount,		// �ʽ�	

	E_fnOnError,				// ������Ϣ
};

// CTP��Ӧ��Ϣ���ݽṹ
class CCTPRspMsgItem
{
	E_CTPRspMsgType				m_type;			// ��Ϣ����
	union {
		wdConnectInfo			*ConnectInfo;	// ������Ϣ	
		wdTick					*Tick;			// tick		
		wdKLine					*KLine;			// kline	
		wdOrder					*Order;
		wdTradeTicket			*TradeTicket;
		wdPosition				*Position;
		std::map<std::string, wdInstrument> *InstrumentInfo;
		std::string				*SettlementInfo;// ����
		std::string				*RspError;		// ������Ϣ
	};

public:
	CCTPRspMsgItem(E_CTPRspMsgType type, void *pMsgItem);
	~CCTPRspMsgItem();

	E_CTPRspMsgType get_type() const { return m_type; }
	std::string *get_settlement_info() { return SettlementInfo; }
	std::string *get_error() { return RspError; }
	operator wdConnectInfo*() { return ConnectInfo; }
	operator wdTick*() { return Tick; }
	operator wdKLine*() { return KLine; }
	operator wdOrder*() { return Order; }
	operator wdTradeTicket*() { return TradeTicket; }
	operator wdPosition*() { return Position; }
	operator std::map<std::string, wdInstrument> *() { return InstrumentInfo; }

private:
	CCTPRspMsgItem();
};

#endif