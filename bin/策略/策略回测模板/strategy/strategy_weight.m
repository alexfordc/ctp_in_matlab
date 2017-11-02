function record = strategy_weight(todaydata, oper_infos, para)
%%
%%% ������������Ȩ�ز��ԣ�����ģ�͵�Ȩ�ؽ����������
%%  
%%% INPUT
%%  1 daydata   [���̼� ��߼� ��ͼ� ���̼�]
%%
%%  2 oper_infors{i}
%%  
%%          .name
%%          .inplace  =  []     VECTOR
%%          .direct   =  []     BOOL +1 or -1
%%          .inprcie  =  []     VECTOR
%%          .outplace =  []     VECTOR
%%          .outprice =  []     VECTOR
%%          .profit   =  []     NUMBER
%%
%%  3 strategy 
%%          .name = STRING    
%%          .para =  []       e.g.  'simple'  �� +1 or -1 or 0  
%%                            e.g.  'weight' 
%%                                       para{1} = [1 4 2 3];     %% Ĭ��-1����
%%   
%%
%%% OUTPUT
%%  1 record
%%          .rec  = [inplace, inprice, outplace, outprice, direct, profit] 
%%          .name    (the name of the models for each record.)
%%          .weight  (the weight of the models for each record.)   
%%         

%%% Step 0: INPUT Check 
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
        record.rec{k,1}  = [oper_infos{1}.inplace(k), oper_infos{1}.inprice(k), oper_infos{1}.outplace(k), oper_infos{1}.outprice(k), oper_infos{1}.direct(k), oper_infos{1}.profit(k)]; 
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
       n_rec(i) = length(oper_infos{i}.inplace); %% ÿ��ģ�͸��ԵĽ���������ģ���ڲ����������ѱ����н����
       oper_temp{i} = oper_infos{i}; 
       num_temp(i) = n_rec(i); 
    end
end
n_temp = n_model; 

%%% Step 2: ������� %% i ��ǰʱ��㣬j ��ǰģ����ţ�k ��ǰ������� ��ģ���еĵ�k�ʽ��ף� 
r = 0; p_out = 0; %% Ŀǰ���ڽ��׵���Զ������
dir = 0;  
for i = 1:len_day   
    for j = 1:n_temp       %% �� j �� ģ�͵ĵ� k �ʽ���       
        for k = 1:num_temp(j)  %% oper_infos{j}.inplace(k)
            if oper_temp{j}.inplace(k) == i          %% ������ʱ��˳����д������ⰴģ��˳����ң�����ʱ���ƫ��Ľ����Ƚ���
          %% 1 ��ǰû�н���, ���׸ս���  
          if oper_temp{j}.inplace(k) >= p_out       %% ��ǰ���׽�������ͬһ���� �������볡
              %% �����볡  
                p_out  =  oper_temp{j}.outplace(k);
                dir =  oper_temp{j}.direct(k);
                r = r+1;        
                rec(r,:) = [oper_temp{j}.inplace(k), oper_temp{j}.inprice(k), oper_temp{j}.outplace(k), oper_temp{j}.outprice(k), dir, oper_temp{j}.profit(k)];  %% [inplace, inprice, outplace, outprice, direct, profit] 
                rec_name{r} = oper_temp{j}.name;  
                rec_weight(r) = para{1}(j);  
                               
           %% 2 ��ǰ������������ ��ǰ���strategy_single��֤�˽��ײ��Ǳ�ģ������ģ�����ģ���ڲ���û�ж�����
               elseif oper_temp{j}.inplace(k) < p_out 
               %% 2.1 ͬ��Ӳ�
                 if  oper_temp{j}.direct(k) * dir > 0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
               %%  �����볡  
                   p_out  =  max([p_out oper_temp{j}.outplace(k)]);       %%  ������ĳ����� 
                   dir =  oper_temp{j}.direct(k);         %% ���򲻱�
                   r = r+1; 
                   rec(r,:) = [oper_temp{j}.inplace(k), oper_temp{j}.inprice(k), oper_temp{j}.outplace(k), oper_temp{j}.outprice(k), dir, oper_temp{j}.profit(k)]; 
                   rec_name{r} = oper_temp{j}.name;  
                   rec_weight(r) = para{1}(j);  
                               
               %% 2.2 ���������Ȩ�ز����ж��Ƿ��򿪲�    
                  elseif oper_temp{j}.direct(k) * dir < 0  
                    sign  = 1;
                    for z = 1:r     %% 2.2.1 �ж�֮ǰ�Ƿ���ڴ�Ȩ��ģ�ͣ�������ڣ������źŲ��볡��     
                       if  rec(z,3) > i  &&  rec(z,5) * oper_temp{j}.direct(k) < 0 && rec_weight(r) > para{1}(j)
                          sign = 0; break; 
                        end
                     end
                     if sign        %% 2.2.2 ��ǰ���ڶ���СȨ��ģ�ͣ�Ӧ���볡��ת֮��
                        for z = 1:r 
                           if  rec(z,3) > i  &&  rec(z,5) * oper_temp{j}.direct(k) < 0 && rec_weight(r) > para{1}(j)                         
                                   rec(z,3) = i;                                 %% outplace
                                   rec(z,4) = todaydata(i,4);                    %% outprice 
                                   rec(z,6) = (rec(z,4) - rec(z,2)) * rec(z,5);  %% profit =  (outprice - inprice) * direct   
                            end
                         end
                         r = r + 1; %% 2.2.3 �����²� 
                         p_out  =  oper_temp{j}.outplace(k);
                         rec(r,:) = [oper_temp{j}.inplace(k), oper_temp{j}.inprice(k), oper_temp{j}.outplace(k), oper_temp{j}.outprice(k), oper_temp{j}.direct(k), oper_temp{j}.profit(k)]; 
                         rec_name{r}= oper_temp{j}.name;   
                         rec_weight(r) = para{1}(j);  
                         dir = oper_temp{j}.direct(k); 
                       
                     end
                 end %%  oper_temp{j}.direct(k) * dir
           end %% if oper_temp{j}.inplace(k) >= p_out
            end %% oper_temp{j}.inplace(k) == i          %% ��ʱ��˳����д���
        end %% for k = 1:num_temp(j)
    end  %% for j = 1:n_temp 
 end %% for i = 1:len_day   
        
 

              
%%% Step 3:     ������׼�¼         
if r == 0
    record = {};
    return;
end
for y = 1:r
    record.name{y} = rec_name{y};            %%% OUTPUT
    record.rec{y,1} = rec(y,:);                %% �Ѽ�¼���������ģ������ ���� 
    record.weigth{y,1} = rec_weight(y);
end

%%% OUTPUT
%%  1 record
%%      .rec  = [inplace, inprice, outplace, outprice, direct, profit] 
%%      .name = ''   (which model deduces this record)              
        








        
          