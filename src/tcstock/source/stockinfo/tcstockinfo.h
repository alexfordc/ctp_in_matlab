#ifndef tcstockinfo_h

#define tcstockinfo_h

#include <QtCore/QVariant>
#include <QtCore/QObject>

#include "../service/tcsvcpack.h"
#include "tcstock.h"
#include "tcnullstock.h"
#include "tcstockmgr.h"

/*! \brief tcStockInfo
 	\author tony (tonixinot@gmail.com)
 	\version 0.01
 	\date 2006.12.26
 	
	������Handle��һ���࣬����ָ��ϵͳ�е�ĳ�� tcStock ��
	��ͬʱ�������б�ź͹�Ʊ���룬���ϵͳ��Ҫ����ĳ����Ʊָ��ʱ��һ�㲻Ҫֱ��ʹ�� tcstock ��ָ�룬
	��Ӧ��ʹ�ø��࣬������ָ��� tcStock ����ɾ��ʱ�������������Ӧ����֤������ʵ��Ƿ���ַ��
*/
class tcStockInfo : public QObject
{
	Q_OBJECT

public:
	tcStockInfo();

	tcStockInfo(const QString &pStockCode);

	tcStockInfo(const tcStockInfo &pInfo);

	QString GetStockCode();

	tcStockInfo& operator=(const tcStockInfo &pInfo);

	bool operator==(const tcStockInfo &pInfo);

	bool IsAvailable();

	tcStock* operator->() const;

protected slots:

protected:
	QString mStockCode;

};

inline bool tcStockInfo::IsAvailable()
{
	tcStockManager *stockmanager = tcObjService::GetStockManager();
	return (stockmanager->GetStockByCode(mStockCode) != NULL);
}

inline tcStock* tcStockInfo::operator->() const
{
	tcStockManager *stockmanager = tcObjService::GetStockManager();
	tcStock *stock = stockmanager->GetStockByCode(mStockCode);
	if (stock == NULL) {	//if the stock not exists, return the tcNullStock object, it will provide an empty stock.
		stock = &tcNullStock::NullStock;
	}
	return stock;
}

#endif //tcstockinfo_h
