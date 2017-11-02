#ifndef _SELECT_SHOW_MD_WINDOW_H_
#define _SELECT_SHOW_MD_WINDOW_H_

//�û��ڸöԻ�����ѡ��Ҫ��ʾ��������ĺ�Լ
#include <qobject.h>
#include <qdialog.h>
#include <qstring.h>
#include <qpushbutton.h>
#include <qcheckbox.h>
#include <set>
#include <vector>

class SelectShowMdWindow : public QDialog
{
	Q_OBJECT
public:
	SelectShowMdWindow();
	void showDialog();
	void clearShowedInstru();					//�����Ѷ����б�
private:
	std::set<QString> showedInstru;				//�ڱ����չʾ�ĺ�Լ���뼯��
	std::vector<QCheckBox*>  instruCheckBox;	//ȫ����Լ�ĸ�ѡ��
	QPushButton *okButton;
	QPushButton *cancelButton;
private slots:
	void pushOkButton();
signals:
	void showChange(std::set<QString>& newInstru);
};

#endif