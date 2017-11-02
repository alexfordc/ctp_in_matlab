#ifndef _CTP_TD_API_
#define _CTP_TD_API_


#include <time.h>
#include <thread>
#include <set>
#include <list>
#include <map>
#include <string>
#include <queue>
#include <mutex>
#include <memory>
#include "CTP/ThostFtdcTraderApi.h"
#include "CTPCommonApi.h"
#include "defines.h"
#include "Types.h"

enum wdOrderType;
enum E_CTPReqType;
class CCTPReqMsgItem;
class CMyThreads;
struct wdLimitPrice;
struct wdOrderKey;
struct wdOrder;
struct wdPositionKey;
struct wdPosition;

/*! ���׽ӿ� */
class CCTPTdApi : public CThostFtdcTraderSpi, CCTPCommonApi
{
public:
	static CCTPTdApi *instance();

	void Connect();
	void Disconnect();

	/*!	\brief ����-�޼�
		\param Instrument ��Լ��
		\param Price �۸�
		\param Volume ����
		\param Direction ��������
		\param OffsetFlag ��ƽ��־
	*/
	void SendLimitOrder(const char *Instrument, double Price, int Volume, wdDirectionType Direction, wdOffsetFlagType OffsetFlag);
	/*!	\brief ����-�м�
		\param Instrument ��Լ��
		\param Volume ����
		\param Direction ��������
		\param OffsetFlag ��ƽ��־
	*/
	void TD_SendMarketOrder(const char *Instrument, int Volume, wdDirectionType Direction, wdOffsetFlagType OffsetFlag);
	/*!	\brief ����-������
		\param Instrument ��Լ��
		\param Price �۸�
		\param Volume ����
		\param Direction ��������
		\param OffsetFlag ��ƽ��־
		\param ContingentCondition ��������
		\param StopPrice ֹ���
	*/
	void TD_SendContingentOrder(const char *Instrument, double Price, int Volume, wdDirectionType Direction, wdOffsetFlagType OffsetFlag, wdContingentConditionType ContingentCondition, double StopPrice);
	
	/*!	\brief ����
		\param Instrument ��Լ��
		\param Direction ��������
		\param OffsetFlag ��ƽ��־
	*/
	void CancelOrder(const char *Instrument, wdDirectionType Direction = E_Direction_Default, wdOffsetFlagType OffsetFlag = E_OffsetFlag_Default);
	void CancelOrder(wdOrder &);
	

	///��ѯ���㵥
	void ReqQrySettlementInfo(const char *szTradingDay);
	///�����ѯ����
	void ReqQryOrder(const char *InstrumentID = nullptr);
	///�����ѯ�ɽ�
	void ReqQryTrade(const char *InstrumentID = nullptr);
	///��ֲ�
	void ReqQryInvestorPosition(const char *szInstrumentId = nullptr);
	//��ֲ���ϸ
	void ReqQryInvestorPositionDetail(const char *szInstrumentId = nullptr);

	///���ʽ�
	void ReqQryTradingAccount();
	///���Լ
	void ReqQryInstrument(const char *szInstrumentId = nullptr);	
	///�������� ����Լ��ѯ����Ʒ����Ӧ
	void ReqQryInstrumentCommissionRate(const char *szInstrumentId = nullptr);
	///�鱣֤�� ֻ�ܰ���Լ��ѯ
	void ReqQryInstrumentMarginRate(const char *szInstrumentId = nullptr, TThostFtdcHedgeFlagType HedgeFlag = THOST_FTDC_HF_Speculation);

	std::string GetAllInstruments();
	int GetVolumeMultiple(const std::string &inst);

private:
	CCTPTdApi(void);
	virtual ~CCTPTdApi(void);

	void _RunInThread(); //���ݰ������߳�
	void InputReqQueue(const std::shared_ptr<CCTPReqMsgItem> &);

	void ReqAuthenticate();
	///�û���¼����
	void ReqUserLogin();

	///��ѯ����ͻ����㵥ȷ��������޼�¼���ر�ʾ������δȷ�Ͻ��㵥
	void ReqQrySettlementInfoConfirm();
	///ȷ�Ͻ��㵥
	void ReqSettlementInfoConfirm();

	//����
	virtual void OnFrontConnected();
	virtual void OnFrontDisconnected(int nReason);
	void OnFrontDisconnected(wdConnectionStatus status, const char *szReason);

