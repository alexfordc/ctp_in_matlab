#include "DBwriter.h"
#include "GVAR.h"
#include <qmessagebox.h>
#include <qsqlquery.h>
#include <qfile.h>
#include <qtextstream.h>
#include <qdebug.h>


DBwriter* DBwriter::writer = nullptr;

//����ģʽ
DBwriter *DBwriter::getInstance(){
	if (writer == nullptr){
		writer = new DBwriter();
		return writer;
	}
	else
	{
		return writer;
	}
}

DBwriter::DBwriter(){
	db = QSqlDatabase::addDatabase(DB_DRIVER_NAME);
	db.setHostName(DB_HOST_NAME);
	db.setDatabaseName(DATABASE_NAME);
	db.setUserName(USER_NAME);
	db.setPassword(PASSWORD);
	if (!db.open()){
		QMessageBox::information(0, QStringLiteral("���ݿ����"), QStringLiteral("�޷������ݿ�"));
		abort();
	}
	//������ݿ��еı���
	QSqlQuery query(db);
	query.exec("show tables");
	while (query.next()){
		QString tableName = query.value(0).toString();
		tables.insert(tableName);
	}
}

//д�����ݿ�⵱��
void DBwriter::processFile(QString filename){
	QFile file(filename);
	if (!file.open(QIODevice::ReadOnly | QIODevice::Text)){
		QMessageBox::information(0, QStringLiteral("����"), QStringLiteral("��") + filename + QStringLiteral("ʱ��������"));
		abort();
	}
	//��ô�����ļ���
	QStringList list = filename.split("/");
	QString pureFileName = list.at(list.size() - 1);
	//���ļ����н����õ����ݿ������ֺͽ�������
	QString date = "";
	int i = 0;
	for (; i < 8; i++){
		date.append(pureFileName[i]);
	}
	QString tableName = "";
	for (; i < pureFileName.length(); i++){
		if (pureFileName[i] == '.')
			break;
		tableName.append(pureFileName[i]);
	}
	//������ݿ����Ƿ������ű����û�е�������,һ����Լ��Ӧ���ű�
	if (tables.find(tableName) == tables.end()){
		QMessageBox::information(0, QStringLiteral("����"), QStringLiteral("���ݿ���û��") + tableName + QStringLiteral("��"));
		abort();
	}
	QString tableName_day = tableName + "_day";
	if (tables.find(tableName_day) == tables.end()){
		QMessageBox::information(0, QStringLiteral("����"), QStringLiteral("���ݿ���û��") + tableName_day + QStringLiteral("��"));
		abort();
	}
	//���ͨ����ʼд������
	QTextStream in(&file);
	//��cu1409Ϊ��
	//д��cu1409������
	QSqlQuery insert;
	insert.prepare("insert into " + tableName + " values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
	//д��cu1409_day�����
	QSqlQuery insert_day;
	insert_day.prepare("insert into " + tableName_day + " values (?,?,?,?,?,?,?)");
	QString line;
	QStringList l;
	while (!in.atEnd()){
		line = in.readLine();
		l = line.split(",");
		//������ת������
		QString t = l.at(0);
		int ms = l.at(1).toInt();
		double LastPrice = l.at(2).toDouble();
		double HighestPrice = l.at(3).toDouble();
		double LowestPrice = l.at(4).toDouble();
		double BidPrice1 = l.at(5).toDouble();
		int BidVolume1 = l.at(6).toInt();
		double AskPrice1 = l.at(7).toDouble();
		int AskVolume1 = l.at(8).toInt();
		int Volume = l.at(9).toInt();
		int OpenInterest = l.at(10).toInt();
		double Turnover = l.at(11).toDouble();
		double ClosePrice = l.at(12).toDouble();
		double AveragePrice = l.at(13).toDouble();
		//�󶨲�ѯ
		insert.bindValue(0, date);
		insert.bindValue(1, t);
		insert.bindValue(2, ms);
		insert.bindValue(3, LastPrice);
		insert.bindValue(4, HighestPrice);
		insert.bindValue(5, LowestPrice);
		insert.bindValue(6, BidPrice1);
		insert.bindValue(7, BidVolume1);
		insert.bindValue(8, AskPrice1);
		insert.bindValue(9, AskVolume1);
		insert.bindValue(10, Volume);
		insert.bindValue(11, OpenInterest);
		insert.bindValue(12, Turnover);
		insert.bindValue(13, ClosePrice);
		insert.bindValue(14, AveragePrice);
		//ִ�����
		bool result = insert.exec();
		qDebug() << result;
	}
	/*******************ֻ��дһ�ε�***********************/
	double OpenPrice = l.at(14).toDouble();
	double UpperLimitPrice = l.at(15).toDouble();
	double LowerLimitPrice = l.at(16).toDouble();
	double PreClosePrice = l.at(17).toDouble();
	double PreOpenInterest = l.at(18).toDouble();
	double PreSettlementPrice = l.at(19).toDouble();
	insert_day.bindValue(0, date);
	insert_day.bindValue(1, OpenPrice);
	insert_day.bindValue(2, UpperLimitPrice);
	insert_day.bindValue(3, LowerLimitPrice);
	insert_day.bindValue(4, PreClosePrice);
	insert_day.bindValue(5, PreOpenInterest);
	insert_day.bindValue(6, PreSettlementPrice);
	bool result2 = insert_day.exec();
	qDebug() << result2;

	//д���Ժ����ݱ�����log��־��
	QFile logFile("log/persistence.log");
	if (!logFile.open(QIODevice::ReadWrite | QIODevice::Text | QIODevice::Append)){
		QMessageBox::information(0, QStringLiteral("����"), QStringLiteral("��persistence.logʱ��������"));
		abort();
	}
	QTextStream out(&logFile);
	out << filename << "\n";
	out.flush();
	logFile.close();
	file.close();
}