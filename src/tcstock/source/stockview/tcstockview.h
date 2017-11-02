#ifndef tcstockview_h

#define tcstockview_h

#include <QtCore/QVariant>
#include <QGraphicsView>

#include "tcstockscene.h"

/*! \brief tcStockView
 	\author tony (tonixinot@gmail.com)
 	\version 0.01
 	\date 2006.12.03
 	
	��ƱK��ͼ��ʾ�õ���ͼ�࣬�� tcStockScene ���һͬ��ʾ����K��ͼ��
*/
class tcStockView : public QGraphicsView
{
	Q_OBJECT

public:
	tcStockView(QWidget *pParent, tcStockScene *pScene);

	~tcStockView();

	void ResetViewport();

protected:

};

#endif //tcstockview_h

