#ifndef tcviewquantity_h

#define tcviewquantity_h

#include <QtCore/QVariant>
#include <QtCore/QObject>
#include <QGraphicsItem>

#include "../viewmodel/tcviewmodelpack.h"

#define QUANTITY_WIDTH 16

/*! \brief tcViewQuantity
 	\author tony (tonixinot@gmail.com)
 	\version 0.01
 	\date 2006.12.06
 	
	�ɽ���ͼ�Σ�������ʾΪʵ�Ļ���ľ��Ρ�
*/
class tcViewQuantity : public QObject, public QGraphicsItem
{
	Q_OBJECT

public:
	tcViewQuantity(QObject *pParent, tcViewModelStockData *pStockData);

protected:
	QRectF boundingRect() const;

	void paint(QPainter *pPainter, const QStyleOptionGraphicsItem *pOption, QWidget *pWidget);

private:
	qreal mHeight;

	bool mIsFill;

};

#endif //tcviewquantity_h
