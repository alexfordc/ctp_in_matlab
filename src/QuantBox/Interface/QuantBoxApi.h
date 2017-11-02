//////////////////////////////////////////////////////////////////
///@system �����ʹ�C++�������׽ӿ�
///@company �������
///@file QuantBoxApi.h  
///@brief ����������ƽ̨�ͻ��˵�C���Ľӿں͸������ݽṹ,ʵ�ֶ������顢�µ��������ȹ���
///@20140915 ���	�������ļ�
/*! \section sec_example ������
	\code
	//1��ע��ص�����
	//2������CTP������ǰ���뽻��ǰ��
	//3���������顢��д���ԣ�������ص���ִ�в��ԣ����ݽ����źŵ����µ��������ӿ�
	//4���Ͽ�CTP������ǰ�ˡ�����ǰ�ˣ������˳�
	\endcode
 */
//////////////////////////////////////////////////////////////////

#ifndef _QUANT_BOX_API_H_
#define _QUANT_BOX_API_H_

#include <vector>
#include <map>
#include <string>
#include "MarketData.h"
#include "TradeData.h"

QUANTBOX_API extern std::string			g_mdDBPath;
QUANTBOX_API extern std::string			g_tdDBPath;
QUANTBOX_API extern const char			*g_Table_Order;
QUANTBOX_API extern const char			*g_Table_Trade;
QUANTBOX_API extern const char			*g_Table_Position;
//#ifdef __cplusplus
//extern "C" {
//#endif

/*!	\brief ����ӿ� ***********************************************************************************/


/*!	\brief ����CTP������ǰ��	���ڷ�������ip��port��user��passwd�� �� ConfigFile.xml */
QUANTBOX_API void __stdcall MD_Connect();

/*!	\brief ��������
	\param Instruments ��Լ�б���","������"IF1409,IF1410"
	\param period ���ڣ���","����,"tick,3s,6m,8m,1h"
	\n\n����ʹ�÷�����
	\code
	//����IF1410��IF1411��tick���ݡ�3s���ݡ�1m����
	MD_Subscribe("IF1410,IF1411", "tick,3s,1m");
	\endcode
*/
QUANTBOX_API void __stdcall MD_Subscribe(const char *Instruments, const char *period = "tick");

/*!	\brief ȡ������
	\param Instruments ��Լ�б���","������"IF1409,IF1410"
	\param period ���ڣ���","����,"tick,3s,6m,8m,1h"
	\n\n����ʹ�÷�����
	\code
	//ȡ��IF1410��IF1411��tick���ݡ�3s���ݡ�1m����
	MD_Unsubscribe("IF1410,IF1411", "tick,3s,1m");
	//ȡ�����к�Լ������
	MD_Subscribe();
	\endcode
*/
QUANTBOX_API void __stdcall MD_Unsubscribe(const char *Instruments = "all", const char *period = "all");

/*!	\brief ������ʷ����	
	\param beginTime ��ʼʱ�� "20140910-09:30:00.000"
	\param endTime ����ʱ�� "20140910-15:30:00.000"
	\param Instruments ��Լ�б���","������"IF1409,IF1410"
	\param period ���ڣ���","����,"tick,3s,6m,8m,1h"
	\n\n����ʹ�÷�����
	\code
	//���� IF1409��"20140910-09:30:00.000"��"20140910-15:30:00.000"��tick��4s����ʷ����
	MD_SubscribeHistory("20140910-09:30:00.000", "20140910-15:30:00.000", "IF1409", "tick,4s");
	\endcode
*/
QUANTBOX_API void __stdcall MD_SubscribeHistory(const char *beginTime, const char *endTime, const char *Instruments, const char *period = "tick");

/*!	\brief �Ͽ�CTP������ǰ�� */
QUANTBOX_API void __stdcall MD_Disconnect();

/*!	\brief ��ȡĳ����Լ�����µ�tick
	\param Instrument ��Լ��
	\param isHistory �Ƿ��ĵ���ʷ����
	\return ����tick
	\n\n����ʹ�÷�����
	\code
	//��ȡIF1410���µ�tick
	wdTick tick = GetLastTick("IF1410");
	\endcode
*/
QUANTBOX_API wdTick __stdcall GetLastTick(const char *Instrument, bool isHistory = false);

