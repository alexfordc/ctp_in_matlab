#ifndef _MAIN_WINDOW_H_
#define _MAIN_WINDOW_H_

//��������
#include <qobject.h>
#include <qmainwindow.h>
#include <qpushbutton.h>
#include <qlabel.h>
#include <qtimer.h>
#include <qlineedit.h>
#include <memory>
#include <qaction.h>
#include <qmenu.h>

enum wdConnectionStatus;
class TradeController;
class SelectShowMdWindow;
class SubscribingDialog;
class MarketDataController;
class MdTable;
struct wdTick;
struct wdConnectInfo;
struct wdKLine;

class MainWindow : public QMainWindow
{
	Q_OBJECT
public:
	MainWindow(QWidget *parent = 0);
private:
	void createStatusBur();
	void createMenu();
	//��ʼ�����ӿ�����
	void initController();
private slots:
	//��timerForUpdateTimeLabel�����Ĳۺ���
	void updateTime();				//ÿ��һ�����ʱ��

	void Md_Tick(wdTick *pTick);
	void Md_KLine(wdKLine *pKLine);

	void ConnectStatus(wdConnectInfo *info);

	//��disconnectButton�����Ĳۺ���
	//void disconnect();				//�Ͽ�����,��ʼ����api��صĿ�����
									//֪ͨ�ѱ���������

	//��selectShowMd���������Ĳۺ���
	void showSelectMdWindow();		//չʾ�Ի�����ʹ����ѡ����ʾ�ĺ�Լ

	//��writeToDB���������Ĳۺ���
	void selectFileForWriter();		//չʾ�Ի�����ʹ����ѡ���ļ�д�����ݿ�

	//��showSubscribingAction���������Ĳۺ���
	void showSubscribing();			//չʾ���ڶ��ĵĺ�Լ�ĶԻ���


private:
	//��ť�������
	QPushButton *connectMdButton;		//������
	QPushButton *connectTdButton;		//������
	QLineEdit *subscribeInstruments;	//�������������
	QLineEdit *subscribePeriods;		//���ĵ�����,Ĭ��tick
	QPushButton *subscribeButton;		//�������鰴ť
	QLineEdit *unsubscribeInstruments;	//�˶����������
	QLineEdit *unsubscribePeriods;		//�˶�������,Ĭ���˶�����
	QPushButton *unsubscribeButton;		//�˶����鰴ť
	//QPushButton *disconnectMdButton;	//�Ͽ�����
	//QPushButton *disconnectTdButton;	//�Ͽ�����

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

	//���
	MdTable *table;

	//�˵���
	QMenu *selectMenu;
	QMenu *checkMenu;
	QMenu *editMenu;

	//����
	QAction *selectShowMd;
	QAction *writeToDB;
	QAction *showSubscribingAction;
	QAction *editOnekeyAction;

	//������
	std::shared_ptr<MarketDataController> m_mdController;
	std::shared_ptr<TradeController> m_tdController;
};

#endif