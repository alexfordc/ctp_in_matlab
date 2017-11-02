%{
global t;
t = timer('Period', 2,  'ExecutionMode','fixedRate','TimerFcn',@Wudian_Strategy);
start( t );
%}

Types;
if ~isfield(NPrice, 'IF1408') || ~isfield(TLPos, 'IF1408')
    return;
end

if NPrice.IF1408 < 2330 %IF1408�����¼۵���2330
    trade_list = QryTrade('IF1408','buy','Open');
    if strcmpi(trade_list, '') %IF1408û���򿪵ĳɽ���
        availabe_orders = QryOrder('Available', 'IF1408','buy','');
        if strcmpi(availabe_orders, '') %û�п��õ�
            SendLimitOrder('IF1408', 2330, 'buy','open',1);
        else %�п��õ�
            CancelOrder(availabe_orders);
        end
    end
end
