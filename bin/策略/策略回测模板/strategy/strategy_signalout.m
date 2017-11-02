function record = strategy_signalout(todaydata, oper_infos)
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

p_out = 0; 
direct = 0; %% direct of records
r = 0;      %% number of records
for k = 1:num_temp(1)    % �� 1 �� ģ�͵ĵ� k �ʽ��� %% oper_infos{j}.inplace(k)  Ŀǰֻ�ʺ�˫ģ�ͽṹ
    sign = 0;
    for j = 2:n_model
        for i = 1:n_rec(j)
            if    oper_temp{j}.inplace(i) > oper_temp{1}.inplace(k)    &&   oper_temp{j}.inplace(i)  < oper_temp{1}.outplace(k) && oper_temp{j}.direct(i)*oper_temp{1}.direct(k)==-1 ...
                && oper_temp{j}.outplace(i) > oper_temp{1}.outplace(k)
                r = r+1;
                rec(r,:) = [oper_temp{1}.inplace(k), oper_temp{1}.inprice(k), oper_temp{j}.inplace(i), oper_temp{j}.inprice(i), ...
                    oper_temp{1}.direct(k),     oper_temp{1}.direct(k) * (oper_temp{j}.inprice(i) - oper_temp{1}.inprice(k) ), oper_temp{1}.bestprice(k), oper_temp{1}.badprice(k),oper_temp{1}.bestpricetime(k), ...
                               oper_temp{1}.badpricetime(k), oper_temp{1}.break(k),oper_temp{1}.goback(k), oper_temp{1}.gobacktime(k)+10000 ]; %% [inplace, inprice, outplace, outprice, direct, profit]
                rec_name{r}= oper_temp{1}.name;
                sign = 1;
                break;
% %             if oper_temp{j}.inplace(i) > oper_temp{1}.inplace(k)    &&   oper_temp{j}.inplace(i)  < oper_temp{1}.outplace(k) && oper_temp{j}.direct(i)*oper_temp{1}.direct(k)==1
% %                 r = r+1;
% %                 rec(r,:) = [oper_temp{1}.inplace(k), oper_temp{1}.inprice(k), oper_temp{1}.outplace(k), oper_temp{1}.outprice(k), ...
% %                     oper_temp{1}.direct(k),     oper_temp{1}.profit(k)+oper_temp{1}.direct(k) * (oper_temp{1}.outprice(k) - oper_temp{j}.inprice(k) ), oper_temp{1}.bestprice(k), oper_temp{1}.badprice(k),oper_temp{1}.bestpricetime(k), ...
% %                                oper_temp{1}.badpricetime(k), oper_temp{1}.break(k),oper_temp{1}.goback(k), oper_temp{1}.gobacktime(k) ]; %% [inplace, inprice, outplace, outprice, direct, profit]
% %                 rec_name{r}= oper_temp{1}.name;
% %                 sign = -1;
% %                 break;
            end
        end
    end
    if ~sign
        r = r+1;
        rec(r,:) = [oper_temp{1}.inplace(k), oper_temp{1}.inprice(k), oper_temp{1}.outplace(k), oper_temp{1}.outprice(k), ...
                               oper_temp{1}.direct(k), oper_temp{1}.profit(k),oper_temp{1}.bestprice(k), oper_temp{1}.badprice(k),oper_temp{1}.bestpricetime(k), ...
                               oper_temp{1}.badpricetime(k), oper_temp{1}.break(k),oper_temp{1}.goback(k), oper_temp{1}.gobacktime(k)]; 
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
end

%%% OUTPUT
%%  1 record
%%      .rec  = [inplace, inprice, outplace, outprice, direct, profit] 
%%      .name = ''   (which model deduces this record)              