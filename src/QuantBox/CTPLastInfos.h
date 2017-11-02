#ifndef _CTP_LAST_INFOS_H_
#define _CTP_LAST_INFOS_H_

#include <mutex>
#include <condition_variable>
#include <map>
#include <list>
#include <vector>
#include <string>

#include "CTP/ThostFtdcUserApiStruct.h"

struct wdLimitPrice;
struct wdTick;
struct wdKLine;
struct wdTradingAccount;
struct wdInstrument;

///��¼CTP�����е���������ͽ�����Ϣ
class wdCTPLastInfos
{
public:
	// �����û�===================================================================================
	static wdCTPLastInfos *instance();	

	// ��ȡĳ����Լ�����µ�һЩTick����
	wdTick GetLastTick(const char *Instrument, bool isHistory = false);
	void GetLastTick(const char *Instrument, int Num, std::vector<wdTick> &vecLastTicks, bool isHistory = false);

	// ��ȡĳ����Լ��ĳ��period�����µ�һЩK��
	wdKLine GetLastKLine(const char *Instrument, const char *period, bool isHistory = false);
	void GetLastKLine(const char *Instrument, const char *period, int Num, std::vector<wdKLine> &vecLastKLines, bool isHistory = false);


	// ��ȡ�˺���Ϣ ��Ŀǰ���ǻ�ȡ���˺���Ϣ��
	wdTradingAccount GetTradingAccount(const char *szAccountID);


	// �ڲ�ʹ��===================================================================================
	void _AddLastTick(const wdTick &tick, bool isHistory = false);
	
	void AddPeriods(const std::list<std::string> &listInstrumentIDs, const std::list<std::string> &listPeriod, bool isHistory = false);
	// ������ĵ�periodȫ����������򷵻�true
	bool RemovePeriods(const std::list<std::string> &listInstrumentIDs, const std::list<std::string> &listPeriod);
	void _AddLastKLine(const wdKLine &kline, bool isHistory = false);
	void _Output_OnRtnDepthMarketData(wdTick &tick);
	std::map<std::string, wdKLine> &GetHistoryPeriod_KLine(const char *szInstrumentID) { return m_mapHistoryInstKLine[szInstrumentID]; }


	void UpdateTradingAccount(const CThostFtdcTradingAccountField *pTradingAccount);

	//bool isCZCE(const std::string &szInstrumentID); // �ж�ĳ����Լ�Ƿ�����֣����

private:
	wdCTPLastInfos(void);
	~wdCTPLastInfos(void);

	bool _ReadConfigFile();

	//////////////////////////////////////////////////////////////////////////	����
	// ʵʱ
	std::mutex													m_mutexLastTick;
	std::map<std::string, std::vector<wdTick> >					m_vecTicks;					// �洢�����Tick���ݣ�keyΪ��Լ
	std::map<std::string, std::map<std::string, wdKLine> >		m_mapInstKLine;				// ���ĵĵ�ʵʱ����K�� keyΪ��Լ   value��keyΪperiod��
	std::mutex																m_mutexKLine;
	std::map<std::string, std::map<std::string, std::vector<wdKLine> > >	m_mapInstVecKLine;//�洢�����K��

	// ��ʷ
	std::mutex													m_mutexHistoryLastTick;
	std::map<std::string, std::vector<wdTick> >					m_vecHistoryTicks;			// �洢��ʷTick���ݣ�keyΪ��Լ
	std::map<std::string, std::map<std::string, wdKLine> >		m_mapHistoryInstKLine;		// ���ĵ���ʷ����K��
	std::mutex																m_mutexHistoryKLine;
	std::map<std::string, std::map<std::string, std::vector<wdKLine> > >	m_mapHistoryInstVecKLine;//�洢�����K��


	//////////////////////////////////////////////////////////////////////////	����

	std::map<std::string, wdTradingAccount>						m_mapTradingAccount;		// keyΪ�ʽ��˻�

	std::vector<std::vector<std::string> >						m_vecInstrumentAssemble;	// ��Լ��������
};

#endif // _CTP_LAST_INFOS_H_