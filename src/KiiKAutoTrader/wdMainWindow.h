#ifndef WDMAINWINDOW_H
#define WDMAINWINDOW_H

#include <memory>
#include <vector>
#include <qmainwindow.h>
#include <qlabel.h>
#include "ui_wdMainWindow.h"
#include "TradeData.h"

enum wdConnectionStatus;
class TradeController;
class SelectShowMdWindow;
class SubscribingDialog;
class MarketDataController;
class MdTable;
struct wdTick;
struct wdKLine;

class wdMainWindow : public QMainWindow, public Ui_MainWindow
{
	Q_OBJECT

public:
	wdMainWindow(QWidget *parent = 0);
	~wdMainWindow() {};

private:
	void createStatusBur();

	//��ʼ�����ӿ�����
	void initController();

private slots:

	//��timerForUpdateTimeLabel�����Ĳۺ���
	void updateTime();				//ÿ��һ�����ʱ��

	void Md_Tick(int, wdTick *);
	void Md_KLine(int, wdKLine *);

	void ConnectStatus(wdConnectInfo *info);
	void OnError(const char *);
	void InstrumentsRsp(const std::map<std::string, wdInstrument> *);
	void OrderRsp(int, const wdOrder &);
	void TradeRsp(const wdTradeTicket *);
	void PositionRsp(int ,const wdPosition &);

private:
	//״̬���Ŀؼ������
	QLabel *MdStatusLabel;
	QLabel *TdStatusLabel;
	/*///������ʱ��
	QLabel *SHFETime;
	///������ʱ��
	QLabel *DCETime;
	///֣����ʱ��
	QLabel *CZCETime;
	///�н���ʱ��
	QLabel *FFEXTime;
	///��Դ����ʱ��
	QLabel *INETime;*/
	///����ʱ��
	QLabel *localTimeLabel;
	// ����������������֣�������н�������Դ���ĵ�ʱ��
	QLabel *ExchangeTimeLabel[5];
	QTimer *timerForUpdateTimeLabel;
	

	//�Ի���  ��3�������ǲ���static ��
	SelectShowMdWindow *sMdWindow;
	SubscribingDialog *subDialog;


	//������
	std::shared_ptr<MarketDataController> m_mdController;
	std::shared_ptr<TradeController> m_tdController;
};

#endif // WDMAINWINDOW_H
