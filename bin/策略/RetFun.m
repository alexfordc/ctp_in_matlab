function [ret,lret,cost] = RetFun( bp, sp, bs, Num, Lots)
%% �����ֻ������ʼ��㣨��ȥ�ɱ���
% ˫���շѣ�����ƽ�ֶ���ȡ��
% ��������������ˣ�
% ���8���㣻
% ���ӷ������
%%�ɱ�������
% �ֻ�������
%      ��֤�� ��   4.6��15,000��1��8% =5520Ԫ 
%       ����������  ����ʱ�� 4.6��15,000��1��0.8�� = 55.2Ԫ 
%                    ƽ��ʱ�� 7��15,000��1��0.8�� = 84Ԫ 
%       ���ڷѣ�    4.6��15,000��1��0.2���3���죩 = 41.4Ԫ 
% ���̶�8���㡣��120Ԫ��
% ���ӷѵ�����Ϊ��Ȼ�գ������賿4�����1��

%retΪ������,lretΪӯ�����
if nargin<3
    bs=ones(size(bp)); %Ĭ��Ϊ���룬����bs=-1
end

if nargin<4
    Num=ones(size(bp));
end

if nargin<5
    Lots=ones(size(bp));
end


St=15; %1��׼��Ϊ15KG
Lev=12.5; %�ܸ�12.5��
Fee=0.08/100; %��������ˣ�˫����ȡ
Def=0.02/100* Num; %���ӷ������������
Spe=8*15*Lots; %1�ֵ��Ϊ8���㣬��120Ԫ
costFee=(sp*Fee+bp*Fee)*St.*Lots;
costDef=bp.*Def*St.*Lots;
cost=[costFee;costDef;Spe];

% ret=((sp-bp)*St.*Lots.*bs-(sp*Fee+bp*Fee+bp.*Def)*St.*Lots-Spe)./(bp*St.*Lots)*Lev;
ret=((sp-bp)*St*bs)/(bp*St*Lots)*Lev;
lret=(sp-bp)*St.*Lots.*bs-(sp*Fee+bp*Fee+bp.*Def)*St.*Lots-Spe;

end

