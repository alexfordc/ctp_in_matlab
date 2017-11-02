function OnRspQryInvestorPosition( ~, arg )
%��ѯͶ���ֲ߳���Ӧ

if arg.pRspInfo.ErrorID ~= 0
   disp(arg.pRspInfo.ErrorMsg);
   return;
end

Types;
InstrumentID = char(arg.pInvestorPosition.InstrumentID);
global VolumeMultiple; % ��Լ��������
volumeMulti = getfield(VolumeMultiple, InstrumentID);

posi_direction = '��ͷ';
if arg.pInvestorPosition.PosiDirection == QuantBox.CSharp2CTP.TThostFtdcPosiDirectionType.Long
    posi_direction = '��ͷ';
    TLPos = setfield(TLPos, InstrumentID, arg.pInvestorPosition.Position); %�ܶ��
    ALPos = setfield(ALPos, InstrumentID, arg.pInvestorPosition.Position - arg.pInvestorPosition.LongFrozen); %���ö��=�ܶ��-��ͷ����
    OLPos = setfield(OLPos, InstrumentID, arg.pInvestorPosition.YdPosition); %�򿪶��
    NLPos = setfield(NLPos, InstrumentID, arg.pInvestorPosition.TodayPosition); %�񿪶��   
    LPosAvgPrice = setfield(LPosAvgPrice, InstrumentID, arg.pInvestorPosition.PositionCost / volumeMulti); %��־��� 
else
    posi_direction = '��ͷ';
    TSPos = setfield(TSPos, InstrumentID, arg.pInvestorPosition.Position); %�ܿղ�
    ASPos = setfield(ASPos, InstrumentID, arg.pInvestorPosition.Position - arg.pInvestorPosition.ShortFrozen); %���ÿղ�=�ܿղ�-��ͷ����
    OSPos = setfield(OSPos, InstrumentID, arg.pInvestorPosition.YdPosition); %�򿪿ղ�
    NSPos = setfield(NSPos, InstrumentID, arg.pInvestorPosition.TodayPosition); %�񿪿ղ�
    SPosAvgPrice = setfield(SPosAvgPrice, InstrumentID, arg.pInvestorPosition.PositionCost / volumeMulti); %�ղ־���
end

str = sprintf('��ѯͶ���ֲ߳���Ӧ: ��Լ����(%s),Ͷ���ߴ���(%s),�ֲֶ�շ���(%s),���ճֲ�(%d),���ճֲ�(%d),������(%d)��ƽ����(%d)', char(InstrumentID), char(arg.pInvestorPosition.InvestorID), posi_direction, arg.pInvestorPosition.YdPosition, arg.pInvestorPosition.Position, arg.pInvestorPosition.OpenVolume, arg.pInvestorPosition.CloseVolume);
disp(str)
if arg.bIsLast == true
    disp('��ѯ�ֲ����'); 
end
end



%{
/// <summary>
    /// Ͷ���ֲ߳�
    /// </summary>
    [StructLayout(LayoutKind.Sequential)]
    public struct CThostFtdcInvestorPositionField
    {
        /// <summary>
        /// ��Լ����
        /// </summary>
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 31)]
        public string InstrumentID;
        /// <summary>
        /// ���͹�˾����
        /// </summary>
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 11)]
        public string BrokerID;
        /// <summary>
        /// Ͷ���ߴ���
        /// </summary>
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 13)]
        public string InvestorID;
        /// <summary>
        /// �ֲֶ�շ���
        /// </summary>
        public TThostFtdcPosiDirectionType PosiDirection;
        /// <summary>
        /// Ͷ���ױ���־
        /// </summary>
        public TThostFtdcHedgeFlagType HedgeFlag;
        /// <summary>
        /// �ֲ�����
        /// </summary>
        public TThostFtdcPositionDateType PositionDate;
        /// <summary>
        /// ���ճֲ�
        /// </summary>
        public int YdPosition;
        /// <summary>
        /// ���ճֲ�
        /// </summary>
        public int Position;
        /// <summary>
        /// ��ͷ����
        /// </summary>
        public int LongFrozen;
        /// <summary>
        /// ��ͷ����
        /// </summary>
        public int ShortFrozen;
        /// <summary>
        /// ���ֶ�����
        /// </summary>
        public double LongFrozenAmount;
        /// <summary>
        /// ���ֶ�����
        /// </summary>
        public double ShortFrozenAmount;
        /// <summary>
        /// ������
        /// </summary>
        public int OpenVolume;
        /// <summary>
        /// ƽ����
        /// </summary>
        public int CloseVolume;
        /// <summary>
        /// ���ֽ��
        /// </summary>
        public double OpenAmount;
        /// <summary>
        /// ƽ�ֽ��
        /// </summary>
        public double CloseAmount;
        /// <summary>
        /// �ֲֳɱ�
        /// </summary>
        public double PositionCost;
        /// <summary>
        /// �ϴ�ռ�õı�֤��
        /// </summary>
        public double PreMargin;
        /// <summary>
        /// ռ�õı�֤��
        /// </summary>
        public double UseMargin;
        /// <summary>
        /// ����ı�֤��
        /// </summary>
        public double FrozenMargin;
        /// <summary>
        /// ������ʽ�
        /// </summary>
        public double FrozenCash;
        /// <summary>
        /// �����������
        /// </summary>
        public double FrozenCommission;
        /// <summary>
        /// �ʽ���
        /// </summary>
        public double CashIn;
        /// <summary>
        /// ������
        /// </summary>
        public double Commission;
        /// <summary>
        /// ƽ��ӯ��
        /// </summary>
        public double CloseProfit;
        /// <summary>
        /// �ֲ�ӯ��
        /// </summary>
        public double PositionProfit;
        /// <summary>
        /// �ϴν����
        /// </summary>
        public double PreSettlementPrice;
        /// <summary>
        /// ���ν����
        /// </summary>
        public double SettlementPrice;
        /// <summary>
        /// ������
        /// </summary>
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 9)]
        public string TradingDay;
        /// <summary>
        /// ������
        /// </summary>
        public int SettlementID;
        /// <summary>
        /// ���ֳɱ�
        /// </summary>
        public double OpenCost;
        /// <summary>
        /// ��������֤��
        /// </summary>
        public double ExchangeMargin;
        /// <summary>
        /// ��ϳɽ��γɵĳֲ�
        /// </summary>
        public int CombPosition;
        /// <summary>
        /// ��϶�ͷ����
        /// </summary>
        public int CombLongFrozen;
        /// <summary>
        /// ��Ͽ�ͷ����
        /// </summary>
        public int CombShortFrozen;
        /// <summary>
        /// ���ն���ƽ��ӯ��
        /// </summary>
        public double CloseProfitByDate;
        /// <summary>
        /// ��ʶԳ�ƽ��ӯ��
        /// </summary>
        public double CloseProfitByTrade;
        /// <summary>
        /// ���ճֲ�
        /// </summary>
        public int TodayPosition;
        /// <summary>
        /// ��֤����
        /// </summary>
        public double MarginRateByMoney;
        /// <summary>
        /// ��֤����(������)
        /// </summary>
        public double MarginRateByVolume;
        /// <summary>
        /// ִ�ж���
        /// </summary>
        public int StrikeFrozen;
        /// <summary>
        /// ִ�ж�����
        /// </summary>
        public double StrikeFrozenAmount;
        /// <summary>
        /// ����ִ�ж���
        /// </summary>
        public int AbandonFrozen;
        /// <summary>
        /// ��Ȩ��ֵ
        /// </summary>
        public double OptionValue;
    }
%}