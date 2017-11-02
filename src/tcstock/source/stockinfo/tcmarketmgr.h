#ifndef tcmarketmgr_h

#define tcmarketmgr_h

#include <QtCore/QVariant>
#include <QtCore/QObject>
#include <QtCore/QDir>

#include "tcmarket.h"

typedef QList<tcMarket*> tcMarketList;

/*! \brief tcMarketManager
 	\author tony (tonixinot@gmail.com)
 	\version 0.01
 	\date 2006.12.02
 	
	�������еĹ��У���ϵͳ�����й�Ʊ���ȡ������ڡ�
	������ϵͳ�ɹ���ʼ���󣬻���һ��ȫ�ֵ�Ψһʵ������Ҫ�� tcObjService::GetMarketManager() ��ȡ�ã�
	Ȼ�󰴲�η�����Ҫ����Դ��
*/
class tcMarketManager : public QObject
{
	Q_OBJECT

public:
	tcMarketManager(const QDir &pPath);

	~tcMarketManager();

	bool LoadFromFile();

	bool SaveToFile();

	tcMarket* GetMarket(int pMarketIndex);

	tcMarket* GetMarket(QWidget *pParent);

	bool EditMarketList(QWidget *pParent);

	int GetMarketCount();

	tcMarket* AppendMarket(const QString &pName);

	tcMarket* AppendMarket(QWidget *pParent);

	tcMarket* ModifyMarket(QWidget *pParent, int pMarketIndex);

	bool RemoveMarket(QWidget *pParent, int pMarketIndex);

	/*!
		let user select a list of stock from all markets.
	*/
	bool SelectStock(QWidget *pParent, tcStockInfoList &pStockInfoList);

	bool GetStockInfoList(int pMarketIndex, tcStockInfoList &pStockInfoList);

	bool GetStockInfoListFilter(int pMarketIndex, tcStockInfoList &pStockInfoList, const QString &pStockCodeFilter, const QString &pStockNameFilter);

	void ClearAllMarkets();

protected slots:
	/*!
		notified by tcMarket.
	*/
	void DoStocksModified();

private:
	QDir mPath;

	tcMarketList mMarketList;

signals:
	void OnMarketsModified();

	void OnStocksModified(tcMarket *pMarket);

};

inline tcMarket* tcMarketManager::GetMarket(int pMarketIndex)
{
	if (pMarketIndex < 0 || pMarketIndex >= mMarketList.count()) {
		return NULL;
	}
	return mMarketList[pMarketIndex];
}

#endif //tcmarketmgr_h
