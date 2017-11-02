#include "MainWindow.h"
#include <qtablewidget.h>
#include <qboxlayout.h>
#include <qdatetime.h>
#include <QTextCodec>
#include <qstring.h>
#include <qstatusbar.h>
#include <qmessagebox.h>
#include <qmenubar.h>
#include <qfiledialog.h>
#include "MdTable.h"
#include "MarketDataController.h"
#include "TradeController.h"
#include "SelectShowMdWindow.h"
#include "SubscribingDialog.h"
#include "QuantBoxApi.h"

using namespace std;

static QTextCodec *s_codec = QTextCodec::codecForName("GB18030");
static const char *s_ConnectionStatus[] =
{
	"δ��ʼ��",
	"�Ѿ���ʼ��",
	"�����Ѿ��Ͽ�",
	"������",
	"���ӳɹ�",
	"��Ȩ��",
	"��Ȩ�ɹ�",
	"��¼��",
	"��¼�ɹ�",
	"���㵥ȷ����",
	"�Ѿ�ȷ��",
	"���ֵ"
};

MainWindow::MainWindow(QWidget *parent) 
	: QMainWindow(parent)
	, sMdWindow(nullptr) 
	, subDialog(nullptr)
{
	//��ʼ�����ӡ��Ͽ���ť
	connectMdButton = new QPushButton(QStringLiteral("��������"));
	connectTdButton = new QPushButton(QStringLiteral("���ӽ���"));
	
	//��ʼ�����ġ��˶�����
	subscribeInstruments = new QLineEdit();
	subscribeInstruments->setEnabled(false);
	subscribePeriods = new QLineEdit;
	subscribePeriods->setEnabled(false);
	subscribeButton = new QPushButton(QStringLiteral("��������"));
	subscribeButton->setEnabled(false);

	unsubscribeInstruments = new QLineEdit();
	unsubscribeInstruments->setEnabled(false);
	unsubscribePeriods = new QLineEdit;
	unsubscribePeriods->setEnabled(false);
	unsubscribeButton = new QPushButton(QStringLiteral("�˶�����"));
	unsubscribeButton->setEnabled(false);

	// ����/�˶���������
	//�����������㡱�Ĳ���
	QHBoxLayout *top1 = new QHBoxLayout();
	top1->addWidget(new QLabel(QStringLiteral("��Լ����:")));
	subscribeInstruments->setFixedSize(345, 25);
	subscribePeriods->setFixedSize(300, 25);
	top1->addWidget(subscribeInstruments);
	top1->addWidget(new QLabel(QStringLiteral("����:")));
	top1->addWidget(subscribePeriods);
	top1->addWidget(subscribeButton);
	QHBoxLayout *top2 = new QHBoxLayout();
	top2->addWidget(new QLabel(QStringLiteral("��Լ����:")));
	unsubscribeInstruments->setFixedSize(345, 25);
	unsubscribePeriods->setFixedSize(300, 25);
	top2->addWidget(unsubscribeInstruments);
	top2->addWidget(new QLabel(QStringLiteral("����:")));
	top2->addWidget(unsubscribePeriods);
	top2->addWidget(unsubscribeButton);
	QVBoxLayout *top = new QVBoxLayout();
	top->addLayout(top1);
	top->addLayout(top2);

	//���ñ��
	table = new MdTable();
	QVBoxLayout *conLayout = new QVBoxLayout();
	conLayout->addStretch();
	conLayout->addWidget(connectMdButton);
	conLayout->addWidget(connectTdButton);
	QHBoxLayout *down = new QHBoxLayout();		//�·��Ĳ����ɱ������Ӱ�ť��һ�����
	down->addWidget(table);
	down->addLayout(conLayout);
	down->setAlignment(Qt::AlignTop);

	QVBoxLayout *mainLayout = new QVBoxLayout();
	mainLayout->addLayout(top);
	mainLayout->addLayout(down);

	QWidget *mainW = new QWidget();
	mainW->setLayout(mainLayout);
	setCentralWidget(mainW);

	createStatusBur();	//����״̬��
	createMenu();		//�����˵���
	initController();

	//���ô�������
	setWindowTitle(QStringLiteral("��������"));
}

/************************************˽�к���*******************************************************/