/*!	\brief ��ȡĳ����Լ�����µ�һЩtick����
	\param Instrument ��Լ��
	\param Num ���ٸ�����
	\param isHistory �Ƿ��ĵ���ʷ����
	\return vecLastTicks ������ݵ����������µ�tick���ڵ�һ������һ��tick���������ĵڶ���λ��...
	\n\n����ʹ�÷�����
	\code
	//��ȡIF1410���µ�10��tick
	std::vector<wdTick> vecLastTicks;
	GetLastTick("IF1410", 10, vecLastTicks);	
	\endcode
*/
QUANTBOX_API void __stdcall GetLastTick(const char *Instrument, int Num, std::vector<wdTick> &vecLastTicks, bool isHistory = false);

/*!	\brief ��ȡĳ����Լ��ĳ�����ڵ����µ�K��
	\param Instrument ��Լ��
	\param period ����
	\param isHistory �Ƿ��ĵ���ʷ����
	\return ����K��
	\n\n����ʹ�÷�����
	\code
	//��ȡIF1410���µ�1m K�ߡ�ǰ���Ƕ�����IF1410��1m K��
	wdKLine kline = GetLastKLine("IF1410", "1m");
	\endcode
*/
QUANTBOX_API wdKLine __stdcall GetLastKLine(const char *Instrument, const char *period, bool isHistory = false);

/*!	\brief ��ȡĳ����Լ��ĳ�����ڵ����µ�һЩK��
	\param Instrument ��Լ��
	\param period ����
	\param Num ���ٸ�����
	\param isHistory �Ƿ��ĵ���ʷ����	
	\return vecLastKLines ���K�ߵ�����
	\n\n����ʹ�÷�����
	\code
	//��ȡIF1410���µ�30�� 5sK�ߡ�ǰ���Ƕ�����IF1410��5s K��
	std::vector<wdKLine> vecLastKLines;
	GetLastKLine("IF1410", "5s", 30, vecLastKLines);
	\endcode
*/
QUANTBOX_API void __stdcall GetLastKLine(const char *Instrument, const char *period, int Num, std::vector<wdKLine> &vecLastKLines, bool isHistory = false);

/*!	\brief ��ȡ���к�Լ����Ϣ
	\return vecInsts ��Լ��ϸ
*/
QUANTBOX_API void __stdcall GetInstrument(std::vector<wdInstrument> &vecInsts);

/*!	\brief ��ȡĳ���˻�����Ϣ
	\param AccountID �˺�ID
	\return �˺���Ϣ
*/
QUANTBOX_API wdTradingAccount __stdcall GetTradingAccount(const char *AccountID);



/*!	\brief ���׽ӿ� ***********************************************************************************/

/*!	\brief ����CTP����ǰ�� */
QUANTBOX_API void __stdcall TD_Connect();

/*!	\brief ����-�޼�
	\param Instrument ��Լ��
	\param Price �۸�
	\param Volume ����
	\param Direction ��������
	\param OffsetFlag ��ƽ��־
	\n\n����ʹ�÷�����
	\code
	//��3000��ļ۸���1��IF1410
	TD_SendLimitOrder("IF1410", 3000., 1, E_Buy, E_Open);
	\endcode
*/
QUANTBOX_API void __stdcall TD_SendLimitOrder(const char *Instrument, double Price, int Volume,	wdDirectionType Direction, wdOffsetFlagType OffsetFlag);

/*!	\brief ����-�м�
	\param Instrument ��Լ��
	\param Volume ����
	\param Direction ��������
	\param OffsetFlag ��ƽ��־
	\n\n����ʹ�÷�����
	\code
	//���м���1��IF1410
	TD_SendMarketOrder("IF1410", 1, E_Buy, E_Open);
	\endcode
*/
QUANTBOX_API void __stdcall TD_SendMarketOrder(const char *Instrument, int Volume, wdDirectionType Direction, wdOffsetFlagType OffsetFlag);

