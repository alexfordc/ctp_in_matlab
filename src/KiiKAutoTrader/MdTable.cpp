#include "MdTable.h"
using namespace std;

MdTable::MdTable()
{
	this->setColumnCount(7);
	//���ñ�ͷ���� 
	QStringList header;
	header << QStringLiteral("��Լ����") << QStringLiteral("��Լ��") << QStringLiteral("���¼�") << QStringLiteral("���") << QStringLiteral("����") << QStringLiteral("����") <<
		QStringLiteral("����");
	this->setHorizontalHeaderLabels(header);
	//���ò��ɱ༭
	this->setEditTriggers(QAbstractItemView::NoEditTriggers);

	//���ö�ʱ��
	updateTimer = new QTimer(this);
	connect(updateTimer, SIGNAL(timeout()), this, SLOT(refreshTable()));
	unsubUpdateTimer = new QTimer(this);
	unsubUpdateTimer->setSingleShot(true);
	connect(unsubUpdateTimer, SIGNAL(timeout()), this, SLOT(updateTableForUnsub()));
}

//�Ͽ����Ӻ��ʼ�����
void MdTable::resetTable(){
	updateTimer->stop();
	this->clearContents();	//����������
	//ע������һ����ǰɾ��
	int i = instruInTable.size();
	for (; i >= 0; i--){
		this->removeRow(i);
	}
	instruInTable.clear();
}

//ˢ�±��
void MdTable::refreshTable()
{
	
}

//��Ϊ�û�ѡ��������б�,����newInstru���û��ڶԻ�����ѡ���Լ�󴫹���
void MdTable::updateTableForSelect(set<QString>& newInstru)
{
	updateTimer->stop();   //ֹͣ���±��
	for (auto iter = instruInTable.begin(); iter != instruInTable.end();){
		if (newInstru.find(*iter) == newInstru.end()){	//ȥ����Ҫ�ĺ�Լ
			iter = instruInTable.erase(iter);
		}
		else
		{
			iter++;
		}
	}
	for (auto iter = newInstru.begin(); iter != newInstru.end(); iter++){
		auto i = instruInTable.begin();
		for (; i != instruInTable.end(); i++){
			if ((*i) == (*iter)){
				break;
			}
		}
		if (i == instruInTable.end()){ //����½����ĺ�Լ
			instruInTable.push_back((*iter));
		}
	}
	
	//������ʾ�ı��
	this->clearContents();
	int rowCount = this->rowCount();
	for (; rowCount >= 0; rowCount--){
		this->removeRow(rowCount);
	}
	int row = 0;
	for (auto iter = instruInTable.begin(); iter != instruInTable.end(); iter++){
		
		row++;
	}
	this->update();
	updateTimer->start(1000);
}

//�˶����1.5�����
void MdTable::callUnsubUpdateTimer(){
	unsubUpdateTimer->start(1500);
}

//��Ϊ�û��˶��������б�
void MdTable::updateTableForUnsub(){
	
}