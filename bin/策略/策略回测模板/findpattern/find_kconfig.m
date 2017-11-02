function signal = find_kconfig(daydata, inpara)
%%% n����
%%% INPUT
%% daydata : data in a day [���̼� ��߼� ��ͼ� ���̼�]
%% inpara{1} = [ct���� ����Ƶ�� ������������ �ɽ������� �ɽ�����ֵ����]; %% ǰ�����ǽ�����Ҫ �������ǳ���ʹ��
%% inpara{2} = sec_points e.g. [1 75 135 175 215] 
%%
%%% OUTPUT
%% signal.name    =   models{i}.name 
%% signal.inplace =   [ ]         (where to get in) 
%% signal.direct  =   [+1 or -1]   (+1  Buy; -1 Sell)  
%% signal.inprice =   [ ]  

%%% Step 0: INPUT check 
%%% 
amp_down = inpara{1}(3); vol_num = inpara{1}(4); vol_multiple = inpara{1}(5);
freq = inpara{1}(2); 
ave = 0;
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
%% 2.2 Ѱ�� ct ����
k = 0; %% number of the tcd or tci patterns
l1 = 1; 
if freq ~= 1
for i = 1 : n_sample-ct 
    if sampled_day_data(i,3) <  sampled_day_data(i+1,3) %% ct����
        l1 = 1;
        for j = i:i+ct-2
            if sampled_day_data(j,3) >= sampled_day_data(j+1,3) %% ���ڷ����ƣ����ct����������
                l1 = 0; break;
            end
        end
        if l1 && sampled_day_data(i+ct-1,2) == max(sampled_day_data(1:i+ct-1,2)) && ...
                (max(sampled_day_data(i+ct,1),sampled_day_data(i+ct,4)) ==sampled_day_data(i+ct,2) || min(sampled_day_data(i+ct,1),sampled_day_data(i+ct,4)) ==sampled_day_data(i+ct,3))...
                 && sum(daydata(sum(sampled_day_data_size(1:i+ct,1))-vol_num+1:sum(sampled_day_data_size(1:i+ct,1)),5))/vol_num*vol_multiple < daydata(sum(sampled_day_data_size(1:i+ct,1)),5)...
                && sampled_day_data(i+ct-1,2) - min(sampled_day_data(i:i+ct-1,3)) >= amp_down              %% ���l1 == 1˵���ҵ���һ��
          k = k + 1; 
          signal_in_sec(k) = i + ct;  %% ct���������һ��sec�����
          tmp(k) = -1;                 %% �������� +1
        end
    elseif sampled_day_data(i,2) >  sampled_day_data(i+1,2) %% ct��
        l1 = 1;
        for j = i:i+ct-2
            if sampled_day_data(j,2) <= sampled_day_data(j+1,2) %% ���ڷ����ƣ����ct����������
                l1 =0; break;
            end
        end   
        if l1 && sampled_day_data(i+ct-1,3) == min(sampled_day_data(1:i+ct-1,3)) ...
               && (max(sampled_day_data(i+ct,1),sampled_day_data(i+ct,4)) ==sampled_day_data(i+ct,2) || min(sampled_day_data(i+ct,1),sampled_day_data(i+ct,4)) ==sampled_day_data(i+ct,3))...
                 && sum(daydata(sum(sampled_day_data_size(1:i+ct,1))-vol_num+1:sum(sampled_day_data_size(1:i+ct,1)),5))/vol_num*vol_multiple < daydata(sum(sampled_day_data_size(1:i+ct,1)),5)...
                &&   max(sampled_day_data(i:i+ct-1,2))-sampled_day_data(i+ct-1,3) >= amp_down               %% ���l1 == 1˵���ҵ���һ��
          k = k + 1;
          signal_in_sec(k) = i + ct; %% ct�����ĺ�һ��sec�����
          tmp(k) = 1;               %% �������� -1
        end
    end
end
else
 for i = vol_num : n_sample-ct-5 
    if sampled_day_data(i,3) <  sampled_day_data(i+1,3) %% ct����
        l1 = 1;
        for j = i:i+ct-2
            if sampled_day_data(j,3) >= sampled_day_data(j+1,3) %% ���ڷ����ƣ����ct����������
                l1 = 0; break;
            end
        end
        if l1 && sampled_day_data(i+ct-1,2) == max(sampled_day_data(1:i+ct-1,2)) && ...
                (max(sampled_day_data(i+ct,1),sampled_day_data(i+ct,4)) ==sampled_day_data(i+ct,2) || min(sampled_day_data(i+ct,1),sampled_day_data(i+ct,4)) ==sampled_day_data(i+ct,3))...
                 && sum(daydata(sum(sampled_day_data_size(1:i+ct,1))-vol_num+1:sum(sampled_day_data_size(1:i+ct,1)),5))/vol_num*vol_multiple < daydata(sum(sampled_day_data_size(1:i+ct,1)),5)...
                && sampled_day_data(i+ct-1,2) - min(sampled_day_data(i:i+ct-1,3)) >= amp_down              %% ���l1 == 1˵���ҵ���һ��
          k = k + 1; 
          signal_in_sec(k) = i + ct;  %% ct���������һ��sec�����
          tmp(k) = -1;                 %% �������� +1
        end
    elseif sampled_day_data(i,2) >  sampled_day_data(i+1,2) %% ct��
        l1 = 1;
        for j = i:i+ct-2
            if sampled_day_data(j,2) <= sampled_day_data(j+1,2) %% ���ڷ����ƣ����ct����������
                l1 =0; break;
            end
        end   
       if l1 && sampled_day_data(i+ct-1,3) == min(sampled_day_data(1:i+ct-1,3)) ...
               && (max(sampled_day_data(i+ct,1),sampled_day_data(i+ct,4)) ==sampled_day_data(i+ct,2) || min(sampled_day_data(i+ct,1),sampled_day_data(i+ct,4)) ==sampled_day_data(i+ct,3))...
                 && sum(daydata(sum(sampled_day_data_size(1:i+ct,1))-vol_num+1:sum(sampled_day_data_size(1:i+ct,1)),5))/vol_num*vol_multiple < daydata(sum(sampled_day_data_size(1:i+ct,1)),5)...
                &&   max(sampled_day_data(i:i+ct-1,2))-sampled_day_data(i+ct-1,3) >= amp_down               %% ���l1 == 1˵���ҵ���һ��
          k = k + 1;
          signal_in_sec(k) = i + ct; %% ct�����ĺ�һ��sec�����
          tmp(k) = 1;               %% �������� -1
        end
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
          signal.name = 'kconfig'; %% OUTPUT 1 
          signal.inprice = daydata(signal.inplace,1);  %% OUTPUT 4
          return;
  end
end %% k > 0 

    signal = {}; 