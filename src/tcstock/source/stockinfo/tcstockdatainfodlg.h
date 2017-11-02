#ifndef tcstockdatainfodlg_h

#define tcstockdatainfodlg_h

#include <QtCore/QVariant>
#include <QDialog>
#include "ui_ui_stockdatainfodlg.h"

#include "tcmarket.h"
#include "tcstockdataitemmdl.h"
#include "tcstockdataitemdlt.h"

/*! \brief tcStockDataInfoDialog
 	\author tony (tonixinot@gmail.com)
 	\version 0.01
 	\date 2006.12.03
 	
	��Ʊ��������ʾ��¼��Ի���
	ʹ�� tcStockDataItemDelegate �� tcStockDataItemModel ����ʵ�����ݵ�¼�빦�ܡ�s
*/
class tcStockDataInfoDialog : public QDialog, private Ui_tcStockDataInfoDialog
{
	Q_OBJECT

public:
	tcStockDataInfoDialog(QWidget *pParent);

protected:

protected slots:
	void DoDateChanged(const QDate &pDate);

	void DoGroupChanged(int pIndex);

	void DoFilterTextChanged(const QString &pText);

private:
	tcStockDataItemModel *mDataModel;

	tcStockDataItemDelegate *mDataDelegate;
};

#endif //tcstockdatainfodlg_h

