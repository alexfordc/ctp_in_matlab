function MT_VolumePlot(stockfts)
% ��������
% �ɽ���ͼ��չʾ
% Last Modified by LiYang 2011/12/29
% Email:faruto@163.com
% ����ʵ�ֲ�����ʹ�õ�MATLAB�汾��MATLAB R2011b(7.13)
% ������������������в��ˣ������ȼ����MATLAB�İ汾�ţ��Ƽ�ʹ�ý��°汾��MATLAB��
%%
len = length(stockfts);

for i = 1:len
    if fts2mat(stockfts(i).Close) >= fts2mat(stockfts(i).Open)
        bar(i,fts2mat(stockfts(i).Volume),'w','EdgeColor','r');
        hold on;
    else
        bar(i,fts2mat(stockfts(i).Volume),'g','EdgeColor','g');
        hold on;
    end
end
