#ifndef _UNSUBSCRIBE_CONTROLLER_H_
#define _UNSUBSCRIBE_CONTROLLER_H_

#include <qobject.h>
#include <memory>
#include <qlineedit.h>
#include "Receiver.h"

class UnsubscribeController : public QObject
{
	Q_OBJECT
public:
	UnsubscribeController();
	//������֮��ص��ı��ı������
	void setTextLine(QLineEdit* s) { source = s; }

public slots:
	void unsubscribe();
private:
	QLineEdit* source;
};

#endif