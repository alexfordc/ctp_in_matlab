function OnMdConnect(~, arg)

% ����״̬��Logined�ͱ�ʾ��¼�ɹ�
if arg.result == QuantBoxCSharp.ConnectionStatus.Logined
    disp('�ɹ���¼���������');
end

end
