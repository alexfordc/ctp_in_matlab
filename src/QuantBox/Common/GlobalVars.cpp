
#include <string>
#include "CTP/ThostFtdcUserApiStruct.h"
#include "logger.h"
#include "Types.h"
#include "Enums.h"
#include "GlobalVars.h"
#include "defines.h"

CThostFtdcRspUserLoginField			g_RspUserLogin = {0};
wdTradeType							g_tradeType = E_Simulate;
my_severity_level					g_severityLevel = normal;
std::string							g_trader_no = "00";

// ����
std::string							g_mdAddress = "";
std::string							g_mdBrokerID = "";
std::string							g_mdInstrumentAssemble = "";
// ����
std::string							g_tdAddress = "";
std::string							g_tdBrokerID = "";
std::string							g_tdInvestorId = "";		//Ͷ����ID
std::string							g_tdPassword = "";			//����
std::string							g_tdUserProductInfo = "";	//��Ʒ��Ϣ
std::string							g_tdAuthCode = "";			//��֤��
THOST_TE_RESUME_TYPE				g_resumeType = THOST_TERT_QUICK;

// ���ݿ�
std::string							g_Database = "";			// ���ݿ�洢�ļ���
QUANTBOX_API std::string			g_mdDBPath = "";
QUANTBOX_API std::string			g_tdDBPath = "";
QUANTBOX_API const char				*g_Table_Order = "T_Order";
QUANTBOX_API const char				*g_Table_Trade = "T_Trade";
QUANTBOX_API const char				*g_Table_Position = "T_Position";

std::string							g_mysqlHost = "";
std::string							g_mysqlUser = "";
std::string							g_mysqlPassword = "";

fnOnConnect							g_fnOnMdConnect = nullptr;

fnOnTick							g_fnOnRtnDepthMarketData_Tick = nullptr;
fnOnKLine							g_fnOnRtnDepthMarketData_KLine = nullptr;
fnOnTick							g_fnOnHistory_Tick = nullptr;
fnOnKLine							g_fnOnHistory_KLine = nullptr;

fnOnPosition						g_fnOnRspQryInvestorPosition = nullptr;
fnOnOrder							g_fnOnRspQryOrder = nullptr;
fnOnTrade							g_fnOnRspQryTrade = nullptr;

fnOnSettlementInfo					g_fnOnRspQrySettlementInfo = nullptr;
fnOnTradingAccount					g_fnOnTradingAccount = nullptr;
fnOnInstrument						g_fnOnRspQryInstrument = nullptr;

fnOnError							g_fnOnMdRspError = nullptr;