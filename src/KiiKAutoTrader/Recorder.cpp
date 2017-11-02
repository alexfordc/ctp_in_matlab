#include "Recorder.h"
#include <qdebug.h>

//��¼�������־��Ǻ�Լ�����֣��ļ���������ʽΪ���ڼ��Ϻ�Լ���֣���20140718cu1408
Recorder::Recorder(QString name){
	recorderName = name;
	file.setFileName(QString("data/") + recorderName + ".csv");
	//������׷�ӵķ�ʽ���ļ�
	if (!file.open(QIODevice::ReadWrite | QIODevice::Text | QIODevice::Append)){
		qDebug() << file.fileName() << " open fail";
		abort();
	}
	recorder.setDevice(&file);
}

Recorder::~Recorder(){
	qDebug() << "~Recorder";
}

//��¼����
void Recorder::record(CThostFtdcDepthMarketDataField *data){
	if (recorder.status() == QTextStream::Ok){
		recorder << data->UpdateTime << ","			//����޸�ʱ��
			<< data->UpdateMillisec << ","			//����޸ĺ���
			<< data->LastPrice << ","				//���¼�
			<< data->HighestPrice << ","				//��߼�
			<< data->LowestPrice << ","				//��ͼ�
			<< data->BidPrice1 << ","				//�����һ
			<< data->BidVolume1 << ","				//������һ
			<< data->AskPrice1 << ","				//������һ
			<< data->AskVolume1 << ","				//������һ
			<< data->Volume << ","					//��ǰ�ɽ���
			<< data->OpenInterest << ","				//�ֲ���
			<< data->Turnover << ","					//�ɽ����
			<< data->ClosePrice << ","				//�������̼�
			<< data->AveragePrice << ","			//���վ���
	/****************���������ÿ��ʱ�̶���ͬ�������ÿһ�첻ͬ**************************/
			<< data->OpenPrice << ","				//���տ��̼�
			<< data->UpperLimitPrice << ","			//��ͣ��
			<< data->LowerLimitPrice << ","			//��ͣ��
			<< data->PreClosePrice << ","			//�����̼�
			<< data->PreOpenInterest << ","			//��ֲ���
			<< data->PreSettlementPrice << "\n";		//������

		recorder.flush();
	}
	else{
		qDebug() << file.fileName() << " recorder error!!";
	}
}

//�ͷ���Դ
void Recorder::release(){
	file.close();
}