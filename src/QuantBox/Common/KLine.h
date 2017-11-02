#ifndef _K_LINE_H_
#define _K_LINE_H_

#include <string.h>
class CKLine
{
public:
	CKLine(void);
	~CKLine(void);

	const char *get_InstrumentID() const { return InstrumentID; }
	const char *get_ExchangeTime() const { return ExchangeTime; }
	double get_OpenPrice() const { return OpenPrice; }
	double get_HighestPrice() const { return HighestPrice; }
	double get_LowestPrice() const { return LowestPrice; }
	double get_ClosePrice() const { return ClosePrice; }
	int get_LastVolume() const { return LastVolume; }
	int get_Volume() const { return Volume; }
	double get_OpenInterest() const { return OpenInterest; }
	const char *get_Period() const { return Period; }

	CKLine &set_InstrumentID(const char	*InstrumentID) { strcpy_s(this->InstrumentID, InstrumentID); return *this; }
	CKLine &set_ExchangeTime(const char	*ExchangeTime) { strcpy_s(this->ExchangeTime, ExchangeTime); return *this; }
	CKLine &set_OpenPrice(double OpenPrice) { this->OpenPrice = OpenPrice; return *this; }
	CKLine &set_HighestPrice(double HighestPrice) { this->HighestPrice = HighestPrice; return *this; }
	CKLine &set_LowestPrice(double LowestPrice) { this->LowestPrice = LowestPrice; return *this; }
	CKLine &set_ClosePrice(double ClosePrice) { this->ClosePrice = ClosePrice; return *this; }
	CKLine &set_LastVolume(int LastVolume) { this->LastVolume = LastVolume; return *this; }
	CKLine &set_Volume(int Volume) { this->Volume = Volume; return *this; }
	CKLine &set_OpenInterest(double OpenInterest) { this->OpenInterest = OpenInterest; return *this; }
	CKLine &set_Period(const char *Period) { strcpy_s(this->Period, Period); return *this; }

private:
	///��Լ����
	char	InstrumentID[31];
	///������ʱ��
	char	ExchangeTime[25];	
	double	OpenPrice;
	double	HighestPrice;
	double	LowestPrice;
	double	ClosePrice;
	///��һ��k�����һ��tick���ۼƳɽ���
	int		LastVolume;
	///���һ��tick���ۼƳɽ����� Volume - LastVolume �õ�����K�ߵĳɽ���
	int		Volume;
	double	OpenInterest;	
	char	Period[5];
};

#endif