//��ʼ��������
void MainWindow::initController()
{
	m_mdController = make_shared<MarketDataController>();
	//���Ӱ�ť�����ӿ���������
	connect(connectMdButton, SIGNAL(clicked()), m_mdController.get(), SLOT(connectMdServer()));
	connect(subscribeButton, SIGNAL(clicked()), m_mdController.get(), SLOT(subscribe()));
	connect(unsubscribeButton, SIGNAL(clicked()), m_mdController.get(), SLOT(unsubscribe()));
	//���ӿ�������״̬������
	connect(m_mdController.get(), &MarketDataController::md_tick, this, &MainWindow::Md_Tick, Qt::BlockingQueuedConnection);
	connect(m_mdController.get(), &MarketDataController::md_kline, this, &MainWindow::Md_KLine, Qt::BlockingQueuedConnection);

	//����
	m_tdController = make_shared<TradeController>();
	connect(connectTdButton, SIGNAL(clicked()), m_tdController.get(), SLOT(connectTdServer()));

	connect(m_tdController.get(), &TradeController::connect_status, this, &MainWindow::ConnectStatus, Qt::BlockingQueuedConnection);
}

//����״̬��
void MainWindow::createStatusBur()
{
	//����ʱ���ǩ
	timerForUpdateTimeLabel = new QTimer(this);
	connect(timerForUpdateTimeLabel, SIGNAL(timeout()), this, SLOT(updateTime()));
	timerForUpdateTimeLabel->start(1000);
	localTimeLabel = new QLabel(QStringLiteral(""));
	statusBar()->addPermanentWidget(localTimeLabel);
	for (int i = 0; i < 5; ++i) {
		ExchangeTimeLabel[i] = new QLabel(QStringLiteral(""));
		statusBar()->addPermanentWidget(ExchangeTimeLabel[i]);
	}
	
	//��ʼ��״̬��ǩ
	MdStatusLabel = new QLabel(s_codec->toUnicode(s_ConnectionStatus[E_uninit]));
	statusBar()->addWidget(new QLabel(QStringLiteral("����״̬:")));
	statusBar()->addWidget(MdStatusLabel);
	TdStatusLabel = new QLabel(s_codec->toUnicode(s_ConnectionStatus[E_uninit]));
	statusBar()->addWidget(new QLabel(QStringLiteral("����״̬:")));
	statusBar()->addWidget(TdStatusLabel);
}

//�����˵���
void MainWindow::createMenu()
{
	//ѡ��˵�
	selectMenu = menuBar()->addMenu(QStringLiteral("ѡ��"));
	selectShowMd = new QAction(QStringLiteral("չʾ��Լ"), this);
	connect(selectShowMd, SIGNAL(triggered()), this, SLOT(showSelectMdWindow()));
	writeToDB = new QAction(QStringLiteral("д�����ݿ�"), this);
	connect(writeToDB, SIGNAL(triggered()), this, SLOT(selectFileForWriter()));
	selectMenu->addAction(selectShowMd);
	selectMenu->addAction(writeToDB);
	//�鿴�˵�
	checkMenu = menuBar()->addMenu(QStringLiteral("�鿴"));
	showSubscribingAction = new QAction(QStringLiteral("���ڶ���"), this);
	connect(showSubscribingAction, SIGNAL(triggered()), this, SLOT(showSubscribing()));
	checkMenu->addAction(showSubscribingAction);
}

/************************************�ۺ���*********************************************************/

//ʱ�̸��±���ʱ��
void MainWindow::updateTime()
{
	static const char *s_ExchangeTime[] =
	{
		"������ʱ��: ",
		"������ʱ��: ",
		"֣����ʱ��: ",
		"�н���ʱ��: ",
		"��Դ����ʱ��: "
	};
	const int *diffSec = m_tdController->get_differenceSeconds();
	QTime localTime = QTime::currentTime();
	localTimeLabel->setText(QStringLiteral("����ʱ��: ") + localTime.toString("hh:mm:ss"));
	for (int i = 0; i < 5; ++i) {
		if (diffSec[i] != INVALID_DIFF_SECONDS) {
			QTime time = localTime.addSecs(diffSec[i]);
			QString timeStr = time.toString("hh:mm:ss");
			ExchangeTimeLabel[i]->setText(s_codec->toUnicode(s_ExchangeTime[i]) + timeStr);
		}
		else {
			ExchangeTimeLabel[i]->setText(s_codec->toUnicode(s_ExchangeTime[i]) + "--:--:--");
		}
	}
}

