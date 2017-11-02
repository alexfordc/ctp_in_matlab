#ifndef _TICK_H_
#define _TICK_H_

#include <string.h>
struct CThostFtdcDepthMarketDataField;

struct CLimitPrice
{
	double	UpperLimitPrice;
	double	LowerLimitPrice;
};

class CTick
{
public:
	CTick();	
	CTick(const CThostFtdcDepthMarketDataField *pDepthMarketData);
	CTick(char InstrumentID[31], char ExchangeTime[25], char LocalTime[25], double LastPrice, double BidPrice1, int BidVolume1,
			double AskPrice1, int AskVolume1, int Volume, double Turnover, double OpenInterest, double HighestPrice, double LowestPrice);
	~CTick(void);
	CTick &operator=(const CTick &);
	

	

	const char *get_InstrumentID() const { return InstrumentID; }
	const char *get_ExchangeTime() const { return ExchangeTime; }
	const char *get_LocalTime() const { return LocalTime; }
	double get_LastPrice() const { return LastPrice; }
	double get_BidPrice1() const { return BidPrice1; }
	int get_BidVolume1() const { return BidVolume1; }
	double get_AskPrice1() const { return AskPrice1; }
	int get_AskVolume1() const { return AskVolume1; }
	int get_Volume() const { return Volume; }
	double get_Turnover() const { return Turnover; }
	double get_OpenInterest() const { return OpenInterest; }
	double get_HighestPrice() const { return HighestPrice; }
	double get_LowestPrice() const { return LowestPrice; }

	CTick &set_InstrumentID(const char *InstrumentID) { strcpy_s(this->InstrumentID, InstrumentID); }
	CTick &set_ExchangeTime(const char *ExchangeTime) { strcpy_s(this->ExchangeTime, ExchangeTime); }
	CTick &set_LocalTime(char LocalTime[25]) { strcpy_s(this->LocalTime, LocalTime); }
	CTick &set_LastPrice(double LastPrice) { this->LastPrice = LastPrice; }
	CTick &set_BidPrice1(double BidPrice1) { this->BidPrice1 = BidPrice1; }
	CTick &set_BidVolume1(int BidVolume1) { this->BidVolume1 = BidVolume1; }
	CTick &set_AskPrice1(double AskPrice1) { this->AskPrice1 = AskPrice1; }
	CTick &set_AskVolume1(int AskVolume1) { this->AskVolume1 = AskVolume1; }
	CTick &set_Volume(int Volume) { this->Volume = Volume; }
	CTick &set_Turnover(double Turnover) { this->Turnover = Turnover; }
	CTick &set_OpenInterest(double OpenInterest) { this->OpenInterest = OpenInterest; }
	CTick &set_HighestPrice(double HighestPrice) { this->HighestPrice = HighestPrice; }
	CTick &set_LowestPrice(double LowestPrice) { this->LowestPrice = LowestPrice; }

private:

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
};

#endif
