#ifndef _TRADE_CONTROLLER_H_
#define _TRADE_CONTROLLER_H_

#include <vector>
#include <qobject.h>
#include <QMap>
#include <QSqlDatabase>

enum wdConnectionStatus;
class wdMainWindow;
#include "TradeData.h"

#define INVALID_DIFF_SECONDS 9999

class TradeController : public QObject
{
	Q_OBJECT
public:
	TradeController(wdMainWindow &);
	virtual ~TradeController();

	const int *get_differenceSeconds() const { return m_differenceSeconds; }

private:
	void OnConnect(wdConnectInfo *info);
	void OnError(const char *);
	void OnInstrument(std::map<std::string, wdInstrument> *);
	void OnOrder(wdOrder *);
	void OnTrade(wdTradeTicket *);
	void OnPosition(wdPosition *);

	// ����������������֣�������н�������Դ���ĵ�ʱ�䣬�뱾��ʱ����������
	int m_differenceSeconds[5];
	QSqlDatabase db;

	QMap<wdOrderKey, int> m_mapOrder_No;
	QMap<wdOrderKey, wdOrder> m_mapOrders;

	QMap<wdPositionKey, int> m_mapPosition_No;
	QMap<wdPositionKey, wdPosition> m_mapPositions;

	wdMainWindow &m_ui;

	QMap<int, const wdOrder*>		m_mapNo_Order;		//�ڼ��У���ʾ�ĸ���Լ
	QMap<int, const wdPosition*>	m_mapNo_Position;	//�ڼ��У���ʾ���ĸ��ֲ�
	QMap<std::string, std::string>	m_mapInst_Exe;		//��Լ��Ӧ�Ľ�����

public slots:
	void connectTdServer();
	void SendOrder(int = -1, int = -1); // ���֡�ƽ��
	void CancelOrder(int, int); // ����
	

signals:
	void connect_status(wdConnectInfo *info);	
	void error_msg(const char *);
	void instruments_rsp(const std::map<std::string, wdInstrument> *);
	void order_rsp(int, const wdOrder &);
	void trade_rsp(const wdTradeTicket *);
	void position_rsp(int, const wdPosition &);
};

#endif // !_TRADE_CONTROLLER_H_