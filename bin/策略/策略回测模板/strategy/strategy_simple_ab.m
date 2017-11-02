function record = strategy_simple_ab(todaydata, oper_infos, para)
%%% �����������ļ򵥲���  (�ۺϸ��������������ź�)
%%  
%%% INPUT
%%  1 daydata   [���̼� ��߼� ��ͼ� ���̼�]
%%
%%  2 oper_infors{i} 
%%          .name
%%          .inplace  =  []     VECTOR
%%          .direct   =  []     BOOL +1 or -1
%%          .inprcie  =  []     VECTOR
%%          .outplace =  []     VECTOR
%%          .outprice =  []     VECTOR
%%  3 strategy 
%%          .name = STRING    
%%          .para =  []       e.g.  'simple'  �� +1 or -1 or 0  
%%% OUTPUT
%%  1 record
%%          .rec  = [inplace, inprice, outplace, outprice, direct, profit] 
%%          .name 
%%               (the name of the models for each record.)


%%% Step 0: INPUT Check 
l_lock = para; 
record = {}; 
%%% Step 1: ����ÿ��ģ�Ͷ�Ӧ���м��ʽ���,�����ױ�����Ϊ���ģ����Ϣ ---> oper_temp
n_model = length(oper_infos);    %% ģ������ 
if n_model == 0
    return;
end
if n_model ==1
    if ~isempty(oper_infos{1})
        for k = 1:length(oper_infos{1}.inplace)
        record.name{k} = oper_infos{1}.name;
        record.rec{k,1}  = [oper_infos{1}.inplace(k), oper_infos{1}.inprice(k), oper_infos{1}.outplace(k), oper_infos{1}.outprice(k), ...
                               oper_infos{1}.direct(k), oper_infos{1}.profit(k),oper_infos{1}.bestprice(k), oper_infos{1}.badprice(k),oper_infos{1}.bestpricetime(k), ...
                               oper_infos{1}.badpricetime(k), oper_infos{1}.break(k),oper_infos{1}.goback(k), oper_infos{1}.gobacktime(k), oper_infos{1}.hisamp(k)]; 
        end
    end
    return; 
end
    
len_day = size(todaydata,1); 

for i = 1:n_model
    if isempty(oper_infos{i})
       n_rec(i) = 0; 
       num_temp(i) = 0;
    else
       n_rec(i) = length(oper_infos{i}.inplace); %% ÿ��ģ�͸��ԵĽ�������
       if n_rec(i) > 1  %% �Ƚ��ģ���ڲ���������
%            �ڴ���ģ�ͼ����֮ǰ����������� 
             oper_temp{i} = oper_infos{i}; 
%            oper_temp{i_temp} = strategy_single(todaydata, oper_infos{i});
%            %% �漰��ǰ�������� 
             num_temp(i) = length(oper_infos{i}.inplace); 
       else
            oper_temp{i} = oper_infos{i};  
            num_temp(i) = n_rec(i); 
       end
    end
end
n_temp = n_model; 
%%% Step 2: ����Ѱ����ʼ�㣬��̬���� direct ��ʶ��ǰ���׵ķ���
% current = zeros(n_temp,1) ; %% �ڼ���ģ�͵ĵڼ��ʽ����ڽ����� ÿ��ģ�͵�������֮����������Ͳ���Ҫ��

