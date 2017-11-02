#include "SelectShowMdWindow.h"
#include <cmath>
#include <qmessagebox.h>
#include <qlayout.h>


SelectShowMdWindow::SelectShowMdWindow()
{
	setWindowTitle(QStringLiteral("ѡ��Ҫ��ʾ�ĺ�Լ"));
	QVBoxLayout *mainLayout = new QVBoxLayout();
	//������Լ�б�,��ʼ����ѡ��
	//for (auto iter = instruList.begin(); iter != instruList.end(); iter++){
	//	QCheckBox *checkItem = new QCheckBox((*iter).first, this);	//����ÿ����ѡ�������Ϊ��Լ����
	//	checkItem->setEnabled(false);
	//	instruCheckBox.push_back(checkItem);
	//}
	//20����ѡ�����һ�У��ٰ�ÿ�з���һ��
	int layoutNum = ceil(instruCheckBox.size()/5.0);
	QHBoxLayout **hLayouts = new QHBoxLayout*[layoutNum];
	//��ʼ��ÿһ���в��ֲ��Ѹ�ѡ�����
	for (int i = 0; i < layoutNum; i++){
		hLayouts[i] = new QHBoxLayout;
	}
	int rowNum = 0;	// rowNum/20�õ�����,rowNum����
	for (auto iter = instruCheckBox.begin(); iter != instruCheckBox.end(); iter++){
		int row = rowNum / 20;
		hLayouts[row]->addWidget((*iter));
		rowNum++;
	}
	//��ÿ���в��ַ����ܲ���
	for (int i = 0; i < layoutNum; i++){
		mainLayout->addLayout(hLayouts[i]);
	}
	//��ʼ����ť
	okButton = new QPushButton(QStringLiteral("ȷ��"));
	cancelButton = new QPushButton(QStringLiteral("ȡ��"));
	okButton->setFixedSize(okButton->sizeHint().width(), okButton->sizeHint().height());
	cancelButton->setFixedSize(cancelButton->sizeHint().width(), cancelButton->sizeHint().height());
	QHBoxLayout *buttonLayout = new QHBoxLayout();
	buttonLayout->addWidget(okButton);
	buttonLayout->addWidget(cancelButton);
	mainLayout->addLayout(buttonLayout);
	mainLayout->setAlignment(Qt::AlignRight);
	connect(cancelButton, SIGNAL(clicked()), this, SLOT(hide()));
	connect(okButton, SIGNAL(clicked()), this, SLOT(pushOkButton()));
	setLayout(mainLayout);
	setModal(true);	//����Ϊģ̬
	hide();
}

//��ʾ�ô��ڣ��û�ѡ����ʾ��Լʱ����
void SelectShowMdWindow::showDialog(){
	if (1/*instruSet.empty()*/){
		QMessageBox::information(this, " ", QStringLiteral("����ѡ���Լ�����������"));
		hide();
	}
	else
	{
		//1.��ȫ��ѡ���ʼ��Ϊ����ѡ��ûѡ
		//2.���Ѿ����ĵ�����ĸ�ѡ������Ϊ��ѡ
		//3.��֮ǰ���ĵĺ�Լ�������ڿ�ѡ�ĸ�ѡ�����Զ�ѡ��
		//ÿ����ѡ��������������ΪID
		for (auto iter = instruCheckBox.begin(); iter != instruCheckBox.end(); iter++){
			(*iter)->setChecked(false);
			(*iter)->setEnabled(false);
			/*if (instruSet.find((*iter)->text()) != instruSet.end()){
				(*iter)->setEnabled(true);
				if (showedInstru.find((*iter)->text()) != showedInstru.end()){
					(*iter)->setChecked(true);
				}
			}*/
		}
		show();
	}
}

//�û����ȷ������øú���
void SelectShowMdWindow::pushOkButton(){
	showedInstru.clear();
	//��ѡ��ѡ������뼯�ϵ���
	for (auto iter = instruCheckBox.begin(); iter != instruCheckBox.end(); iter++){
		if ((*iter)->isChecked()){
			showedInstru.insert((*iter)->text());
		}
	}
	emit showChange(showedInstru);
	hide();
}

//�����Ѷ����б�
void SelectShowMdWindow::clearShowedInstru(){
	showedInstru.clear();
}