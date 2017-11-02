#include "CTPMdSpi.h"
#include "CTP\ThostFtdcUserApiStruct.h"
#include "GVAR.h"
#include <qdebug.h>
#include <qdatetime.h>
#include <mutex>
using std::shared_ptr;
using std::make_shared;
using std::set;
using std::map;
using std::make_pair;
using std::once_flag;

//��¼�����յĵط�ִֻ��һ��
once_flag ONCEFLAG;


CTPMdSpi::CTPMdSpi(shared_ptr<CTPMdApi> api){
	ctpMdApi = api;
}

CTPMdSpi::~CTPMdSpi(){
	qDebug() << "~CTPMdSpi";
}

//���ͻ����뽻�׺�̨������ͨ������ʱ����δ��¼ǰ�����÷���������
void CTPMdSpi::OnFrontConnected(){
	ctpMdApi->setConnect();
	ctpMdApi->login();		//���ӳɹ������ϵ�½
}

///��¼������Ӧ
void CTPMdSpi::OnRspUserLogin(CThostFtdcRspUserLoginField *pRspUserLogin,
	CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast){
	if (pRspInfo->ErrorID == 0){
		qDebug() << "��¼�ɹ�";
		emit loginSuccess();	//���͵�¼�ɹ��ź�
	}
	else{
		qDebug() << "��¼ʧ��:" << pRspInfo->ErrorID << " " << pRspInfo->ErrorMsg;
	}

}

//����ر���Ӧ
void CTPMdSpi::OnRtnDepthMarketData(CThostFtdcDepthMarketDataField *pDepthMarketData){
	QString &td = tradeDate;
	std::call_once(ONCEFLAG, [&td, &pDepthMarketData](){ td = QString(pDepthMarketData->TradingDay); });
	//��Լ�����Ǻ�Լ���� (�磺cu1409)
	QString instruName(pDepthMarketData->InstrumentID);
	if (instruSet.find(instruName) == instruSet.end()){	//�������ڼ��ϵ���
		//˵���յ���ĳ���ĺ�Լ�����ݣ�Ϊ�ú�Լ��ʼ����¼��
		auto recorder = make_shared<Recorder>(instruName);
		recorder->record(pDepthMarketData);	//��¼����
		instruSet.insert(instruName);		//����set������
		recorderMapping.insert(make_pair(instruName, recorder));	//����map������
	}
	else{
		recorderMapping[instruName]->record(pDepthMarketData);	//�����ҵ���¼�����Ұ������¼
	}
	//����ȫ�ֱ����ĺ�Լ��Ϣ
	QString code(pDepthMarketData->InstrumentID);
	instruList[code].update(pDepthMarketData);
}

//ȡ����������Ӧ��
void CTPMdSpi::OnRspUnSubMarketData(CThostFtdcSpecificInstrumentField *pSpecificwdTick,
	CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast){
	if (pRspInfo->ErrorID == 0){
		QString instruName(pSpecificwdTick->InstrumentID);
		updateSetMap(instruName);
		qDebug() << "�˶�������Ӧ";
	}
}

//api�˶���������spi
void CTPMdSpi::updateSetMap(QString instruName){
	auto iter = instruSet.find(instruName);
	if (iter == instruSet.end()){
		return;
	}
	else{
		//�˶���Լ�󲻻����յ���Լ����Ϣ����˼�¼��Լ�Ķ�������
		//�Ѻ�Լ��set��map����ȥ��
		instruSet.erase(instruName);
		recorderMapping.erase(instruName);
	}
}

//�ͷ���Դ,��������api�ж�spi������
void CTPMdSpi::release(){
	ctpMdApi = nullptr;
	for (auto iter = recorderMapping.begin(); iter != recorderMapping.end(); iter++){
		(*iter).second->release();
	}
}