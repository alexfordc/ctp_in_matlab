function signal = find_measure(daydata, inpara) 
%%% С��ģ��  (��Ӧ�����볡����)
%%% INPUT
%% hisdata : data in yesterday [���̼� ��߼� ��ͼ� ���̼�]
%% daydata : data in today  [���̼� ��߼� ��ͼ� ���̼�]
%% inpara{1} = [������� ���� �źŴ�����ʼ �źŴ��ڽ��� ������ʼ ��������]; 
%% inpara{2} = sec_points; %% [1 75 135 175 215];
%%
%%% OUTPUT
%% signal.name =            STRING 
%% signal.inplace =  []     VECTOR
%% signal.direct  =  []     BOOL +1 or -1
%% signal.inprcie =  []     VECTOR

%%% Step 0: INPUT check 
%%%  
range = inpara{1}(1); slip = inpara{1}(2); 
m = inpara{1}(3); n = inpara{1}(4); 
p = inpara{1}(5); q = inpara{1}(6);
len_day = inpara{2}(end); 
have =0;

%%% Step 1: judge the range of the day break 
if  daydata(m,1) - daydata(n,4) > range  %% ʵ�� = m�п��̼� - n�����̼� 
    have = -1;
elseif daydata(n,4) - daydata(m,1) > range
    have = 1;
end

%%% Step 2:  Find range break point. 
k = 0; 

    if  have == 1 
        k = k+1;
        signal.inplace(k) = p;       %% OUTPUT 2 
        signal.direct(k) = +1;       %% OUTPUT 3
        signal.inprice(k) = daydata(p,1) + slip; %% OUTPUT 4
        
    elseif have == -1
        k = k+1;
        signal.inplace(k) = p;       %% OUTPUT 2 
        signal.direct(k) = -1;       %% OUTPUT 3
        signal.inprice(k) = daydata(p,1) - slip; %% OUTPUT 4   

    end
    
%% Step 3: ͳ��Ѱ�ҵ����ź� 
if k > 0
    signal.name = 'measure';  %% OUTPUT 1 
else
    signal = {}; 
end
 




