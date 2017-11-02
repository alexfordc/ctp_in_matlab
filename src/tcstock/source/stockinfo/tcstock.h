#ifndef tcstock_h

#define tcstock_h

#include <QtCore/QVariant>
#include <QtCore/QObject>
#include <QtXml/QDomDocument>
#include <QtXml/QDomElement>

#include "tcstockdata.h"
#include "tcstockdatacache.h"

/*! \brief tcStock
 	\author tony (tonixinot@gmail.com)
 	\version 0.01
 	\date 2006.12.02
 	
	��Ʊ��Ϣ�࣬�����Ʊ�Ĵ�������Ƶ���Ϣ����������Щ��Щ��Ϣ�ļ��ء�
	�ⲿ����Ҫ���ʹ�Ʊ�ĸ�������ʱ��Ҳֱ��ͨ��������ʣ�
	���Ǹ����ڲ�ʵ��ͨ�� tcStockDataCache ������ȡ��Ʊ���ݡ�
*/
class tcStock : public QObject
{
	Q_OBJECT

public:
	tcStock(tcStockDataCache *pStockDataCache);

	~tcStock();

	bool LoadFromXml(const QDomElement &pElement);

	bool SaveToXml(QDomDocument &pDoc, QDomElement &pElement);

	virtual const tcStockDailyData* ReadData(const QDate &pDate);

	virtual bool ReadData(const QDate &pDate, tcStockDailyData *pStockDailyData);

	virtual bool ReadData(const QDate &pStartDate, int pDayCount, tcStockDailyData *pData);

	virtual bool WriteData(const QDate &pDate, tcStockDailyData *pStockDailyData);

	QString GetStockCode() { return mStockCode; }

	void SetStockCode(const QString &pStockCode) { mStockCode = pStockCode; }

	virtual QString GetStockName() { return mStockName; }

	void SetStockName(const QString &pStockName) { mStockName = pStockName; }

	virtual QString GetDescription() { return mDescription; }

	void SetDescription(const QString &pDescription) { mDescription = pDescription; }

protected:
	tcStock();

private:
	tcStockDataCache *mStockDataCache;

	QString mStockCode;

	QString mStockName;

	QString mDescription;

};

inline const tcStockDailyData* tcStock::ReadData(const QDate &pDate)
{
	return mStockDataCache->ReadData(mStockCode, pDate);
}

inline bool tcStock::ReadData(const QDate &pDate, tcStockDailyData *pStockDailyData)
{
	return mStockDataCache->ReadData(mStockCode, pDate, pStockDailyData);
}

inline bool tcStock::ReadData(const QDate &pStartDate, int pDayCount, tcStockDailyData *pData)
{
	return mStockDataCache->ReadData(mStockCode, pStartDate, pDayCount, pData);
}

inline bool tcStock::WriteData(const QDate &pDate, tcStockDailyData *pStockDailyData)
{
	return mStockDataCache->WriteData(mStockCode, pDate, pStockDailyData);
}

#endif //tcstock_h
