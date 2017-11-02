function signal = find_hdli(daydata, inpara)
%%% ���иߺ����е� (���÷��������ޣ��ɽ�������)
%%% INPUT
%% daydata : data in a day [���̼� ��߼� ��ͼ� ���̼� �ɽ���]
%% inpara{1} = [����Ƶ�� �����ǵ�K���� ��������lim_up ��������lim_down �ɽ�����ֵ����m ����c]; 
%% inpara{2} = sec_points e.g. [1 75 135 175 215] 
%%
%%% OUTPUT
%% signal.name    =   models{i}.name 
%% signal.inplace =   [ ]         (where to get in) 
%% signal.direct  =   [+1 or -1]   (+1  Buy; -1 Sell)  
%% signal.inprice =   [ ]  

%%% Step 0: INPUT check 
%%% 
freq = inpara{1}(1);   ct = inpara{1}(2); lim_up = inpara{1}(3); lim_down = inpara{1}(4); 
m = inpara{1}(5); c = inpara{1}(6);
len_day = inpara{2}(end);

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

%%% Step 2: Find Pattern 
%% 2.1 Ԥ���ж�
if n_sample <= ct 
    signal = {};
    return; 
end
%% 2.2 Ѱ�������������볡������ʼ��
k = 0; %% number of the tcd or tci patterns
l1 = 1; 
for i = 1 : (n_sample-ct-1) 
    if sampled_day_data(i,2) <  sampled_day_data(i+1,2) %% ��߼۵���
        l1 = 1;
        for j = i+1:i+ct-1
            if sampled_day_data(j,2) >= sampled_day_data(j+1,2) %% ���ڷ����ƣ����ct����������
                l1 = 0;break;
            end
        end
        if l1 %% i��i+ct����
            temp = sampled_day_data(i+ct,2) - sampled_day_data(i,3);   %% ct�������ۼ�����
            ave = sum(sampled_day_data(i:i+ct,5))/(ct+1);  %% ct+1��K�ߵ�ƽ���ɽ���
            if temp <= lim_up  && temp >= lim_down && sampled_day_data(i+ct,5) >= m*ave
                k = k + 1;
                begin(k) = sum(sampled_day_data_size(1:i+ct)) + 1;  %% ct�����������볡����ʼ��
                inprice(k) = sampled_day_data(i+ct,3) + c; %% �ҵ��۸�
                tmp(k) = 1;                %% �������� -1
            end
        end
    elseif sampled_day_data(i,3) >  sampled_day_data(i+1,3) %% ��ͼ۵ݼ�
        l1 = 1;
        for j = i+1:i+ct-1
            if sampled_day_data(j,3) <= sampled_day_data(j+1,3) %% ���ڷ����ƣ����ct����������
                l1 =0; break;
            end
        end
        if l1 %% i��i+ct�ݼ�
            temp = sampled_day_data(i,3) - sampled_day_data(i+ct,3);   %% ct�������ۼƼ���
            ave = sum(sampled_day_data(i:i+ct,5))/(ct+1);  %% ct+1��K�ߵ�ƽ���ɽ���
            if temp <= lim_up  && temp >= lim_down && sampled_day_data(i+ct,5) >= m*ave
                k = k + 1;
                begin(k) = sum(sampled_day_data_size(1:i+ct)) + 1;  %% ct�����������볡����ʼ��
                inprice(k) = sampled_day_data(i+ct,2) - c; %% �ҵ��۸�
                tmp(k) = -1;               %% �������� +1
            end
        end
    end
end
 
