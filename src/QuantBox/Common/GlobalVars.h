#ifndef _GLOBAL_VARS_H_
#define _GLOBAL_VARS_H_

extern CThostFtdcRspUserLoginField			g_RspUserLogin;			//���صĵ�¼�ɹ���Ӧ��Ŀǰ���ô��ڳ�Ա���б�����������

extern wdTradeType							g_tradeType;
extern my_severity_level					g_severityLevel;
extern std::string							g_trader_no;			//�����"00",������֧�ַ��˻�;�������˺ŵ�ֵ�ķ�Χ��"01"~"99"								

// ����
extern std::string							g_mdAddress;
extern std::string							g_mdBrokerID;
extern std::string							g_mdInstrumentAssemble;	//��Լ����ϡ�ÿ�����֮���÷ֺ�";"����������ڵĺ�Լ�ö���","����
// ����
extern std::string							g_tdAddress;
extern std::string							g_tdBrokerID;
extern std::string							g_tdInvestorId;			//Ͷ����ID
extern std::string							g_tdPassword;			//����
extern std::string							g_tdUserProductInfo;	//��Ʒ��Ϣ
extern std::string							g_tdAuthCode;			//��֤��
extern THOST_TE_RESUME_TYPE					g_resumeType;
//���ݿ�
extern std::string							g_Database;
QUANTBOX_API extern std::string				g_mdDBPath;
QUANTBOX_API extern std::string				g_tdDBPath;
QUANTBOX_API extern const char				*g_Table_Order;
QUANTBOX_API extern const char				*g_Table_Trade ;
QUANTBOX_API extern const char				*g_Table_Position ;
// mysql
extern std::string							g_mysqlHost;
extern std::string							g_mysqlUser;
extern std::string							g_mysqlPassword;

 
extern fnOnConnect							g_fnOnMdConnect;

extern fnOnTick								g_fnOnRtnDepthMarketData_Tick;
extern fnOnKLine							g_fnOnRtnDepthMarketData_KLine;
extern fnOnTick								g_fnOnHistory_Tick;
extern fnOnKLine							g_fnOnHistory_KLine;

extern fnOnPosition							g_fnOnRspQryInvestorPosition;
extern fnOnOrder							g_fnOnRspQryOrder;
extern fnOnTrade							g_fnOnRspQryTrade;

extern fnOnSettlementInfo					g_fnOnRspQrySettlementInfo;
extern fnOnTradingAccount					g_fnOnTradingAccount;
extern fnOnInstrument						g_fnOnRspQryInstrument;

extern fnOnError							g_fnOnMdRspError;

#endif // !_GLOBAL_VARS_H_


