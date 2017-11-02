#ifndef _MD_TABLE_H_
#define _MD_TABLE_H_

#include <qobject.h>
#include <qtablewidget.h>
#include <qtimer.h>
#include <vector>
#include <map>
#include <set>
#include <qstring.h>

class MdTable : public QTableWidget
{
	Q_OBJECT
public:
	MdTable();
	void resetTable();		//�Ͽ����Ӻ��ʼ�����
private:
	QTimer *updateTimer;			//�Զ�ˢ�¼�ʱ��
	QTimer *unsubUpdateTimer;		//�˶����¼�ʱ��
	std::vector<QString> instruInTable;		//��table����ʾ�ĺ�Լ,�к���vector�еĲ���˳����ͬ
private slots:
	void refreshTable();	//ˢ���б�
	void updateTableForUnsub();									//��Ϊ�û��˶��������б�
public slots:
	void updateTableForSelect(std::set<QString>& newInstru);	//��Ϊ�û�ѡ��������б�
	void callUnsubUpdateTimer();								//�˶������֪ͨ�˶����¼�ʱ��
};

#endif