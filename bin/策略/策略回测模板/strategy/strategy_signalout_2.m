function record = strategy_signalout_2(todaydata, oper_infos)
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
                               oper_infos{1}.badpricetime(k), oper_infos{1}.break(k),oper_infos{1}.goback(k), oper_infos{1}.gobacktime(k)]; 
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

r = 0;      %% number of records
for k = 1:num_temp(1)    % �� 1 �� ģ�͵ĵ� k �ʽ��� %% oper_infos{j}.inplace(k)  ��ģ�ͽṹ : ��һ��ģ��������ģ�ͣ��ڶ��������Ӳ֣���������������
    i_pos = 2;       i_neg = 3;   %  ��ģ�ͽṹ : ��һ��ģ��������ģ�ͣ��ڶ���(i_pos)�����Ӳ֣�������(i_neg)��������
    l_pos = 0;  l_neg = 0;
    %% Ѱ���ڵ�k�����׹����г��ֵļӡ������ź�
    for i = 1:n_rec(i_pos) ;
        if oper_temp{i_pos}.inplace(i) > oper_temp{1}.inplace(k)    &&   oper_temp{i_pos}.inplace(i)  < oper_temp{1}.outplace(k)  ...
                && oper_temp{i_pos}.direct(i)*oper_temp{1}.direct(k) > 0
            l_pos = 1;
            break;
        end
    end
    
    for j = 1:n_rec(i_neg) ;
        if oper_temp{i_neg}.inplace(j) > oper_temp{1}.inplace(k)    &&   oper_temp{i_neg}.inplace(j)  < oper_temp{1}.outplace(k)  ...
                && oper_temp{i_neg}.direct(j) * oper_temp{1}.direct(k) < 0
            l_neg = 1;
            break;
        end
    end
    
    % i, j Ϊfinally ������������ģ�ͽ����������г��ֵļ�(i)����(j)���źţ�
    if l_pos && ~l_neg          %% ֻ�мӲ��ź�
        r = r+1;
        rec_add(r,:) = [oper_temp{i_pos}.inplace(i), oper_temp{i_pos}.inprice(i), oper_temp{1}.outplace(k), oper_temp{1}.outprice(k), oper_temp{i_pos}.direct(i),  (oper_temp{1}.outprice(k)-oper_temp{i_pos}.inprice(i))*oper_temp{i_pos}.direct(i)];    
        rec_rmv(r,:) = [0,0,0,0,0,0];
        rec(r,:) = [oper_temp{1}.inplace(k), oper_temp{1}.inprice(k), oper_temp{1}.outplace(k), oper_temp{1}.outprice(k), ...
            oper_temp{1}.direct(k),  rec_add(r,6) + oper_temp{1}.profit(k) , oper_temp{1}.bestprice(k), oper_temp{1}.badprice(k),oper_temp{1}.bestpricetime(k), ...
            oper_temp{1}.badpricetime(k), oper_temp{1}.break(k),oper_temp{1}.goback(k), oper_temp{1}.gobacktime(k) ]; %% [inplace, inprice, outplace, outprice, direct, profit]
        rec_name{r}= oper_temp{1}.name;
        
    elseif  ~l_pos && l_neg   %% ֻ�м����ź�
        r = r+1;
        rec_add(r,:) = [0,0,0,0,0,0];
        rec_rmv(r,:) =  [oper_temp{i_neg}.inplace(j), oper_temp{i_neg}.inprice(j),oper_temp{i_neg}.inplace(j), oper_temp{i_neg}.inprice(j), oper_temp{i_neg}.direct(j), 0];
        rec(r,:) = [oper_temp{1}.inplace(k), oper_temp{1}.inprice(k), oper_temp{i_neg}.inplace(j), oper_temp{i_neg}.inprice(j), ...
            oper_temp{1}.direct(k),  oper_temp{1}.direct(k) * (oper_temp{i_neg}.inprice(j) - oper_temp{1}.inprice(k) ), oper_temp{1}.bestprice(k), oper_temp{1}.badprice(k),oper_temp{1}.bestpricetime(k), ...
            oper_temp{1}.badpricetime(k), oper_temp{1}.break(k),oper_temp{1}.goback(k), oper_temp{1}.gobacktime(k) ]; %% [inplace, inprice, outplace, outprice, direct, profit]
        rec_name{r}= oper_temp{1}.name;
        
    elseif  l_pos && l_neg    %% ͬʱ�мӡ������ź� 
        if  oper_temp{i_pos}.inplace(i) > oper_temp{i_neg}.inplace(j)        %% �����ź��ȳ���
            r = r+1;
            rec_add(r,:) = [oper_temp{i_pos}.inplace(i), oper_temp{i_pos}.inprice(i), oper_temp{1}.outplace(k), oper_temp{1}.outprice(k), oper_temp{i_pos}.direct(i),  oper_temp{i_pos}.profit(i)]; 
            rec_rmv(r,:) = [oper_temp{i_neg}.inplace(j), oper_temp{i_neg}.inprice(j),oper_temp{i_neg}.inplace(j), oper_temp{i_neg}.inprice(j), oper_temp{i_neg}.direct(j), 0];
            rec(r,:) = [oper_temp{1}.inplace(k), oper_temp{1}.inprice(k), oper_temp{i_neg}.inplace(j), oper_temp{i_neg}.inprice(j), ...
                oper_temp{1}.direct(k),  oper_temp{i_pos}.profit(i) + oper_temp{1}.direct(k) * (oper_temp{i_neg}.inprice(j) - oper_temp{1}.inprice(k) ), oper_temp{1}.bestprice(k), oper_temp{1}.badprice(k),oper_temp{1}.bestpricetime(k), ...
                oper_temp{1}.badpricetime(k), oper_temp{1}.break(k),oper_temp{1}.goback(k), oper_temp{1}.gobacktime(k) ]; %% [inplace, inprice, outplace, outprice, direct, profit]
            rec_name{r}= oper_temp{1}.name;
        elseif  oper_temp{i_pos}.inplace(i) > oper_temp{i_neg}.inplace(j)   %% �Ӳ��ź��ȳ���
            r = r+1;
            rec_add(r,:) = [oper_temp{i_pos}.inplace(i), oper_temp{i_pos}.inprice(i), oper_temp{i_neg}.inplace(j), oper_temp{i_neg}.inprice(j), oper_temp{i_pos}.direct(i),  oper_temp{i_pos}.direct(i)*(oper_temp{i_neg}.inprice(j)-oper_temp{i_pos}.inprice(i))];
            rec_rmv(r,:) = [oper_temp{i_neg}.inplace(j), oper_temp{i_neg}.inprice(j), oper_temp{i_neg}.inplace(j), oper_temp{i_neg}.inprice(j), oper_temp{i_neg}.direct(j), 0];
            rec(r,:) = [oper_temp{1}.inplace(k), oper_temp{1}.inprice(k), oper_temp{i_neg}.inplace(j), oper_temp{i_neg}.inprice(j), ...
                oper_temp{1}.direct(k),  oper_temp{1}.direct(k) * (2* oper_temp{i_neg}.inprice(j)-oper_temp{i_pos}.inprice(i) - oper_temp{1}.inprice(k) ), oper_temp{1}.bestprice(k), oper_temp{1}.badprice(k),oper_temp{1}.bestpricetime(k), ...
                oper_temp{1}.badpricetime(k), oper_temp{1}.break(k),oper_temp{1}.goback(k), oper_temp{1}.gobacktime(k) ]; %% [inplace, inprice, outplace, outprice, direct, profit]
            rec_name{r}= oper_temp{1}.name;     
        else % ͬʱ����
            r = r+1;
            rec_add(r,:) = [0,0,0,0,0,0];
            rec_rmv(r,:) = [0,0,0,0,0,0];
            rec(r,:) = [oper_temp{1}.inplace(k), oper_temp{1}.inprice(k), oper_temp{1}.outplace(k), oper_temp{1}.outprice(k), ...
                oper_temp{1}.direct(k),  oper_temp{1}.profit(k) , oper_temp{1}.bestprice(k), oper_temp{1}.badprice(k),oper_temp{1}.bestpricetime(k), ...
                oper_temp{1}.badpricetime(k), oper_temp{1}.break(k),oper_temp{1}.goback(k), oper_temp{1}.gobacktime(k) ]; %% [inplace, inprice, outplace, outprice, direct, profit]
            rec_name{r}= oper_temp{1}.name;
        end
    else 
       r = r+1;
            rec_add(r,:) = [0,0,0,0,0,0];
            rec_rmv(r,:) = [0,0,0,0,0,0];
            rec(r,:) = [oper_temp{1}.inplace(k), oper_temp{1}.inprice(k), oper_temp{1}.outplace(k), oper_temp{1}.outprice(k), ...
                oper_temp{1}.direct(k),  oper_temp{1}.profit(k) , oper_temp{1}.bestprice(k), oper_temp{1}.badprice(k),oper_temp{1}.bestpricetime(k), ...
                oper_temp{1}.badpricetime(k), oper_temp{1}.break(k),oper_temp{1}.goback(k), oper_temp{1}.gobacktime(k) ]; %% [inplace, inprice, outplace, outprice, direct, profit]
            rec_name{r}= oper_temp{1}.name; 
    end 
end                 
%%% Step 3:     ������׼�¼         
if r == 0
    record = {};
    return;
end
for y = 1:r
    record.name{y} = rec_name{y};            %%% OUTPUT
    record.rec{y,1} = rec(y,:);                %% �Ѽ�¼���������ģ������ ���� 
%     record.rec{y,2} = rec_add(y,:); 
%     record.rec{y,3} = rec_rmv(y,:);  
end

%%% OUTPUT
%%  1 record
%%      .rec  = [inplace, inprice, outplace, outprice, direct, profit] 
%%      .name = ''   (which model deduces this record)              