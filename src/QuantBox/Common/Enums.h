#ifndef _ENUMS_H_
#define _ENUMS_H_

/*! �������ͷ��� */
enum wdTradeType
{
	E_Simulate,				/*!< ģ���� */ 
	E_Actual				/*!< ʵ�� */ 
};

/*! ϵͳ���ͷ��� */
enum wdSystemType 
{
	E_RealtimeMarketData,	/*!< ʵʱ���� */  
	E_HistoryMarketData,	/*!< ��ʷ���� */  
	E_TradeData				/*!< ���ײ��� */  
};

/*! �������� */
enum wdOrderType
{
	E_Limit,				/*!< �޼۵� */ 
	E_Market,				/*!< �м۵� */ 
	E_Contingent,			/*!< ������ */ 
	E_Trash					/*!< �ϵ� */ 
};



#endif