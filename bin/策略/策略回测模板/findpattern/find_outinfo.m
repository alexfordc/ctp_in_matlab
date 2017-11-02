function signal = find_outinfo(hisdata, daydata, inpara)
%%% ��������ģ�� 
%%% INPUT
%% daydata : data in a day [���̼� ��߼� ��ͼ� ���̼�]
%% inpara{1} = '��ͭ����.xlsx';   %%        e.g. 'tcdtci'  [�������� ����Ƶ��]
%% inpara{2} = sec_points e.g. [1 75 135 175 215]  or   [1 75 135 225]
%% inpara{3} = [a b g];  %% [����ְٷֱ�  ���ղְٷֱ�  ������]
%%% OUTPUT
%% signal.name    =   models{i}.name 
%% signal.inplace =   [ ]         (where to get in) 
%% signal.direct  =   [+1 or -1]   (+1  Buy; -1 Sell)  
%% signal.inprice =   [ ]  

global i_day %% �˽⵱ǰ���е��ǵڼ��������

%% Step 1 : ��һ��ģ�Ͳ�����
if i_day ==1 || i_day == length(inpara{1}) / 2 + 1
    signal = {}; 
    return;
end 
i1 =  (i_day-1) * 2 ;
i2 =  (i_day-1) * 2 + 1; 

yes_out = inpara{1}(i1); 
tod_out = inpara{1}(i2);

%% Step 2 : �������û��������Ϣ��ģ��Ҳ������
if isnan(yes_out) || isnan(tod_out)
        signal = {}; 
end
    
%% Step 3 : Ѱ���볡�ź�
len_day = inpara{2}(end); 
a = inpara{3}(1); %% ����ְٷֱ� 
b = inpara{3}(2); %% ����ְٷֱ�
g = inpara{3}(3); %% ������

amp1 = (tod_out - yes_out) / yes_out;                         %% �����ǵ���
amp2 = (daydata(135,4) - hisdata(215,4)) / hisdata(215,4);    %% �����ǵ���
amp = max(daydata(:,2)) - min(daydata(:,3)) / daydata(135,4); %% �����������
sig = amp1 -amp2; 

if sig > a  &&  amp > g
    signal.name = 'outinfo';
    signal.inplace(1) = 136;
    signal.direct(1) = 1; 
    signal.inprice(1) = daydata(135,4);
    return; 
elseif sig < b  &&  amp > g
    signal.name = 'outinfo';
    signal.inplace(1) = 136;
    signal.direct(1) = -1; 
    signal.inprice(1) = daydata(135,4);
    return;
end

signal = {}; 






