function CancelOrder(Instrument, Direction, OffsetFlag)
%����
%<param name="Instrument" type="char">��Լ����.</param>
%<param name="Direction" type="char">��������.ֻ��'Buy'��'Sell'������ѡ.</param>
%<param name="OffsetFlag" type="char">��ƽ��־.��ѡ����'Open'��'Close'(����������ƽ��)��'CloseToday'����������ƽ�񣩡�'CloseYesterday'����������ƽ��.</param>

global td;
if nargin == 0
    td.CancelOrder('', '', '');
elseif nargin == 1
        td.CancelOrder(Instrument, '', '');
elseif nargin >= 2
    direction = QuantBox.CSharp2CTP.TThostFtdcDirectionType.Buy;
    if strcmpi(Direction, 'Buy')
        direction = QuantBox.CSharp2CTP.TThostFtdcDirectionType.Buy;
    elseif strcmpi(Direction, 'Sell')
        direction = QuantBox.CSharp2CTP.TThostFtdcDirectionType.Sell;
    else
        direction = QuantBox.CSharp2CTP.TThostFtdcDirectionType.NIL;
    end
    if nargin == 2
        td.CancelOrder(Instrument, direction, '');
    else
        td.CancelOrder(Instrument, direction, OffsetFlag);
    end
end

end