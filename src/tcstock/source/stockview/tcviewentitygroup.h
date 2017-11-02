#ifndef tcviewentitygroup_h

#define tcviewentitygroup_h

#include <QtCore/QVariant>
#include <QtCore/QObject>
#include <QGraphicsItemGroup>

#include "tcviewentity.h"
#include "../viewmodel/tcviewmodelpack.h"

/*! \brief tcViewEntityGroup
 	\author tony (tonixinot@gmail.com)
 	\version 0.01
 	\date 2006.12.06
 	
	K��ͼ�е�ʵ�壬��������ʵ����Σ��Լ����������ȡ�
*/
class tcViewEntityGroup : public QObject, public QGraphicsItemGroup
{
	Q_OBJECT

public:
	tcViewEntityGroup(QObject *pParent, tcViewModelStockData *pStockData);

	void SetPosAndScale(qreal pXPos, qreal pYPos, qreal pYScale);

private:
	tcViewEntity *mViewEntity;

	QGraphicsLineItem *mEntityLine;

	QGraphicsTextItem *mOpenPriceText;

	QGraphicsTextItem *mClosePriceText;

	QGraphicsTextItem *mMaxPriceText;

	QGraphicsTextItem *mMinPriceText;

};

#endif //tcviewentitygroup_h
