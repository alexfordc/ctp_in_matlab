function signal = find_reversal(daydata, inpara) 
%%% ����ͻ�� (һ��һ�ν�����)
%%% INPUT
%% hisdata : data in yesterday [���̼� ��߼� ��ͼ� ���̼�]
%% daydata : data in today  [���̼� ��߼� ��ͼ� ���̼�]
%% inpara{1} = [���೬������ ���ճ�������]; %% 
%% inpara{2} = sec_points; %% [1 75 135 175 215];
%%
%%% OUTPUT
%% signal.name =            STRING 
%% signal.inplace =  []     VECTOR
%% signal.direct  =  []     BOOL +1 or -1
%% signal.inprcie =  []     VECTOR

%%% Step 0: INPUT check 
%%%  

p1 = inpara{1}(1); p2 = inpara{1}(2); 

len_day = inpara{2}(end); 

%%% Step 1: Compute amplitude 

%%% Step 2:  Find amplitude break point. 

k = 0; 

    if daydata(76,2) - daydata(75,2) >= p1  
        k = k+1;
        signal.inplace(k) = 77;       %% OUTPUT 2 
        signal.direct(k) = -1;       %% OUTPUT 3 +1
        signal.inprice(k) = daydata(77,1); %% OUTPUT 4
        signal.break(k) = 77;
        
    elseif daydata(75,3) - daydata(76,3) >= p2
        k = k+1;
        signal.inplace(k) = 77;       %% OUTPUT 2 
        signal.direct(k) = +1;       %% OUTPUT 3 -1
        signal.inprice(k) = daydata(77,1); %% OUTPUT 4
        signal.break(k) = 77;

    end
    
  
%% Step 3: ͳ��Ѱ�ҵ����ź� 
if k > 0
    signal.name = 'reversal';  %% OUTPUT 1 
else
    signal = {}; 
 end
