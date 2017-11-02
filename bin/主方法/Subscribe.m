function Subscribe(Instruments , Period)
%����ʵʱ����
%<param name="Instruments" type="char">��Լ����.���� 'IF1406,IF1408,IF1409'.Ĭ��'all'</param>
%<param name="Period" type="char">����.����'tick','6s','8m','1h'.Ĭ��'tick'</param>
%���� 
%Subscribe('IF1409,IF1410', 'tick,6s')
%Subscribe('all', '5s')

global md;
inst = 'all';
per = 'tick';
if nargin == 0
    md.Subscribe(inst, per);
    return;
elseif nargin == 1
    md.Subscribe(Instruments, per);
    return;
else
    md.Subscribe(Instruments, Period);
end

end