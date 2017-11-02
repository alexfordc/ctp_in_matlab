function OnRtnOrder(~, arg)
%������Ӧ��һ�����ί�гɹ��ύ����������

%{
direction = 'buy';
if arg.pOrder.Direction == QuantBox.CSharp2CTP.TThostFtdcDirectionType.Sell
    direction = 'sell';
end
offset_flag = 'Open';
    if strcmpi(strtrim(char(arg.pOrder.CombOffsetFlag)), '0')
        offset_flag = 'Open';
    elseif strcmpi(strtrim(char(arg.pOrder.CombOffsetFlag)), '1')
        offset_flag = 'Close';
    elseif strcmpi(strtrim(char(arg.pOrder.CombOffsetFlag)), '3')
        offset_flag = 'CloseToday';
    elseif strcmpi(strtrim(char(arg.pOrder.CombOffsetFlag)), '4')
        offset_flag = 'CloseYesterday';
    else
        error('��ƽ�������');
    end
%}
    str = sprintf('������Ӧ: ��Լ����(%s),����������(%s),�������(%s),�����ύ״̬(%s),����״̬(%s),״̬��Ϣ(%s)',char(arg.pOrder.InstrumentID), char(arg.pOrder.ExchangeID), char(arg.pOrder.OrderSysID), char(arg.pOrder.OrderSubmitStatus), char(arg.pOrder.OrderStatus),char(arg.pOrder.StatusMsg));
    disp(str);

    if strcmp(strtrim(char(arg.pOrder.OrderSysID)), '')
        return;
    end



    Types;
    InstrumentID = char(arg.pOrder.InstrumentID);
       
    if arg.pOrder.OrderStatus ~= QuantBox.CSharp2CTP.TThostFtdcOrderStatusType.PartTradedNotQueueing &&... % ���ֳɽ����ڶ�����
        arg.pOrder.OrderStatus ~= QuantBox.CSharp2CTP.TThostFtdcOrderStatusType.Canceled &&... % ����
        arg.pOrder.OrderStatus ~= QuantBox.CSharp2CTP.TThostFtdcOrderStatusType.AllTraded % ȫ���ɽ�
        % ���ñ���
        if (arg.pOrder.Direction == QuantBox.CSharp2CTP.TThostFtdcDirectionType.Buy)
            % ��
            if strcmpi(strtrim(char(arg.pOrder.CombOffsetFlag)), '0') %Open
                AvailableOrderHands_BuyOpen.InstrumentID = AvailableOrderHands_BuyOpen.InstrumentID + arg.pOrder.VolumeTotalOriginal;
            elseif strcmpi(strtrim(char(arg.pOrder.CombOffsetFlag)), '1') %Close
                AvailableOrderHands_BuyClose.InstrumentID = AvailableOrderHands_BuyClose.InstrumentID + arg.pOrder.VolumeTotalOriginal;
            elseif strcmpi(strtrim(char(arg.pOrder.CombOffsetFlag)), '3') %CloseToday
                AvailableOrderHands_BuyCloseToday.InstrumentID = AvailableOrderHands_BuyCloseToday.InstrumentID + arg.pOrder.VolumeTotalOriginal;
            end
        else
            % ����
            if strcmpi(strtrim(char(arg.pOrder.CombOffsetFlag)), '0') %Open
                AvailableOrderHands_SellOpen.InstrumentID = AvailableOrderHands_SellOpen.InstrumentID + arg.pOrder.VolumeTotalOriginal;
            elseif strcmpi(strtrim(char(arg.pOrder.CombOffsetFlag)), '1') %Close
                AvailableOrderHands_SellClose.InstrumentID = AvailableOrderHands_SellClose.InstrumentID + arg.pOrder.VolumeTotalOriginal;
            elseif strcmpi(strtrim(char(arg.pOrder.CombOffsetFlag)), '3') %CloseToday
                AvailableOrderHands_SellCloseToday.InstrumentID = AvailableOrderHands_SellCloseToday.InstrumentID + arg.pOrder.VolumeTotalOriginal;
            end
        end
    elseif arg.pOrder.OrderStatus ~= QuantBox.CSharp2CTP.TThostFtdcOrderStatusType.Canceled ||... % ����
            arg.pOrder.OrderStatus ~= QuantBox.CSharp2CTP.TThostFtdcOrderStatusType.AllTraded % ȫ���ɽ�
        if (arg.pOrder.Direction == QuantBox.CSharp2CTP.TThostFtdcDirectionType.Buy)
            % ��
            if strcmpi(strtrim(char(arg.pOrder.CombOffsetFlag)), '0') %Open
                AvailableOrderHands_BuyOpen.InstrumentID = AvailableOrderHands_BuyOpen.InstrumentID - arg.pOrder.VolumeTotalOriginal;
            elseif strcmpi(strtrim(char(arg.pOrder.CombOffsetFlag)), '1') %Close
                AvailableOrderHands_BuyClose.InstrumentID = AvailableOrderHands_BuyClose.InstrumentID - arg.pOrder.VolumeTotalOriginal;
            elseif strcmpi(strtrim(char(arg.pOrder.CombOffsetFlag)), '3') %CloseToday
                AvailableOrderHands_BuyCloseToday.InstrumentID = AvailableOrderHands_BuyCloseToday.InstrumentID - arg.pOrder.VolumeTotalOriginal;
            end
        else
            % ����
            if strcmpi(strtrim(char(arg.pOrder.CombOffsetFlag)), '0') %Open
                AvailableOrderHands_SellOpen.InstrumentID = AvailableOrderHands_SellOpen.InstrumentID - arg.pOrder.VolumeTotalOriginal;
            elseif strcmpi(strtrim(char(arg.pOrder.CombOffsetFlag)), '1') %Close
                AvailableOrderHands_SellClose.InstrumentID = AvailableOrderHands_SellClose.InstrumentID - arg.pOrder.VolumeTotalOriginal;
            elseif strcmpi(strtrim(char(arg.pOrder.CombOffsetFlag)), '3') %CloseToday
                AvailableOrderHands_SellCloseToday.InstrumentID = AvailableOrderHands_SellCloseToday.InstrumentID - arg.pOrder.VolumeTotalOriginal;
            end
        end
    end


end