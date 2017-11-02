#ifndef _SQLITE_BASE_H_
#define _SQLITE_BASE_H_


#include <list>
#include <string>
#include "Types.h"
struct sqlite3;

class SQLiteBase
{
public:
	SQLiteBase(void);
	virtual ~SQLiteBase(void);

	// SQLite���ݿ��ʼ��
	virtual bool SQLite_Init(void);

	// SQLite���ݿ� �ر�
	virtual void SQLite_Finalize() {};

	// MD���� =======================================================================================
	virtual void SQLite_MarketData_Insert(const wdTick &tick) {}
	virtual void SubscribeHistory(const std::list<std::string> &listInstrumentIDs, const std::list<std::string> &listPeriod, const char *beginTime, const char *endTime) {}

	// TD���� =======================================================================================
	virtual bool SQLite_Insert_TradingAccount(const CThostFtdcTradingAccountField &pTradingAccount) {return true;}
	virtual bool SQLite_Insert_InvestorPosition(const CThostFtdcInvestorPositionField &pInvestorPosition) {return true;}
	virtual bool SQLite_Insert_Order(const CThostFtdcOrderField &pOrder){return true;}
	virtual bool SQLite_Insert_Trade(const CThostFtdcTradeField &pTrade){return true;}
	

	virtual bool SQLite_Insert_AvailableOrder(const CThostFtdcOrderField &pAvailableOrder){return true;}
	virtual bool SQLite_DeletE_AvailableOrdersOrder(const CThostFtdcOrderField &pAvailableOrder){return true;}
	virtual bool SQLite_DeletE_AvailableOrdersOrder(const CThostFtdcTradeField &pTrade){return true;}
	virtual bool CancelOrder(void *pTd, const char *Instrument = nullptr,  char Direction = 0, const char *wdConnectionStatus = nullptr) {return true;}
protected:
	bool SQLite_EXEC(const char *SQL, fnOnQuerySQLite cb = nullptr, void *p = nullptr);
	// �ж�ĳ����¼�Ƿ����
	bool SQLite_Item_Exist(const char *SQL);
	// ��¼����SQLiteʱ�Ĵ������
	void SQLite_Error_Log(int res, const char *SQL, const char *errMsg);

protected:
	sqlite3						*m_sqlite3;


	char localTime_Mil[20];							// ��ǰʱ�� ���뼶 �� 09:46:55.123 
	char tradeDay[10];								// ��ǰ�������� ��2014-01-14
	/*************** ʱ�䴦����غ��� **************************************************************************/

	// ����ʱ���뽻����ʱ��ͬ��
	void Time_sync(CThostFtdcRspUserLoginField *pRspUserLogin);

	// ��ȡ���׵�ǰ��������
	char* Get_TradingDay();

	// ��ȡ���׵�ǰ����ʱ�� �� 09:55:34
	char* Get_localTime_Sec();

	// ��ȡ���غ��뼶ʱ�� �緵��123 ��ʾ��ǰΪ�����123
	int Get_LocalTime_Millisec();

	// ��ȡ����ʱ�������
	int Get_LocalTime_Second();

	// ΢���ʱ num��ʾ΢��
	void Delay(int num);
};

#endif