#include "OnekeySubsribeController.h"
#include "GVAR.h"
#include <qmessagebox.h>
using std::shared_ptr;

OnekeySubsribeController::OnekeySubsribeController(){
	receiver = nullptr;
}

void OnekeySubsribeController::setReceiver(shared_ptr<Receiver> r){
	receiver = r;
}

//�ָ���ʼ״̬
void OnekeySubsribeController::reset(){
	receiver = nullptr;
}

//һ������
void OnekeySubsribeController::onekeySubscribe(){
	int count = onekeyInstru.size();
	if (count == 0){
		QMessageBox::information(0, QStringLiteral("��ʾ"), QStringLiteral("һ�����ĺ�Լ�б�Ϊ��"));
		return;
	}
	char* *ppwdTickID = new char*[count];
	for (int i = 0; i < count; i++){
		ppwdTickID[i] = new char[7];
		strcpy(ppwdTickID[i], onekeyInstru.at(i).toStdString().c_str());
	}
	receiver->subscribeData(ppwdTickID, count);
	QMessageBox::information(0, QStringLiteral("��ʾ"), QStringLiteral("���ĳɹ�"));
}