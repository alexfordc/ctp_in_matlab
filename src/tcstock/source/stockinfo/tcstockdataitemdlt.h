#ifndef tcstockdataitemdlt_h

#define tcstockdataitemdlt_h

#include <QtCore/QVariant>
#include <QtCore/QObject>
#include <QItemDelegate>

/*! \brief tcStockDataItemDelegate
 	\author tony (tonixinot@gmail.com)
 	\version 0.01
 	\date 2006.12.03
 	
	tcStockData �� Delegate������֧�� tcStockDataInfoDialog �Ϲ�Ʊ�����ݵ�¼�빦�ܡ�
*/
class tcStockDataItemDelegate : public QItemDelegate
{
	Q_OBJECT

public:
	tcStockDataItemDelegate(QObject *pParent);

	QWidget* createEditor(QWidget *pParent, const QStyleOptionViewItem &pViewItem, const QModelIndex &pIndex) const;

	void setEditorData(QWidget *pEditor, const QModelIndex &pIndex) const;

	void setModelData(QWidget *pEditor, QAbstractItemModel *pModel, const QModelIndex &pIndex) const;

private slots:
	void commitAndCloseEditor();

};

#endif //tcstockdataitemdlt_h


