function OnMdDisconnect(~, arg)
% ������߻ر�
str = sprintf('��MD�Ͽ�,��ǰ����״̬(%s),�������(%d),������Ϣ(%s)', char(arg.step), arg.pRspInfo.ErrorID, char(arg.pRspInfo.ErrorMsg));
disp(str);

end
