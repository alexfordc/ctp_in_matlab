#ifndef tcdailyviewwgt_h

#define tcdailyviewwgt_h

#include <QtCore/QVariant>
#include <QWidget>

#include "stockinfo/tcstockinfopack.h"
#include "viewmodel/tcviewmodelpack.h"
#include "stockview/tcstockviewpack.h"

/*! \brief tcDailyViewWidget
 	\author tony (tonixinot@gmail.com)
 	\version 0.01
 	\date 2007.01.03
 	
	ϵͳ����ʾ������K����ͼ���ڡ�
*/
class tcDailyViewWidget : public QWidget
{
	Q_OBJECT

public:
	tcDailyViewWidget(QWidget *pParent);

	void LoadStockInfoList(tcStockInfoList *pStockInfoList);

private:
	tcViewModel *mDailyViewModel;

	tcStockScene *mDailyViewScene;

	tcStockView *mDailyView;

};

#endif //tcdailyviewwgt_h
