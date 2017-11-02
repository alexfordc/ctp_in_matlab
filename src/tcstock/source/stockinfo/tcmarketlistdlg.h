#ifndef tcmarketlistdlg_h

#define tcmarketlistdlg_h

#include <QtCore/QVariant>
#include <QDialog>
#include "ui_ui_marketlistdlg.h"

#include "tcmarket.h"

/*! \brief tcMarketListDialog
 	\author tony (tonixinot@gmail.com)
 	\version 0.01
 	\date 2006.12.03
 	
	�������Ʊ�б���ʾ���ڣ�ͬʱ֧�ֶԹ��к�ĳ��������Ӧ��Ʊ��Ϣ�ĵ����Ӻ�ɾ����
*/
class tcMarketListDialog : public QDialog, private Ui_tcMarketListDialog
{
	Q_OBJECT

public:
	tcMarketListDialog(QWidget *pParent);

protected:
	void LoadMarketList();

	void LoadStockList();

	tcMarket* GetSelectedMarket();

protected slots:
	void DoMarketIndexChanged(int);

	void DoAppendMarket();

	void DoModifyMarket();

	void DoRemoveMarket();

	void DoAppendStock();

	void DoModifyStock();

	void DoRemoveStock();

	void DoImportStocksFromCSV();

	void DoExportStocksToCSV();

};

#endif //tcmarketlistdlg_h

