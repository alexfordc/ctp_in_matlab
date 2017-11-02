#ifndef tcnullstock_h

#define tcnullstock_h

#include <QtCore/QVariant>
#include <QtCore/QObject>

#include "tcstock.h"

/*! \brief tcNullStock
 	\author tony (tonixinot@gmail.com)
 	\version 0.01
 	\date 2007.03.20
 	
	���಻�����κ�ʵ��Ч�ã���Ϊһ���յĹ�Ʊ��Ϣ��������ڡ�
	Ϊ��ʹ tcStockInfo ��ͨ�����ص� -> ���������� tcStock ʱ�����ⷶΧ�������ڵ����ݣ�������£�tcStockInfo ������һ������ľ�̬ȫ�ֶ���
*/
class tcNullStock : public tcStock
{
	Q_OBJECT

public:
	tcNullStock();

	virtual const tcStockDailyData* ReadData(const QDate &pDate);

	virtual bool ReadData(const QDate &pDate, tcStockDailyData *pStockDailyData);

	virtual bool ReadData(const QDate &pStartDate, int pDayCount, tcStockDailyData *pData);

	virtual bool WriteData(const QDate &pDate, tcStockDailyData *pStockDailyData);

	virtual QString GetStockName();

	virtual QString GetDescription();

	static tcNullStock NullStock;

};

inline const tcStockDailyData* tcNullStock::ReadData(const QDate &pDate)
{
	return NULL;
}

inline bool tcNullStock::ReadData(const QDate &pDate, tcStockDailyData *pStockDailyData)
{
	return false;
}

inline bool tcNullStock::ReadData(const QDate &pStartDate, int pDayCount, tcStockDailyData *pData)
{
	return false;
}

inline bool tcNullStock::WriteData(const QDate &pDate, tcStockDailyData *pStockDailyData)
{
	return false;
}

#endif //tcnullstock_h
