function SendContingentOrder(Instrument, LimitPrice, Direction, OffsetFlag, VolumeTotalOriginal, ContingentCondition, StopPrice)
%��ƽ�֣�������/������
%<param name="Instrument" type="char">��Լ����.���� 'IF1406'��</param>
%<param name="LimitPrice" type="double">�µ��۸񣺽����µ�����Ϊ'LimitPrice'ʱ��Ч</param>
%<param name="Direction" type="char">��������.ֻ��'Buy'��'Sell'������ѡ</param>
%<param name="OffsetFlag" type="char">��ƽ��־.��ѡ����'Open'��'Close'(����������ƽ��)��'CloseToday'����������ƽ�񣩡�'CloseYesterday'����������ƽ��</param>
%<param name="VolumeTotalOriginal" type="int">����</param>
%<param name="ContingentCondition" type="int">������������,��ѡ���� 1������ 2:ֹ�� 3:ֹӮ 4��Ԥ�� 5:���¼۴��������� 6:���¼۴��ڵ��������� 7:���¼�С�������� 8:���¼�С�ڵ��������� 9:��һ�۴��������� 10:��һ�۴��ڵ��������� 
                                                                    % 11:��һ��С�������� 12:��һ��С�ڵ��������� 13:��һ�۴��������� 14:��һ�۴��ڵ��������� 15:��һ��С�������� 16:��һ��С�ڵ���������</param>
%<param name="StopPrice" type="double">ֹ���</param>
%������
% SendContingentOrder('IF1412', 2000, 'sell', 'open', 3, 1, 2100);

    direction = QuantBox.CSharp2CTP.TThostFtdcDirectionType.Buy;
    if strcmpi(Direction, 'buy')
        direction = QuantBox.CSharp2CTP.TThostFtdcDirectionType.Buy;
    elseif strcmpi(Direction, 'sell')
        direction = QuantBox.CSharp2CTP.TThostFtdcDirectionType.Sell;
    else
        error('��ָ����ȷ����������char���ͣ�ֻ��"Buy"��"Sell"������ѡ');
    end
    
    offset_flag = '0';
    if strcmpi(OffsetFlag, 'open')
        offset_flag = '0';
    elseif strcmpi(OffsetFlag, 'close')
        offset_flag = '1';
    elseif strcmpi(OffsetFlag, 'closetoday')
        offset_flag = '3';
    elseif strcmpi(OffsetFlag, 'closeyesterday')
        offset_flag = '4';
    else
        error('��ָ����ȷ�Ŀ�ƽ��־:char���ͣ���ѡ����"Open"��"Close"��"CloseToday"��"CloseYesterday"');
    end

    contingent_condition = QuantBox.CSharp2CTP.TThostFtdcContingentConditionType.Immediately;
    if ContingentCondition == 1
        contingent_condition = QuantBox.CSharp2CTP.TThostFtdcContingentConditionType.Immediately;
    elseif ContingentCondition == 2
        contingent_condition = QuantBox.CSharp2CTP.TThostFtdcContingentConditionType.Touch;
    elseif ContingentCondition == 3
        contingent_condition = QuantBox.CSharp2CTP.TThostFtdcContingentConditionType.TouchProfit;
    elseif ContingentCondition == 4
        contingent_condition = QuantBox.CSharp2CTP.TThostFtdcContingentConditionType.ParkedOrder;
    elseif ContingentCondition == 5
        contingent_condition = QuantBox.CSharp2CTP.TThostFtdcContingentConditionType.LastPriceGreaterThanStopPrice;
    elseif ContingentCondition == 6
        contingent_condition = QuantBox.CSharp2CTP.TThostFtdcContingentConditionType.LastPriceGreaterEqualStopPrice;
    elseif ContingentCondition == 7
        contingent_condition = QuantBox.CSharp2CTP.TThostFtdcContingentConditionType.LastPriceLesserThanStopPrice;
    elseif ContingentCondition == 8
        contingent_condition = QuantBox.CSharp2CTP.TThostFtdcContingentConditionType.LastPriceLesserEqualStopPrice;
    elseif ContingentCondition == 9
        contingent_condition = QuantBox.CSharp2CTP.TThostFtdcContingentConditionType.AskPriceGreaterThanStopPrice;
    elseif ContingentCondition == 10
        contingent_condition = QuantBox.CSharp2CTP.TThostFtdcContingentConditionType.AskPriceGreaterEqualStopPrice;
    elseif ContingentCondition == 11
        contingent_condition = QuantBox.CSharp2CTP.TThostFtdcContingentConditionType.AskPriceLesserThanStopPrice;
    elseif ContingentCondition == 12
        contingent_condition = QuantBox.CSharp2CTP.TThostFtdcContingentConditionType.AskPriceLesserEqualStopPrice;
    elseif ContingentCondition == 13
        contingent_condition = QuantBox.CSharp2CTP.TThostFtdcContingentConditionType.BidPriceGreaterThanStopPrice;
    elseif ContingentCondition == 14
        contingent_condition = QuantBox.CSharp2CTP.TThostFtdcContingentConditionType.BidPriceGreaterEqualStopPrice;
    elseif ContingentCondition == 15
        contingent_condition = QuantBox.CSharp2CTP.TThostFtdcContingentConditionType.BidPriceLesserThanStopPrice;    
    elseif ContingentCondition == 16
        contingent_condition = QuantBox.CSharp2CTP.TThostFtdcContingentConditionType.BidPriceLesserEqualStopPrice;  
    else
        error('������Ϸ��Ĵ�����������');
    end
        
    
    global td;
    nRet = td.SendOrder(...
        -1,... %ǿ��ָ����������,-1��ʾ�ɵײ�����
        Instrument,... %��Լ
        direction,... %����
        offset_flag,... %��ƽ���
        '1',... %Ͷ���ױ����,ָ��ΪͶ��
        VolumeTotalOriginal,... %����
        LimitPrice,... %�۸�
        QuantBox.CSharp2CTP.TThostFtdcOrderPriceTypeType.LimitPrice,... %�µ����ͣ��޼�
        QuantBox.CSharp2CTP.TThostFtdcTimeConditionType.GFD,... %��Ч�����ͣ�������Ч
        contingent_condition,...
        StopPrice,... % ֹ���
        QuantBox.CSharp2CTP.TThostFtdcVolumeConditionType.AV); %�ɽ�������
    
    if nRet < 0
       disp('�����ύ��CTP��������ʧ����'); 
    end
end

%����
%<param name="OrderPriceType" type="char">�µ����ͣ���ѡ����'AnyPrice'��'LimitPrice'��'LastPrice'��'BidPrice1'��'AskPrice1'</param>
%<param name="VolumeCondition" type="char">�ɽ�������:"AV"��ʾ�κ�������"MV"��ʾ��С������"CV"��ʾȫ������</param>