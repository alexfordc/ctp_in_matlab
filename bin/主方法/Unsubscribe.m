function  Unsubscribe(Instruments , Period)
% ȡ������Ķ��ġ�  ���instrumentsΪ�գ���ȡ����������Ķ��ġ�

global md;

if nargin == 0
    md.Unsubscribe('all', 'all');
    return;
elseif nargin == 1
    md.Unsubscribe(Instruments, 'all');
    return;
else
    md.Unsubscribe(Instruments, Period);
end


end

