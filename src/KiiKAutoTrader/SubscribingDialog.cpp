#include "SubscribingDialog.h"
#include <qlayout.h>


SubscribingDialog::SubscribingDialog()
{
	setWindowTitle(QStringLiteral("���ڶ��ĵ�����"));
	textArea = new QTextEdit(this);
	textArea->setFixedWidth(350);
	textArea->setReadOnly(true);
	okButton = new QPushButton(QStringLiteral("ȷ��"));
	okButton->setFixedSize(okButton->sizeHint().width(), okButton->sizeHint().height());
	connect(okButton, SIGNAL(clicked()), this, SLOT(hide()));
	QVBoxLayout *layout = new QVBoxLayout();
	layout->addWidget(textArea);
	layout->addWidget(okButton);
	layout->setAlignment(Qt::AlignHCenter);
	setLayout(layout);
	setModal(true);
	update();
	hide();
}

//չʾ�Ի���
void SubscribingDialog::showDialog()
{
	update();
	show();
}