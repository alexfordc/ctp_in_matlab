#ifndef _TOOLKIT_H_
#define _TOOLKIT_H_

#include <sstream>
#include <vector>
#include <list>
#include <set>
#include <string>
#include "logger.h"
#include "Types.h"
#include "CTP\ThostFtdcUserApiStruct.h"



//����OnFrontDisconnected(int nReason)��ֵ���ϴ�����Ϣ
void GetOnFrontDisconnectedMsg(CThostFtdcRspInfoField* pRspInfo);


bool isStrNULL(const char *str);
bool isStdStrNULL(const std::string &str);


// �Ƿ���ñ���
bool IsAvailableOrder(const CThostFtdcOrderField *pOrder);
// �Ƿ��������б���
bool IsAllOrder(const CThostFtdcOrderField *pOrder);


std::string GetTickExchangeTime(const CThostFtdcDepthMarketDataField *pDepthMarketData);

std::string GetTickLocalTime();

// ��ȡ��ǰ�� ʱ:��:��
std::string GetLocalTime();

int GetSeconds(std::string period);

int GetTimeNum(const std::string &time);

std::string GetKLineExchangeTime(const wdTick &tick, int period);

// �ж�K��ʱ���Ƿ��ڽ���ʱ���� 
// �н���:		09:14:00~11:31:00 13:00:00~15:16:00
// ����֣���Ϻ�:	08:59:00~10:16:00 10:30:00~11:31:00 13:30:00~15:01:00
bool IsInTradeTime_Check_KLine(const std::string &Instrument_ID, const std::string &KLine_Time);

#endif