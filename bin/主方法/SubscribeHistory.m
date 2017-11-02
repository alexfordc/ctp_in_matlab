function SubscribeHistory(Instruments, Period, beginTime, endTime)
%������ʷ����
%<param name="Instruments" type="char">��Լ����.���� 'IF1406,IF1408,IF1409'��</param>
%<param name="Period" type="char">���ĵ�����ļ���,��'Tick1','Second10','Minute1','Minute5','Minute15','Minute30'�ȿ�ѡ</param>
%<param name="beginTime" type="char">ģ��'20140804 10:00:00'��д</param>
%<param name="endTime" type="char">ģ��'20140804 11:00:00'��д</param>
%������
% SubscribeHistory('IF1408', 'Tick1', '20140804 10:50:00', '20140804 11:00:00');

    import QuantBox.CSharp2CTP.*;
    barLen = BarLength.Tick1;
    if strcmpi(Period, 'tick1')
        barLen = BarLength.Tick1;
    elseif strcmpi(Period, 'second10')
        barLen = BarLength.Second10;
    elseif strcmpi(Period, 'Minute1')
        barLen = BarLength.Minute1;
    elseif strcmpi(Period, 'Minute5')
        barLen = BarLength.Minute5;
    elseif strcmpi(Period, 'Minute15')
        barLen = BarLength.Minute15;
    elseif strcmpi(Period, 'Minute30')
        barLen = BarLength.Minute30;
    else
        error('���ĵ�����ļ���,��"Tick1","Second10","Minute1","Minute5","Minute15","Minute30"�ȿ�ѡ');
    end
    
    global KLineOfAllInstruments;
    KLineOfAllInstruments = setfield(KLineOfAllInstruments, Instruments, {});
    global md;
    md.SubscribeHistory(Instruments, barLen, beginTime, endTime);
end
