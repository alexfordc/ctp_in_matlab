function signal = find_ncucd(daydata, inpara)
%%% n����������
%%% INPUT
%% daydata : data in a day [���̼� ��߼� ��ͼ� ���̼�]
%% inpara{1} = [�������������� ����Ƶ�� ֹ��� �������� ���� ]; %% ǰ�����ǽ�����Ҫ �������ǳ���ʹ��
%% inpara{2} = sec_points e.g. [1 75 135 175 215] 
%%
%%% OUTPUT
%% signal.name    =   models{i}.name 
%% signal.inplace =   [ ]         (where to get in) 
%% signal.direct  =   [+1 or -1]   (+1  Buy; -1 Sell)  
%% signal.inprice =   [ ]  

%%% Step 0: INPUT check 
%%% 

freq = inpara{1}(2); 
%%% Step 1: Sampling by ����Ƶ��
sec_points = inpara{2}; %% [1 75 135 175 215];  
n_sample = 0; 
for j = 1 : length(sec_points) - 1
    %% 1.1 sampling from the daydata
    if j == 1
        section{j} = daydata(sec_points(j):sec_points(j+1),:); 
    else
        section{j} = daydata(sec_points(j)+1:sec_points(j+1),:);  
    end
    %% n_sec(i,1) = sec_points(j) - sec_points(j+1);
    [sec{j} sec_num{j}]= sample_k(section{j},freq);
    %% 1.2 collect the sampled data 
    sampled_day_data(n_sample+1 : n_sample+length(sec_num{j}),:) = sec{j};
    sampled_day_data_size(n_sample+1 : n_sample+length(sec_num{j}),1) = sec_num{j}; 
    n_sample = n_sample + length(sec_num{j});
end

%%% Step 2: Find Pattern by ��������
ct = inpara{1}(1);  %% ��������
%% 2.1 Ԥ���ж�
if n_sample <= ct 
    signal = {};
    return; 
end
%% 2.2 Ѱ�� ct ����������
k = 0; %% number of the tcd or tci patterns
l1 = 1; 
for i = 1 : n_sample-ct+1 
    if sampled_day_data(i,1) <  sampled_day_data(i,4) %% ct����  ���� < ���� 
        l1 = 1;
        for j = i:i+ct-1
            if sampled_day_data(j,1) >= sampled_day_data(j,4) %% ���ڷ����ƣ����ct����������
                l1 = 0; break;
            end
        end
        if l1 %% ���l1 == 1˵���ҵ���һ��
          k = k + 1; 
          signal_in_sec(k) = i + ct - 1;  %% ct���������һ��sec�����
          tmp(k) = 1; 
        end
    elseif sampled_day_data(i,1) >  sampled_day_data(i,4) %% ct����  ���� > ����
        l1 = 1;
        for j = i:i+ct-1
            if sampled_day_data(j,1) <= sampled_day_data(j,4) %% ���ڷ����ƣ����ct����������
                l1 =0; break;
            end
        end   
        if l1 %% ���l1 == 1˵���ҵ���һ��
          k = k + 1;
          signal_in_sec(k) = i + ct - 1; %% ct�����ĺ�һ��sec�����
          tmp(k) = -1; 
        end
    end
end

%%% Step 3: �ж��Ƿ���ڽ����㣬����������ڳ���ǰ�����е�λ��(inplace)�ͷ���(direct)
if k > 0
t = 0; 
  for i = 1:k 
    if signal_in_sec(i) < n_sample
        t = t+1;
        signal.inplace(t) = sum(sampled_day_data_size(1:signal_in_sec(i))) + 1;  %% OUTPUT 2
        signal.direct(t) = tmp(t);    %% OUTPUT 3
    end
  end %%  for i = 1:k 
  
  if t > 0
       signal.name = 'ncucd'; %% OUTPUT 1 
       signal.inprice = daydata(signal.inplace,1);  %% OUTPUT 4
       return;
  end
end %% k > 0 

    signal = {}; 