p_out = 0; 
direct = 0; %% direct of records
r = 0;      %% number of records
%%% Step 3:     ������� 
%% i ��ǰʱ��㣬 j ��ǰģ����ţ� k ��ǰ������� ��ģ���У�  
switch l_lock
    case 1    %% ͬ��Ӳ� ���򲻴��� 
        for i = 1:len_day 
            for j = 1:n_temp       %% �� j �� ģ�͵ĵ� k �ʽ��� 
                for k = 1:num_temp(j)  %% oper_infos{j}.inplace(k)  
                   if oper_temp{j}.inplace(k) == i          %% ������ʱ��˳����д������ⰴģ��˳����ң�����ʱ���ƫ��Ľ����Ƚ�������
                      %% 1 ��ǰû�н��� �� ���׸ս��� 
                     if oper_temp{j}.inplace(k) >= p_out    
                          %% �����볡  
                          p_out  =  oper_temp{j}.outplace(k);
                          direct =  oper_temp{j}.direct(k);
                          r = r+1; 
                          rec(r,:) = [oper_temp{j}.inplace(k), oper_temp{j}.inprice(k), oper_temp{j}.outplace(k), oper_temp{j}.outprice(k), ...
                                   direct, oper_temp{j}.profit(k),oper_temp{j}.bestprice(k), oper_temp{j}.badprice(k),oper_temp{j}.bestpricetime(k), oper_temp{j}.badpricetime(k), ...
                                   oper_temp{j}.break(k), oper_temp{j}.goback(k),oper_temp{j}.gobacktime(k), oper_infos{1}.hisamp(k)];   %% [inplace, inprice, outplace, outprice, direct, profit] 
                          rec_name{r}= oper_temp{j}.name;  
                               
                        %% 2 ��ǰ������������ ��ǰ���strategy_single��֤�˽��ײ��Ǳ�ģ������ģ�
                     elseif oper_temp{j}.inplace(k) < p_out 
                           %% 2.1 ͬ��Ӳ� ���򲻲���
                             if  oper_temp{j}.direct(k) * direct > 0        
                                %%  ͬ�����볡  
                                p_out  =  max([p_out oper_temp{j}.outplace(k)]);        %%  ������ĳ����� 
                                direct =  oper_temp{j}.direct(k);          %% ���򲻱�
                                r = r+1; 
                                rec(r,:) = [oper_temp{j}.inplace(k), oper_temp{j}.inprice(k), oper_temp{j}.outplace(k), oper_temp{j}.outprice(k), ...
                                   direct, oper_temp{j}.profit(k),oper_temp{j}.bestprice(k), oper_temp{j}.badprice(k), oper_temp{j}.bestpricetime(k), oper_temp{j}.badpricetime(k), ...
                                   oper_temp{j}.break(k), oper_temp{j}.goback(k), oper_temp{j}.gobacktime(k), oper_infos{1}.hisamp(k)]; %% [inplace, inprice, outplace, outprice, direct,profit] 
                                rec_name{r}= oper_temp{j}.name;  
                              end
                     end
                   end %% oper_temp{j}.inplace(k) == i          %% ��ʱ��˳����д��� 
                end %% for k = 1:num_temp(j)
            end  %% for j = 1:n_temp 
        end %% for i = 1:len_day 
        
    case 0   %% ƽ����֣����򲻿���  
        for i = 1:len_day 
            for j = 1:n_temp       %% �� j �� ģ�͵ĵ� k �ʽ��� 
                for k = 1:num_temp(j)  %% oper_infos{j}.inplace(k)  
                   if oper_temp{j}.inplace(k) == i          %% ������ʱ��˳����д������ⰴģ��˳����ң�����ʱ���ƫ��Ľ����Ƚ�������
                      %% 1 ��ǰû�н��� �� ���׸ս���  
                     if oper_temp{j}.inplace(k) >= p_out   
                         %% �����볡  
                          p_out  =  oper_temp{j}.outplace(k);
                          direct =  oper_temp{j}.direct(k);
                          r = r+1; 
                          rec(r,:) = [oper_temp{j}.inplace(k), oper_temp{j}.inprice(k), oper_temp{j}.outplace(k), oper_temp{j}.outprice(k), ...
                                   direct, oper_temp{j}.profit(k),oper_temp{j}.bestprice(k), oper_temp{j}.badprice(k), oper_temp{j}.bestpricetime(k), oper_temp{j}.badpricetime(k), ...
                                   oper_temp{j}.break(k), oper_temp{j}.goback(k), oper_temp{j}.gobacktime(k), oper_infos{1}.hisamp(k)]; %% [inplace, inprice, outplace, outprice, direct,profit] 
                                rec_name{r}= oper_temp{j}.name;                            
                          
                       %% 2 ��ǰ������������ ��ǰ���strategy_single��֤�˽��ײ��Ǳ�ģ������ģ�
                     elseif oper_temp{j}.inplace(k) < p_out 
                             %% 2.1 ͬ��Ӳ�
                             if  oper_temp{j}.direct(k) * direct > 0        
                                %%  �����볡  
                                p_out  =  max([p_out oper_temp{j}.outplace(k)]);       %%  ������ĳ����� 
                                direct =  oper_temp{j}.direct(k);        %% ���򲻱�
                                r = r+1;    
                               rec(r,:) = [oper_temp{j}.inplace(k), oper_temp{j}.inprice(k), oper_temp{j}.outplace(k), oper_temp{j}.outprice(k), ...
                                   direct, oper_temp{j}.profit(k),oper_temp{j}.bestprice(k), oper_temp{j}.badprice(k), oper_temp{j}.bestpricetime(k), oper_temp{j}.badpricetime(k), ...
                                   oper_temp{j}.break(k), oper_temp{j}.goback(k), oper_temp{j}.gobacktime(k), oper_infos{1}.hisamp(k)]; %% [inplace, inprice, outplace, outprice, direct,profit] 
                                rec_name{r}= oper_temp{j}.name;                            
                               
                             %% 2.2 ������ƽ����֣����򲻼Ӳ�
                             elseif oper_temp{j}.direct(k) * direct < 0  
                                %%  2.2.1 ͳͳƽ�� 
                                p_out  = i + 1;                            %%  ���³�����,��һ�������볡�ĵ�Ϊ i+1; 
                                direct = 0;                                %%  û�з���,����ʹ����Ľ����޷��볡
                                %% [inplace, inprice, outplace, outprice, direct,profit] 
                                %% 2.2.2 û���µĽ��� ����Ҫ�������н��� ����������
                                r = size(rec,1);
                                for z = 1:r 
                                    if rec(z,3) > i 
                                        rec(z,3) = i;                                 %% outplace
                                        rec(z,4) = todaydata(i,4);                    %% outprice 
                                        rec(z,6) = (rec(z,4) - rec(z,2)) * rec(z,5);  %% profit =  (outprice - inprice) * direct
                                    end
                                end
                                %%  2.2.3 ɾ������ ��i�� ���볡����
                                del = find(rec(:,1) == i & rec(:,5)*direct > 0);
                                if length(del)
                                rec(del,:) = [];
                                rec_name(del) = [];
                                end
                                %%  2.2.4  ���¼�¼��Ŀ
                                r = length(rec_name); 
                             end
                     end %% if oper_temp{j}.inplace(k) >= p_out  
                   end %% oper_temp{j}.inplace(k) == i          %% ��ʱ��˳����д��� 
                end %% for k = 1:num_temp(j)
            end  %% for j = 1:n_temp 
        end %% for i = 1:len_day 
          
    case -1  %% %% ƽ����֣����򿪲�       
        l_change_direct = zeros(len_day,1);  % ��i���Ƿ��Ѿ�������ˣ�ֻ����һ�Σ� 
        for i = 1:len_day 
            for j = 1:n_temp       %% �� j �� ģ�͵ĵ� k �ʽ��� 
                for k = 1:num_temp(j)  %% oper_infos{j}.inplace(k)  
                   if oper_temp{j}.inplace(k) == i          %% ������ʱ��˳����д������ⰴģ��˳����ң�����ʱ���ƫ��Ľ����Ƚ�������
                      %% 1 ��ǰû�н��� �� ���׸ս���  
                     if oper_temp{j}.inplace(k) >= p_out       %% ��ǰ���׽�������ͬһ���� �������볡 
                          %% �����볡  
                          p_out  =  oper_temp{j}.outplace(k);
                          direct =  oper_temp{j}.direct(k);
                          r = r+1; 
                             %% [inplace, inprice, outplace, outprice, direct, profit] 
                           rec(r,:) = [oper_temp{j}.inplace(k), oper_temp{j}.inprice(k), oper_temp{j}.outplace(k), oper_temp{j}.outprice(k), ...
                                   direct, oper_temp{j}.profit(k),oper_temp{j}.bestprice(k), oper_temp{j}.badprice(k), oper_temp{j}.bestpricetime(k), oper_temp{j}.badpricetime(k), ...
                                   oper_temp{j}.break(k), oper_temp{j}.goback(k), oper_temp{j}.gobacktime(k), oper_infos{1}.hisamp(k)]; %% [inplace, inprice, outplace, outprice, direct,profit] 
                                rec_name{r}= oper_temp{j}.name;  
                               
                       %% 2 ��ǰ������������ ��ǰ���strategy_single��֤�˽��ײ��Ǳ�ģ������ģ�
                     elseif oper_temp{j}.inplace(k) < p_out 
                             %% 2.1 ͬ��Ӳ�
                             if  oper_temp{j}.direct(k) * direct > 0        
                             %%  �����볡  
                                p_out  =  max([p_out oper_temp{j}.outplace(k)]);       %%  ������ĳ����� 
                                direct =  oper_temp{j}.direct(k);         %% ���򲻱�
                                r = r+1; 
                              %% [inplace, inprice, outplace, outprice, direct,profit] 
                              rec(r,:) = [oper_temp{j}.inplace(k), oper_temp{j}.inprice(k), oper_temp{j}.outplace(k), oper_temp{j}.outprice(k), ...
                                   direct, oper_temp{j}.profit(k),oper_temp{j}.bestprice(k), oper_temp{j}.badprice(k), oper_temp{j}.bestpricetime(k), oper_temp{j}.badpricetime(k), ...
                                   oper_temp{j}.break(k), oper_temp{j}.goback(k), oper_temp{j}.gobacktime(k), oper_infos{1}.hisamp(k)]; %% [inplace, inprice, outplace, outprice, direct,profit] 
                                rec_name{r}= oper_temp{j}.name;   
                               
                             %% 2.2 ������ƽ����֣����򿪲�
                            elseif oper_temp{j}.direct(k) * direct < 0  
                              if ~l_change_direct(i)   %% ���i���Ѿ���������򲻴���
                               %% 2.2.1 %%  ���³�����,��һ�������볡�ĵ�Ϊ i,���Ƿ���ֻ���뷴��֮��ķ�����ͬ   
                                p_out  = i ;                            
                               %% 2.2.2 �������н��� ����������
                                r = size(rec,1); 
                                for z = 1:r 
                                    if  rec(z,3) > i   &&  rec(z,5) * direct > 0    %% ƽ�� 
                                        rec(z,3) = i;                                 %% outplace
                                        rec(z,4) = todaydata(i,4);                    %% outprice 
                                        rec(z,6) = (rec(z,4) - rec(z,2)) * rec(z,5);  %% profit =  (outprice - inprice) * direct
                                    end
                                end
                               %% 2.2.3  ɾ������ ��i�� ���볡��ԭ��������
                                del = find(rec(:,1) == i);
                                if ~isempty(del)
                                rec(del,:) = [];
                                rec_name(del) = [];
                                end
                               %% 2.2.4 �����²� 
                                r = r + 1;
                                p_out  =  oper_temp{j}.outplace(k);
                                rec(r,:) = [oper_temp{j}.inplace(k), oper_temp{j}.inprice(k), oper_temp{j}.outplace(k), oper_temp{j}.outprice(k), ...
                                   direct, oper_temp{j}.profit(k),oper_temp{j}.bestprice(k), oper_temp{j}.badprice(k), oper_temp{j}.bestpricetime(k), oper_temp{j}.badpricetime(k), ...
                                   oper_temp{j}.break(k), oper_temp{j}.goback(k), oper_temp{j}.gobacktime(k), oper_infos{1}.hisamp(k)]; %% [inplace, inprice, outplace, outprice, direct,profit] 
                                rec_name{r}= oper_temp{j}.name;           
                               
                               %% 2.2.5 ����
                                direct = oper_temp{j}.direct(k); 
                                r = length(rec_name); 
                               
                              end %% if l_change_direct ==0
                             end
                              
                     end %% if oper_temp{j}.inplace(k) >= p_out
                   end %% oper_temp{j}.inplace(k) == i          %% ��ʱ��˳����д��� 
                   
                end %% for k = 1:num_temp(j)
            end  %% for j = 1:n_temp 
        end %% for i = 1:len_day   
        
        otherwise 
        disp('Parameters for strategy_simple are not defined yet');       
end
              
%%% Step 4:     ������׼�¼         
if r == 0
    record = {};
    return;
end
for y = 1:r
    record.name{y} = rec_name{y};            %%% OUTPUT
    record.rec{y,1} = rec(y,:);                %% �Ѽ�¼���������ģ������ ���� 
end

%%% OUTPUT
%%  1 record
%%      .rec  = [inplace, inprice, outplace, outprice, direct, profit] 
%%      .name = ''   (which model deduces this record)   