	//��֤
	virtual void OnRspAuthenticate(CThostFtdcRspAuthenticateField *pRspAuthenticateField, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
	virtual void OnRspUserLogin(CThostFtdcRspUserLoginField *pRspUserLogin, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
	virtual void OnRspQrySettlementInfo(CThostFtdcSettlementInfoField *pSettlementInfo, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
	virtual void OnRspQrySettlementInfoConfirm(CThostFtdcSettlementInfoConfirmField *pSettlementInfoConfirm, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
	virtual void OnRspSettlementInfoConfirm(CThostFtdcSettlementInfoConfirmField *pSettlementInfoConfirm, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);

	//Thost�յ�����ָ����û��ͨ���������飬�ܾ����ܴ˱���
	virtual void OnRspOrderInsert(CThostFtdcInputOrderField *pInputOrder, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
	//�������յ���������Ϊ��������
	virtual void OnErrRtnOrderInsert(CThostFtdcInputOrderField *pInputOrder, CThostFtdcRspInfoField *pRspInfo);

	//����
	//Thost�յ�����ָ����û��ͨ���������飬�ܾ����ܳ���ָ��
	virtual void OnRspOrderAction(CThostFtdcInputOrderActionField *pInputOrderAction, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
	//��������Ϊ��������
	virtual void OnErrRtnOrderAction(CThostFtdcOrderActionField *pOrderAction, CThostFtdcRspInfoField *pRspInfo);	
	
	//ί��
	virtual void OnRspQryOrder(CThostFtdcOrderField *pOrder, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
	virtual void OnRtnOrder(CThostFtdcOrderField *pOrder);
	//�ɽ�
	virtual void OnRspQryTrade(CThostFtdcTradeField *pTrade, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
	virtual void OnRtnTrade(CThostFtdcTradeField *pTrade);

	//����¼��
	virtual void OnRspQuoteInsert(CThostFtdcInputQuoteField *pInputQuote, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
	virtual void OnErrRtnQuoteInsert(CThostFtdcInputQuoteField *pInputQuote, CThostFtdcRspInfoField *pRspInfo);
	virtual void OnRtnQuote(CThostFtdcQuoteField *pQuote);
	
	//���۳���
	virtual void OnRspQuoteAction(CThostFtdcInputQuoteActionField *pInputQuoteAction, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
	virtual void OnErrRtnQuoteAction(CThostFtdcQuoteActionField *pQuoteAction, CThostFtdcRspInfoField *pRspInfo);

	//��λ
	virtual void OnRspQryInvestorPosition(CThostFtdcInvestorPositionField *pInvestorPosition, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
	virtual void OnRspQryInvestorPositionDetail(CThostFtdcInvestorPositionDetailField *pInvestorPositionDetail, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
	virtual void OnRspQryInvestorPositionCombineDetail(CThostFtdcInvestorPositionCombineDetailField *pInvestorPositionCombineDetail, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {};

	//�ʽ�
	virtual void OnRspQryTradingAccount(CThostFtdcTradingAccountField *pTradingAccount, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
	
	//��Լ
	virtual void OnRspQryInstrument(CThostFtdcInstrumentField *pInstrument, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
	//��֤�� ֻ�ܰ���Լ��ѯ
	virtual void OnRspQryInstrumentMarginRate(CThostFtdcInstrumentMarginRateField *pInstrumentMarginRate, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
	//������ ����Լ��ѯ����Ʒ����Ӧ
	virtual void OnRspQryInstrumentCommissionRate(CThostFtdcInstrumentCommissionRateField *pInstrumentCommissionRate, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
	//֪ͨ������״̬�仯
	virtual void OnRtnInstrumentStatus(CThostFtdcInstrumentStatusField *pInstrumentStatus);


	///��ѯ���顣��ȡȫ����Լ���б��Լ�ȫ����Լ���ǵ�ͣ��
	void ReqQryDepthMarketData();
	///������Ӧ
	virtual void OnRspQryDepthMarketData(CThostFtdcDepthMarketDataField *pDepthMarketData, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);

	//����
	virtual bool Checking();
	void DoSthOnBeginning(CThostFtdcSettlementInfoConfirmField *pSettlementInfoConfirm, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);

	bool IsErrorRspInfo(CThostFtdcRspInfoField *pRspInfo, int nRequestID = UNIQUE_REQUEST_ID, bool bIsLast = true);
	virtual void OnRspError(CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
	
	bool _IsMyOrder(TThostFtdcOrderRefType OrderRef);
	void _ReqOrderInsert(CThostFtdcInputOrderField *pInputOrder, wdOrderType);

	/*! \brief ��������:���𡢼���޸ġ�������Ŀǰֻ֧�ֳ��� */
	//int _ReqOrderAction(CThostFtdcInputOrderActionField *orderAction);
	
	int ReqQuoteInsert(
		int QuoteRef,
		const char *szInstrumentId,
		TThostFtdcPriceType	AskPrice,
		TThostFtdcPriceType	BidPrice,
		TThostFtdcVolumeType AskVolume,
		TThostFtdcVolumeType BidVolume,
		TThostFtdcOffsetFlagType AskOffsetFlag,
		TThostFtdcOffsetFlagType BidOffsetFlag,
		TThostFtdcHedgeFlagType	AskHedgeFlag,
		TThostFtdcHedgeFlagType	BidHedgeFlag
		);
	int ReqQuoteAction(CThostFtdcQuoteField *pQuote);

private:
	CThostFtdcTraderApi								*m_pApi;				//����API	

	std::atomic<unsigned int>						m_nMaxOrderRef;			//�������ã��������ֱ�������������

	int												m_nSleep;
	std::mutex										m_reqMutex;
	std::condition_variable							m_reqConditionVariable;
	std::queue<std::shared_ptr<CCTPReqMsgItem> >	m_reqQueue;
	std::map<E_CTPReqType, bool>					m_mapUniqueReq;			// ����ظ�������
	std::shared_ptr<CMyThreads>						m_pReqThreads;

	// ��������============
	std::map<std::string, std::string>				m_mapSettlementInfo;	// ������->������Ϣ
	
	std::map<wdOrderKey, wdOrder>					m_mapOrders;
	std::map<wdPositionKey, wdPosition>				m_mapPositions;

	std::mutex										m_mutexInstruments;
	std::map<std::string, wdInstrument>				m_Instruments;			// ��Լӳ���,keyΪ��Լ
	std::condition_variable							m_cv_Instruments;
};

#endif