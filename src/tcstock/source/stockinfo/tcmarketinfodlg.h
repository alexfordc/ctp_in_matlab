#ifndef tcmarketinfodlg_h

#define tcmarketinfodlg_h

#include <QtCore/QVariant>
#include <QDialog>
#include "ui_ui_marketinfodlg.h"

#include "tcmarket.h"

/*! \brief tcMarketInfoDialog
 	\author tony (tonixinot@gmail.com)
 	\version 0.01
 	\date 2006.12.03
 	
	������Ϣ�༭���棬�� tcMarketManager �ฺ����á�
*/
class tcMarketInfoDialog : public QDialog, private Ui_tcMarketInfoDialog
{
	Q_OBJECT

public:
	tcMarketInfoDialog(QWidget *pParent);

	bool LoadFromMarket(tcMarket *pMarket);

	bool SaveToMarket(tcMarket *pMarket);

protected slots:
	void DoOk();

};

#endif //tcmarketinfodlg_h

