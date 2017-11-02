function TradeSysIDs = QryTrade(Instrument, Direction, OffsetFlag)
%�鱨��
%<return name="TradeSysIDs" type="cell">������ż���</return>
%<param name="Instrument" type="char">��Լ����.Ϊ''������</param>
%<param name="Direction" type="char">��������.ֻ��'Buy'��'Sell'������ѡ.Ϊ''������</param>
%<param name="OffsetFlag" type="char">��ƽ��־.��ѡ����'Open'��'Close'(����������ƽ��)��'CloseToday'����������ƽ�񣩡�'CloseYesterday'����������ƽ��.Ϊ''������</param>
%{
if nargin ~= 3
    error('������������');
end

direction = QuantBox.CSharp2CTP.TThostFtdcDirectionType.Buy;
if strcmpi(Direction, 'Buy')
    direction = QuantBox.CSharp2CTP.TThostFtdcDirectionType.Buy;
elseif strcmpi(Direction, 'Sell')
    direction = QuantBox.CSharp2CTP.TThostFtdcDirectionType.Sell;
else
    direction = QuantBox.CSharp2CTP.TThostFtdcDirectionType.NIL;
end

offset_flag = QuantBox.CSharp2CTP.TThostFtdcOffsetFlagType.NIL;
if strcmpi(OffsetFlag, 'Open')
    offset_flag = QuantBox.CSharp2CTP.TThostFtdcOffsetFlagType.Open;
elseif strcmpi(OffsetFlag, 'Close')
    offset_flag = QuantBox.CSharp2CTP.TThostFtdcOffsetFlagType.Close;
elseif strcmpi(OffsetFlag, 'CloseToday')
    offset_flag = QuantBox.CSharp2CTP.TThostFtdcOffsetFlagType.CloseToday;
elseif strcmpi(OffsetFlag, 'CloseYesterday')
    offset_flag = QuantBox.CSharp2CTP.TThostFtdcOffsetFlagType.CloseYesterday;
end
       
global td;
TradeSysIDs = td.QueryTrade(Instrument, direction, offset_flag);
%}
end

