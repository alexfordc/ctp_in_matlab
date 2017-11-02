#ifndef _TYPES_H_
#define _TYPES_H_

#include <map>
#include <functional>

#ifdef QUANTBOX_EXPORTS
#define QUANTBOX_API __declspec(dllexport)
#else
#define QUANTBOX_API __declspec(dllimport)
#endif


struct wdTick;
struct wdKLine;
struct wdConnectInfo;
struct wdInstrument;
struct wdTradingAccount;
struct wdOrder;
struct wdPosition;
struct wdTradeTicket;

///����or����
enum wdConnectType { E_MD, E_TD };

/*! ����״̬ö�� */
enum wdConnectionStatus
{
	E_uninit,		//δ��ʼ��
	E_inited,		//�Ѿ���ʼ��
	E_unconnected,	//�����Ѿ��Ͽ�
	E_connecting,	//������
	E_connected,	//���ӳɹ�
	E_authing,		//5.��Ȩ��
	E_authed,		//��Ȩ�ɹ�
	E_logining,		//��¼��
	E_logined,		//��¼�ɹ�
	E_confirming,	//���㵥ȷ����
	E_confirmed,	//10.�Ѿ�ȷ��
	E_conn_max		//���ֵ
};

/*! �������� */
enum wdDirectionType
{
	E_Direction_Default = -1, // ���ֲ֣���
	E_Buy,			/*!< �� */ 
	E_Sell,			/*!< �� */ 
};

/*! ��ƽ��־���� 
 *	������������ֺͽ��: ƽ���THOST_FTDC_OFEN_Close; ƽ���THOST_FTDC_OFEN_CloseToday
 *	������������������ֺͽ��: THOST_FTDC_OFEN_Close
 */
enum wdOffsetFlagType
{
	E_OffsetFlag_Default = -1,
	E_Open,			/*!< ���� */ 
	E_Close,		/*!< ������ƽ��֡�����������ƽ�� */ 
	E_CloseToday	/*!< ������ƽ��� */ 
};

/*! �������� */
enum wdHedgeFlagType
{
	E_Speculation,	/*!< Ͷ�� */ 
	E_Arbitrage,	/*!< ���� */ 
	E_Hedge			/*!< ��ֵ */ 
};

///����״̬ [����E_PartTradedNotQueueing E_AllTraded E_Canceled ������ɳ���]
enum wdOrderStatus
{
	E_InsertSubmitted,			//�����ѷ�
	E_CancelSubmitted,			//�����ѷ�
	E_PartTradedQueueing,		//���ֳɽ�(�ɳ�)
	E_PartTradedNotQueueing,	//���ֳɽ�(���ɳ�)
	E_AllTraded,				//ȫ��
	E_Canceled,					//ȫ��
	E_WaitTrade,				//�ȴ��ɽ�(�ɳ�)
	E_Unknown,					//δ֪	
	E_InsertTrash,				//����ʧ��
	E_CancelTrash,				//����ʧ��
};

/*! �������������� */
enum wdContingentConditionType
{
	///����
	E_Immediately,
	///ֹ��
    E_Touch,
	///ֹӮ
    E_TouchProfit,
	///Ԥ��
    E_ParkedOrder,
	///���¼۴���������
    E_LastPriceGreaterThanStopPrice,
	///���¼۴��ڵ���������
    E_LastPriceGreaterEqualStopPrice,
	///���¼�С��������
    E_LastPriceLesserThanStopPrice,
	///���¼�С�ڵ���������
    E_LastPriceLesserEqualStopPrice,
	///��һ�۴���������
    E_AskPriceGreaterThanStopPrice,
	///��һ�۴��ڵ���������
    E_AskPriceGreaterEqualStopPrice,
	///��һ��С��������
    E_AskPriceLesserThanStopPrice,
	///��һ��С�ڵ���������
    E_AskPriceLesserEqualStopPrice,
	///��һ�۴���������
    E_BidPriceGreaterThanStopPrice,
	///��һ�۴��ڵ���������
    E_BidPriceGreaterEqualStopPrice,
	///��һ��С��������
    E_BidPriceLesserThanStopPrice,
	///��һ��С�ڵ���������
    E_BidPriceLesserEqualStopPrice
};

#define CPP_FUNCTIONAL
#ifndef CPP_FUNCTIONAL
	//! ���ӡ��Ͽ�����Ӧ
	typedef void(__stdcall *fnOnConnect)(wdConnectInfo *);	

	//! Tick���ݵ��������Ļص�����
	typedef void(__stdcall *fnOnTick)(wdTick *pTick);
	//! K�����ݵ��������Ļص�����
	typedef void(__stdcall *fnOnKLine)(wdKLine *pKLine);

	//! �������ݵ��������Ļص�����
	typedef void(__stdcall *fnOnPosition)(wdPosition *);
	typedef void(__stdcall *fnOnOrder)(wdOrder *);
	typedef void(__stdcall *fnOnTrade)(wdTradeTicket *);
	
	typedef void(__stdcall *fnOnSettlementInfo)(const char *);
	typedef void(__stdcall *fnOnTradingAccount)(wdTradingAccount *);	
	typedef void(__stdcall *fnOnInstrument)(std::map<std::string, wdInstrument> *);	

	//! ������Ϣ
	typedef void(__stdcall *fnOnError)(const char *);

#else

	//! ���ӡ��Ͽ�����Ӧ
	typedef std::function<void (wdConnectInfo *)> fnOnConnect;

	//! Tick���ݵ��������Ļص�����
	typedef std::function<void (wdTick *)> fnOnTick;
	//! K�����ݵ��������Ļص�����
	typedef std::function<void (wdKLine *)> fnOnKLine;

	//! �������ݵ��������Ļص�����
	typedef std::function<void (wdPosition *)> fnOnPosition;	 
	typedef std::function<void (wdOrder *)> fnOnOrder;	 
	typedef std::function<void (wdTradeTicket *)> fnOnTrade;	 	 
		
	typedef std::function<void (const char *)> fnOnSettlementInfo;	
	typedef std::function<void (wdTradingAccount *)> fnOnTradingAccount;	 
	typedef std::function<void (std::map<std::string, wdInstrument> *)> fnOnInstrument;	 

	//! ������Ϣ
	typedef std::function<void (const char *)> fnOnError;

#endif // !CPP_FUNCTIONAL

	/** ��ѯSQlite���ݿ�Ļص����� */
	typedef int (*fnOnQuerySQLite)(void*, int,char**, char**);

#endif