#ifndef tcfavtinfomdl_h

#define tcfavtinfomdl_h

#include <QtCore/QVariant>
#include <QtCore/QObject>
#include <QStandardItemModel>

/*! \brief tcFavouriteInfoModel
 	\author tony (tonixinot@gmail.com)
 	\version 0.01
 	\date 2006.12.26
 	
	��ѡ����Ϣ�б���ʾ��Model���� tcFavouriteInfoDialog ��ʹ�á�
*/
class tcFavouriteInfoModel : public QStandardItemModel
{
	Q_OBJECT

public:
	tcFavouriteInfoModel(QObject *pParent);

	void LoadFavouriteInfoList(int pFavouriteGroupIndex);

	bool AppendFavouriteInfo(QWidget *pParent, int pFavouriteGroupIndex);

	bool RemoveFavouriteInfo(QWidget *pParent, int pFavouriteGroupIndex, int pIndex);

};

#endif //tcfavtinfomdl_h

