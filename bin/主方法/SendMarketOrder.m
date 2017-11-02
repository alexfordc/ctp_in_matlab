function SendMarketOrder(Instrument, Direction, OffsetFlag, VolumeTotalOriginal)
%��ƽ�֣��м۵�     ģ�����ݲ�֧���м۵�
%<param name="Instrument" type="char">��Լ����.���� 'IF1406'��</param>
%<param name="Direction" type="char">��������.ֻ��'Buy'��'Sell'������ѡ</param>
%<param name="OffsetFlag" type="char">��ƽ��־.��ѡ����'Open'��'Close'(����������ƽ��)��'CloseToday'����������ƽ�񣩡�'CloseYesterday'����������ƽ��</param>
%<param name="VolumeTotalOriginal" type="int">����</param>
%������
% SendMarketOrder('IF1409', 'buy', 'Open', 2);

    direction = QuantBox.CSharp2CTP.TThostFtdcDirectionType.Buy;
    price = 0.0;
    global MaxP; %��ͣ��
    global MinP; %��ͣ��
    if strcmpi(Direction, 'buy')
        direction = QuantBox.CSharp2CTP.TThostFtdcDirectionType.Buy;
        if isfield(MaxP, Instrument)
            price = getfield(MaxP, Instrument);
        else
            error('��Լ��������');
        end
    elseif strcmpi(Direction, 'sell')
        direction = QuantBox.CSharp2CTP.TThostFtdcDirectionType.Sell;
        if isfield(MinP, Instrument)
            price = getfield(MinP, Instrument);
        else
            error('��Լ��������');
        end
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
        price,... %�۸�
        QuantBox.CSharp2CTP.TThostFtdcOrderPriceTypeType.AnyPrice,... %�۸����ͣ������
        QuantBox.CSharp2CTP.TThostFtdcTimeConditionType.IOC,... %��Ч�����ͣ�������ɣ�������
        QuantBox.CSharp2CTP.TThostFtdcContingentConditionType.Immediately,... %������������:����
        0,... % ֹ���
        QuantBox.CSharp2CTP.TThostFtdcVolumeConditionType.AV); %�ɽ�������
    
    if nRet < 0
       disp('�����ύ��CTP��������ʧ����'); 
    end
end

