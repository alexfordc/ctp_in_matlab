function MT_MACD(stockfts,short,long,Mlen)
% ��������
% MACDͼ��չʾ
% Last Modified by LiYang 2011/12/29
% Email:faruto@163.com
% ����ʵ�ֲ�����ʹ�õ�MATLAB�汾��MATLAB R2011b(7.13)
% ������������������в��ˣ������ȼ����MATLAB�İ汾�ţ��Ƽ�ʹ�ý��°汾��MATLAB��
%% ����������
error(nargchk(1, 4, nargin))
if nargin < 4
    Mlen = 9;
end
if nargin < 3
    long = 26;
end
if nargin < 2
    short = 12;
end
%% ����
Close = fts2mat(stockfts.Close);
DIFF = EMA(Close, short)-EMA(Close, long);
DEA = EMA(DIFF, Mlen);

MACDbar = 2*(DIFF-DEA);

%% Plot
hold on;
pind = find(MACDbar >= 0);
nind = find(MACDbar < 0);
h1 = bar(pind,MACDbar(pind),'r','EdgeColor','r','LineWidth',0.1);
h2 = bar(nind,MACDbar(nind),'g','EdgeColor','g','LineWidth',0.1);

plot(DIFF,'k');
plot(DEA,'b');
