#ifndef tcfavtinfodlt_h

#define tcfavtinfodlt_h

#include <QtCore/QVariant>
#include <QtCore/QObject>
#include <QItemDelegate>

/*! \brief tcFavouriteInfoDelegate
 	\author tony (tonixinot@gmail.com)
 	\version 0.01
 	\date 2006.12.26
 	
	��ѡ��Ʊ�б���ʾ��Delegate���� tcFavouriteInfoDialog ʹ�á�
*/
class tcFavouriteInfoDelegate : public QItemDelegate
{
	Q_OBJECT

public:
	tcFavouriteInfoDelegate(QObject *pParent);

};

#endif //tcfavtinfodlt_h


