function OnTdConnect(sender,arg)
% �������ӻر�

% ����״̬��Confirmed�ͱ�ʾ��¼��ȷ�ϳɹ�
if arg.result == QuantBox.CSharp2CTP.ConnectionStatus.Logined
    %% ��ʼ��ȫ�ֱ���
    Types;
    ReqQryDepthMarketData();
    disp('�ɹ���¼���׷�����')
end

end
