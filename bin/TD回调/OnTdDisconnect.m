function OnTdDisconnect(~,arg)
% ��TD�Ͽ��Ļص�

str = sprintf('��TD�Ͽ�,��ǰ����״̬(%s),�������(%d),������Ϣ(%s)', char(arg.step), arg.pRspInfo.ErrorID, char(arg.pRspInfo.ErrorMsg));
disp(str);

end