%%% Step 3: �ж��Ƿ���ڽ����㣬����������ڳ���ǰ�����е�λ��(inplace)�ͼ۸�(inprice)
if k > 0   
   t = 0;
   for i = 1:k
       if tmp(i) == 1
           if daydata(begin(i),3) > inprice(i) && begin(i)~=len_day %% ����ʱ��������
               t = t+1;
               signal.inplace(t) = begin(i);   %% OUTPUT 2
               signal.direct(t) = tmp(i);      %% OUTPUT 3
               signal.inprice(t) = daydata(begin(i),1);  %% OUTPUT 4
               continue;
           elseif daydata(begin(i),3) <= inprice(i) && daydata(begin(i),2) >= inprice(i) && begin(i)~=len_day 
               t = t+1;
               signal.inplace(t) = begin(i);   %% OUTPUT 2
               signal.direct(t) = tmp(i);      %% OUTPUT 3
               signal.inprice(t) = inprice(i);  %% OUTPUT 4
               continue;
           else
               if i < k
                   for r = (begin(i)+1):begin(i+1)  %% ����һ���ӵ����źŵ���ʼ������
                       if daydata(r,3) > inprice(i) && r~=len_day %% ����ʱ��������
                          t = t+1;
                          signal.inplace(t) = r;          %% OUTPUT 2
                          signal.direct(t) = tmp(i);      %% OUTPUT 3
                          signal.inprice(t) = daydata(r,1);  %% OUTPUT 4
                          break;
                       elseif daydata(r,3) <= inprice(i) && daydata(r,2) >= inprice(i) && r~=len_day
                          t = t+1;
                          signal.inplace(t) = r;          %% OUTPUT 2
                          signal.direct(t) = tmp(i);      %% OUTPUT 3
                          signal.inprice(t) = inprice(i);  %% OUTPUT 4
                          break;
                       end
                   end
               elseif i == k
                   for r = (begin(k)+1):(len_day-1)
                       if daydata(r,3) > inprice(i) && r~=len_day %% ����ʱ��������
                          t = t+1;
                          signal.inplace(t) = r;          %% OUTPUT 2
                          signal.direct(t) = tmp(i);      %% OUTPUT 3
                          signal.inprice(t) = daydata(r,1);  %% OUTPUT 4
                          break;
                       elseif daydata(r,3) <= inprice(i) && daydata(r,2) >= inprice(i) && r~=len_day
                          t = t+1;
                          signal.inplace(t) = r;          %% OUTPUT 2
                          signal.direct(t) = tmp(i);      %% OUTPUT 3
                          signal.inprice(t) = inprice(i);  %% OUTPUT 4
                          break;
                       end
                   end
               end  %% ��һ����δ�볡���������
           end %% ����ʱ���������:���ո߿�,�����볡�ۣ��������
       
       elseif tmp(i) == -1
           if daydata(begin(i),2) < inprice(i) && begin(i)~=len_day %% ����ʱ��������
               t = t+1;
               signal.inplace(t) = begin(i);   %% OUTPUT 2
               signal.direct(t) = tmp(i);      %% OUTPUT 3
               signal.inprice(t) = daydata(begin(i),1);  %% OUTPUT 4
               continue;
           elseif daydata(begin(i),2) >= inprice(i) && daydata(begin(i),3) <= inprice(i) && begin(i)~=len_day
               t = t+1;
               signal.inplace(t) = begin(i);   %% OUTPUT 2
               signal.direct(t) = tmp(i);      %% OUTPUT 3
               signal.inprice(t) = inprice(i);  %% OUTPUT 4
               continue;
           else
               if i < k
                   for r = (begin(i)+1):begin(i+1)  %% ����һ���ӵ����źŵ���ʼ������
                       if daydata(r,2) < inprice(i) && r~=len_day %% ����ʱ��������
                          t = t+1;
                          signal.inplace(t) = r;          %% OUTPUT 2
                          signal.direct(t) = tmp(i);      %% OUTPUT 3
                          signal.inprice(t) = daydata(r,1);  %% OUTPUT 4
                          break;
                       elseif daydata(r,2) >= inprice(i) && daydata(r,3) <= inprice(i) && r~=len_day
                          t = t+1;
                          signal.inplace(t) = r;          %% OUTPUT 2
                          signal.direct(t) = tmp(i);     %% OUTPUT 3
                          signal.inprice(t) = inprice(i);  %% OUTPUT 4
                          break;
                       end
                   end
               elseif i == k
                   for r = (begin(k)+1):(len_day-1)
                       if daydata(r,2) < inprice(i) && r~=len_day %% ����ʱ��������
                          t = t+1;
                          signal.inplace(t) = r;         %% OUTPUT 2
                          signal.direct(t) = tmp(i);      %% OUTPUT 3
                          signal.inprice(t) = daydata(r,1);  %% OUTPUT 4
                          break;
                       elseif daydata(r,2) >= inprice(i) && daydata(r,3) <= inprice(i) && r~=len_day
                          t = t+1;
                          signal.inplace(t) = r;          %% OUTPUT 2
                          signal.direct(t) = tmp(i);      %% OUTPUT 3
                          signal.inprice(t) = inprice(i);  %% OUTPUT 4
                          break;
                       end
                   end
               end  %% ��һ����δ�볡���������
           end %% ����ʱ���������:���ո߿�,�����볡�ۣ��������
       end  %% ���ࡢ�����������
   end          
             
    if t > 0
        signal.name = 'hdli'; %% OUTPUT 1
        return;
    end
    
end %% k > 0

    signal = {}; 