#ifndef _MARKET_DATA_H_
#define _MARKET_DATA_H_

#include "Types.h"

struct CThostFtdcDepthMarketDataField;

//! tick����
struct QUANTBOX_API wdTick
{
	///��Լ����
	char	InstrumentID[31];
	///������ʱ���
	char	ExchangeTime[25];	
	///����ʱ��
	char	LocalTime[25];
	///���¼�
	double	LastPrice;
	///�����һ
	double	BidPrice1;
	///������һ
	int		BidVolume1;
	///������һ
	double	AskPrice1;
	///������һ
	int		AskVolume1;
	///����
	int		Volume;
	///�ɽ����
	double	Turnover;
	///�ֲ���
	double	OpenInterest;
	///��߼�
	double	HighestPrice;
	///��ͼ�
	double	LowestPrice;

	wdTick();

	wdTick(char InstrumentID[31], char ExchangeTime[25], char LocalTime[25], double LastPrice, double BidPrice1, int BidVolume1,
		double AskPrice1, int AskVolume1, int Volume, double Turnover, double OpenInterest, double HighestPrice, double LowestPrice);

	wdTick(const CThostFtdcDepthMarketDataField *pDepthMarketData);
};

//! K������
struct QUANTBOX_API wdKLine
{
	///��Լ����
	char	InstrumentID[31];
	///������ʱ��
	char	ExchangeTime[25];	
	///��
	double	OpenPrice;
	///��
	double	HighestPrice;
	///��
	double	LowestPrice;
	///��
	double	ClosePrice;	
	///���һ��tick���ۼƳɽ����� Volume - LastVolume �õ�����K�ߵĳɽ���
	int		Volume;
	///�ֲ���
	double	OpenInterest;	
	///����
	char	Period[5];
	///��һ��k�����һ��tick���ۼƳɽ���
	int		LastVolume;
	///��һ���ֲ���
	double	LastOpenInterest;

	wdKLine(void);

	wdKLine(const char *InstrumentID, const char *Period);
};

#endif