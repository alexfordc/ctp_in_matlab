#include "UnsubscribeController.h"
#include <qstringlist.h>
#include "QuantBoxApi.h"

UnsubscribeController::UnsubscribeController() {}

void UnsubscribeController::unsubscribe(){
	//���ı����ȡ����
	QString &instruments = source->text();
	MD_Unsubscribe(instruments.toStdString().c_str());
	//��������
	source->clear();
}