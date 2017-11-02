#pragma once

#include "ctp\ThostFtdcMdApi.h"
#include <qobject.h>
#include <qstring.h>
#include <memory>
#include <vector>

//ʹ��CTP�ṩ�Ľӿ�ʵ��������������api
class CTPMdApi :public QObject{
	Q_OBJECT
public:
	CTPMdApi();
	~CTPMdApi();
	void registerSpi(std::shared_ptr<CThostFtdcMdSpi> spi);					//ע��ص��ӿ�
	void login();															//��½
	void release();															//�ͷŽӿ�
	int subscribeData(char *ppwdTickID[], int nCount);					//��������
	int unsubscribeData(char *ppwdTickID[], int nCount);				//�˶�����
	//����api��״̬
	bool isConnect();
	//����api��״̬��apiһ����ʼ�������������Ͳ��ٶϿ������һ����ʼ������״̬���ž�Ϊ���Ҳ���
	void setConnect();
	//ע��ǰ�û�����ʼ��Api,�ú�����Ҫͨ���̼߳�ӵ��ã�������ֱ�ӵ���
	void connectServer();
private:
	CThostFtdcMdApi *m_pApi;
	std::shared_ptr<CThostFtdcMdSpi> ctpMdSpi;
	//���Ӻ͵�½״̬��
	bool connectFlag;
};

