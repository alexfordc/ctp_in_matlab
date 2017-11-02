function OrderSysIDs = QryOrder(AllorAvailable, Instrument, Direction, OffsetFlag)
%�鱨��
%<return name="OrderSysIDs" type="cell">������ż���</return>
%<param name="AllorAvailable" type="char">�����б������ǲ���õ�.ֻ��'All'��'Available'��ѡ</param>
%<param name="Instrument" type="char">��Լ����.Ϊ''������</param>
%<param name="Direction" type="char">��������.ֻ��'Buy'��'Sell'������ѡ.Ϊ''������</param>
%<param name="OffsetFlag" type="char">��ƽ��־.��ѡ����'Open'��'Close'(����������ƽ��)��'CloseToday'����������ƽ�񣩡�'CloseYesterday'����������ƽ��.Ϊ''������</param>
%{
if nargin ~= 4
    error('������������');
end

order_type = QuantBox.CSharp2CTP.OrderType.E_all;
if ~strcmpi(AllorAvailable, 'All')
    order_type = QuantBox.CSharp2CTP.OrderType.E_available;
end

direction = QuantBox.CSharp2CTP.TThostFtdcDirectionType.Buy;
if strcmpi(Direction, 'Buy')
    direction = QuantBox.CSharp2CTP.TThostFtdcDirectionType.Buy;
elseif strcmpi(Direction, 'Sell')
    direction = QuantBox.CSharp2CTP.TThostFtdcDirectionType.Sell;
else
    direction = QuantBox.CSharp2CTP.TThostFtdcDirectionType.NIL;
end

global td;
OrderSysIDs = td.QueryOrder(order_type, Instrument, direction, OffsetFlag);
%}
end