void MainWindow::Md_Tick(wdTick *pTick)
{

}

void MainWindow::Md_KLine(wdKLine *pKLine)
{

}

void MainWindow::ConnectStatus(wdConnectInfo *info)
{
	if (info->type == E_MD) {
		MdStatusLabel->setText(s_codec->toUnicode(s_ConnectionStatus[info->status]));

		if (info->status == E_logined) { //���ӳɹ���ʹ�ö��ĺ��˶���ִ��				
			//������صĴ��ڲ���
			subscribeButton->setEnabled(true);
			subscribeInstruments->setEnabled(true);
			subscribePeriods->setEnabled(true);
			unsubscribeButton->setEnabled(true);
			unsubscribeInstruments->setEnabled(true);	
			unsubscribePeriods->setEnabled(true);

			////���ö���/�˶�������		
			m_mdController->setSubTextLine(subscribeInstruments);
			m_mdController->setUnsubTextLine(unsubscribeInstruments);		
		}
		else if (info->status == E_unconnected) {
			QMessageBox::information(this, QStringLiteral("��������ǰ��ʧ��"), info->ErrorMsg);
			return;
		}
	}
	else {
		TdStatusLabel->setText(s_codec->toUnicode(s_ConnectionStatus[info->status]));

		if (info->status == E_unconnected) {
			QMessageBox::information(this, QStringLiteral("���ӽ���ǰ��ʧ��"), info->ErrorMsg);
			return;
		}
	}
}



//�Ͽ�����,��ʼ����api��صĿ�����
//֪ͨ�ѱ���������
//void MainWindow::disconnect(){
//	//�ø��������ָ�ԭ��״̬��ʹ�ú�̨api�Զ�����
//	m_tdController->reset();
//	unsubController->reset();
//	m_mdController->reset();
//	onekeySubController->reset();
//	//������ز���
//	subscribeButton->setEnabled(false);
//	subscribeInstruments->clear();
//	subscribeInstruments->setEnabled(false);
//	unsubscribeButton->setEnabled(false);
//	unsubscribeInstruments->clear();
//	unsubscribeInstruments->setEnabled(false);
//	disconnectButton->setEnabled(false);
//	//�����ӿ���������
//	connectButton->setEnabled(true);
//	//�޸�״̬����ʾ
//	statusLabel->setText(OFFLINE);
//	//������
//	table->resetTable();
//	//���Ѷ��ĵ��б����
//	if (sMdWindow != nullptr){
//		sMdWindow->clearShowedInstru();
//	}
//}

//չʾ�Ի�����ʹ����ѡ����ʾ�ĺ�Լ
void MainWindow::showSelectMdWindow(){
	if (sMdWindow == nullptr){
		sMdWindow = new SelectShowMdWindow();
		connect(sMdWindow, SIGNAL(showChange(std::set<QString>&)), table, SLOT(updateTableForSelect(std::set<QString>&)));
		connect(unsubscribeButton, SIGNAL(clicked()), table, SLOT(callUnsubUpdateTimer()));
	}
	sMdWindow->showDialog();
}

//չʾ�Ի�����ʹ����ѡ���ļ�д�����ݿ�
void MainWindow::selectFileForWriter(){
	/*if (m_mdController->isConnect() == true){
		QMessageBox::information(this, QStringLiteral("����"), QStringLiteral("��Ͽ������ٲ���"));
		return;
	}
	else{
		QStringList filenames = QFileDialog::getOpenFileNames(this,QStringLiteral("ѡ�������¼"),"./data","��¼�ļ� (*.csv)");
		if (filenames.isEmpty()){
			return;
		}
		else{
			dbWriterController->readyToWrite(filenames);
		}
	}*/
}

//չʾ���ڶ��ĵĺ�Լ
void MainWindow::showSubscribing(){
	if (subDialog == nullptr){
		subDialog = new SubscribingDialog();
		subDialog->show();
	}
	else{
		subDialog->showDialog();
	}
}
