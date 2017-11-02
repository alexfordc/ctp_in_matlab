function SendLimitOrder(Instrument, LimitPrice, Direction, OffsetFlag, VolumeTotalOriginal)
%��ƽ�֣��޼۵�
%<param name="Instrument" type="char">��Լ����.���� 'IF1406'��</param>
%<param name="LimitPrice" type="double">�޼�</param>
%<param name="Direction" type="char">��������.ֻ��'Buy'��'Sell'������ѡ</param>
%<param name="OffsetFlag" type="char">��ƽ��־.��ѡ����'Open'��'Close'(����������ƽ��)��'CloseToday'����������ƽ�񣩡�'CloseYesterday'����������ƽ��</param>
%<param name="VolumeTotalOriginal" type="int">����</param>
%������
% SendLimitOrder('IF1409', 2175, 'buy', 'Open', 2)

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

    global td;
    nRet = td.SendOrder(...
        -1,... %ǿ��ָ����������,-1��ʾ�ɵײ�����
        Instrument,... %��Լ
        direction,... %����
        offset_flag,... %��ƽ���
        '1',... %Ͷ���ױ����,ָ��ΪͶ��
        VolumeTotalOriginal,... %����
        LimitPrice,... %�۸�
        QuantBox.CSharp2CTP.TThostFtdcOrderPriceTypeType.LimitPrice,... %�۸����ͣ��޼�
        QuantBox.CSharp2CTP.TThostFtdcTimeConditionType.GFD,... %ʱ�����ͣ�������Ч
        QuantBox.CSharp2CTP.TThostFtdcContingentConditionType.Immediately,... %������������:����
        0,... % ֹ���
        QuantBox.CSharp2CTP.TThostFtdcVolumeConditionType.AV); %�ɽ�������
    
    if nRet < 0
       disp('�����ύ��CTP��������ʧ����'); 
    end
end