/*!	\brief ����-������
	\param Instrument ��Լ��
	\param Price �۸�
	\param Volume ����
	\param Direction ��������
	\param OffsetFlag ��ƽ��־
	\param ContingentCondition ��������
	\param StopPrice ֹ���
*/
QUANTBOX_API void __stdcall TD_SendContingentOrder(const char *Instrument, double Price, int Volume, wdDirectionType Direction, wdOffsetFlagType OffsetFlag,
												   wdContingentConditionType ContingentCondition, double StopPrice);

/*!	\brief ����
	\param Instrument ��Լ��
	\param Direction ��������
	\param OffsetFlag ��ƽ��־
	\n\n����ʹ�÷�����
	\code
	//����IF1410���򿪵�
	TD_CancelOrder("IF1410", E_Buy, E_Open);
	\endcode
*/
QUANTBOX_API void __stdcall TD_CancelOrder(const char *Instrument, wdDirectionType Direction = E_Direction_Default, wdOffsetFlagType OffsetFlag = E_OffsetFlag_Default);
QUANTBOX_API void __stdcall TD_CancelOrder(const wdOrder &);

/*!	\brief ��ֲ�
	\param Instrument ��Լ��,Ϊ""������
*/
QUANTBOX_API void __stdcall TD_ReqQryInvestorPosition(const char *Instrument = nullptr);

/*!	\brief ���Լ
	\param Instrument ��Լ��
*/
QUANTBOX_API void __stdcall TD_ReqQryInstrument(const char *Instrument = nullptr);

/*!	\brief ��������
	\param Instrument ��Լ��
*/
QUANTBOX_API void __stdcall TD_ReqQryInstrumentCommissionRate(const char *Instrument = nullptr);

/*!	\brief �鱣֤��
	\param Instrument ��Լ��
*/
QUANTBOX_API void __stdcall TD_ReqQryInstrumentMarginRate(const char *Instrument = nullptr);

/*!	\brief �����ѯͶ���߽�����
	\param TradingDay �����գ�����"20140912"
*/
QUANTBOX_API void __stdcall TD_ReqQrySettlementInfo(const char *TradingDay);

/*!	\brief ��ί��
	\param Instrument ��Լ��
*/
QUANTBOX_API void __stdcall TD_ReqQryOrder(const char *Instrument = nullptr);

/*!	\brief ��ɽ�
	\param Instrument ��Լ��
*/
QUANTBOX_API void __stdcall TD_ReqQryTrade(const char *Instrument = nullptr);

/*!	\brief �Ͽ����� */
QUANTBOX_API void __stdcall TD_Disconnect();


QUANTBOX_API void __stdcall CTP_RegOnConnect(fnOnConnect);
QUANTBOX_API void __stdcall CTP_RegOnRspError(fnOnError);

/*!	\brief ע������ص� ***********************************************************************************/
QUANTBOX_API void __stdcall CTP_RegOnRtnDepthMarketData_Tick(fnOnTick);
QUANTBOX_API void __stdcall CTP_RegOnRtnDepthMarketData_KLine(fnOnKLine);
QUANTBOX_API void __stdcall CTP_RegOnHistory_Tick(fnOnTick);
QUANTBOX_API void __stdcall CTP_RegOnHistory_KLine(fnOnKLine);

/*!	\brief ע�ύ�׻ص� ***********************************************************************************/
QUANTBOX_API void __stdcall CTP_RegOnRspQryInstrument(fnOnInstrument);
QUANTBOX_API void __stdcall CTP_RegOnRspQryInvestorPosition(fnOnPosition);
QUANTBOX_API void __stdcall CTP_RegOnRspQryOrder(fnOnOrder);
QUANTBOX_API void __stdcall CTP_RegOnRspQryTrade(fnOnTrade);
QUANTBOX_API void __stdcall CTP_RegOnRspQrySettlementInfo(fnOnSettlementInfo);

//#ifdef __cplusplus
//}
//#endif


#endif