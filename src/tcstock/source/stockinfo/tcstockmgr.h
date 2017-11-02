#ifndef tcstockmgr_h

#define tcstockmgr_h

#include <QtCore/QVariant>
#include <QtCore/QObject>
#include <QtCore/QDir>

#include "tcstock.h"
#include "tcstockdatacache.h"

/*! \brief tcStockManager
 	\author tony (tonixinot@gmail.com)
 	\version 0.02
 	\date 2007.03.15
 	
	��Ʊ��Ϣ�����࣬ϵͳ�����й�Ʊ���ɸ����һ��ȫ��ʵ��������
	����ͬʱ�����XML�ļ���ȡ/ �����Ʊ��Ϣ��
	ϵͳ�и����ܿ���ʹ�Ʊ��Ϣʱ��һ��ʹ�� tcStockInfo �࣬�����ӵ�ͨ��������ȡ��ʵ�����ݡ�
*/
class tcStockManager : public QObject
{
	Q_OBJECT

public:
	tcStockManager(const QDir &pPath);

	~tcStockManager();

	bool LoadFromFile();

	bool SaveToFile();

	tcStock* AppendStock(const QString &pStockCode, const QString &pStockName);
	
	tcStock* AppendStock(QWidget *pParent);

	tcStock* ModifyStock(QWidget *pParent, const QString &pStockCode);

	bool RemoveStock(const QString &pStockCode);

	bool RemoveStock(QWidget *pParent, const QString &pStockCode);

	bool EditStockData(QWidget *pParent);

	tcStock* GetStockByCode(const QString &pStockCode);

	void ClearAllStocks();

#ifdef _DEBUG
	bool Test();
#endif

private:
	QDir mPath;

	QMap<QString, tcStock*> mStockMap;

	tcStockDataCache *mStockDataCache;

	bool mModified;

};

inline tcStock* tcStockManager::GetStockByCode(const QString &pStockCode)
{
	if (! mStockMap.contains(pStockCode)) {
		return NULL;
	}
	return mStockMap[pStockCode];
}

#endif //tcstockmgr_h

