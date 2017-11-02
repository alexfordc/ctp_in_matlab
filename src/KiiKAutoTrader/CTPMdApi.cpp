#include "GVAR.h"
#include "CTPMdApi.h"
#include <qdebug.h>
#include <string>
using std::string;
using std::shared_ptr;
using std::vector;



CTPMdApi::CTPMdApi(){
	m_pApi = CThostFtdcMdApi::CreateFtdcMdApi("./ctp_temp_file/");
	connectFlag = false;
}

CTPMdApi::~CTPMdApi(){
	qDebug() << "m_pApi->Release()";
	if (m_pApi != nullptr){
		m_pApi->RegisterSpi(NULL);
		m_pApi->Release();
		m_pApi = NULL;
		instruSet.clear();	//����Ѷ��ĵ��б�
	}
}

/************************************public����**************************************************************/

void CTPMdApi::registerSpi(shared_ptr<CThostFtdcMdSpi> spi){
	ctpMdSpi = spi;
	m_pApi->RegisterSpi(ctpMdSpi.get());
}

void CTPMdApi::login(){
	if (NULL == m_pApi)
		return;
	CThostFtdcReqUserLoginField loginField = {0};
	strncpy(loginField.BrokerID, "666666", sizeof(TThostFtdcBrokerIDType));
	int res = m_pApi->ReqUserLogin(&loginField, 1);
}

void CTPMdApi::release(){
	m_pApi->Release();
	m_pApi = nullptr;
}

int CTPMdApi::subscribeData(char *ppwdTickID[], int nCount){
	return m_pApi->SubscribeMarketData(ppwdTickID, nCount);
}

int CTPMdApi::unsubscribeData(char *ppwdTickID[], int nCount){
	return m_pApi->UnSubscribeMarketData(ppwdTickID, nCount);
}

bool CTPMdApi::isConnect(){
	return connectFlag;
}

void CTPMdApi::setConnect(){
	connectFlag = true;
}

//ע��ǰ�û�����ʼ��Api
void CTPMdApi::connectServer(){
	//ע��ǰ�û�
	char address[100];
	strcpy(address, FRONT_ADDRESS.toStdString().c_str());
	m_pApi->RegisterFront(address);
	//��ʼ��Api
	m_pApi->Init();
}

