function [stas suc mes] = write_records(record, len_day, dateTime, filename, per, factor, fee, l_print, n, unchange)

%% ͨ��raw_data��ʱ�䣻ͨ��intable������
%%% INPUT
%%   1  record{i_day}
%%         .name{i} = ''         e.g.   model name
%%         .rec{i}  = []         [inplace, inprice, outplace, outprice, direct,profit] 
%%   2 len_day
%%   3 in_table 
%%   4 filename
%%   5 per = [12 6 3 1 2]      �ָ���� [�� �� �� �� ��]
%%   6 factor = ÿ����
%%   7 fee = ÿ��������
%%   8 l_print: �Ƿ��ӡ��1���ǣ�0����

output{1,1} = '����'; output{1,2} = '����ʱ��';  output{1,3} = '�����۸�';  output{1,4} = '����ʱ��';  output{1,5} = '�����۸�';
output{1,6}= '����'; output{1,7}= 'ӯ��ֵ';  output{1,8}= '���ӯ��'; output{1,9}= '��󸡿���'; output{1,10}= '����k��'; output{1,11}= '����k��';
output{1,12}= 'ģ������';  output{1,13}= '�·�'; output{1,14}= '����'; output{1,15}= '���ӯ��ʱ��'; output{1,16}= '��󸡿���ʱ��';
output{1,17}= 'ǰ����ʱ��';  output{1,18}= '����֮�����س���'; output{1,19}= '����֮�����س���ʱ��';  output{1,20}= '����';

disp('��ʼ����д��ģ��')

i = 1; 

for j = 1:length(record)
    if ~length(record{j})

        continue;
    end
   m=min(length(record{j}.rec),n);
    for k = 1:m
%         if isempty(record{j}.rec{k})
%             continue;
%         end
        i = i + 1; 
        if j<=unchange
%         output{i,1} = intable{(j-1)*len_day + 2, 1};   %% ��������
          output{i,1}=dateTime{1,1}{(j-1)*len_day + 2, 1};   %% ��������
           t1 = record{j}.rec{k}(1) + (j-1) * len_day + 1;
           t2 = record{j}.rec{k}(3) + (j-1) * len_day + 1;
        else
%          output{i,1} = intable{unchange*len_day+(j-unchange-1)*225 + 2, 1};   %% ��������
           output{i,1} = dateTime{1,1}{unchange*len_day+(j-unchange-1)*225 + 2, 1};   %% ��������
           t1 = record{j}.rec{k}(1) + unchange*len_day+(j-unchange-1)*225 + 1;
           t2 = record{j}.rec{k}(3) + unchange*len_day+(j-unchange-1)*225 + 1; 
        end
           
%         output{i,2} = intable{t1,2};      %% ����ʱ�� 
          output{i,2} = dateTime{1,2}{t1,1};     %% ����ʱ�� 
        output{i,3} = record{j}.rec{k}(2);%% �����۸�
        
%         output{i,4} = intable{t2,2};      %% ����ʱ��
          output{i,4} = dateTime{1,2}{t2,1};      %% ����ʱ��
        output{i,5} = record{j}.rec{k}(4);%% �����۸�
        
        if record{j}.rec{k}(5) > 0
        output{i,6} = 1;                %% ���� �� B +1   S -1
        else
        output{i,6} = -1;                %% ���� �� B +1   S -1
        end   
        output{i,7} = record{j}.rec{k}(6) * factor - fee;%% ��ӯ�����
        output{i,8} = record{j}.rec{k}(7);  %% ���ӯ��
        output{i,9} = record{j}.rec{k}(8);%% ��󸡿���
        output{i,12} = record{j}.name{k};  %% ģ������
        output{i,10} = record{j}.rec{k}(1);%% ����k��
        output{i,11} = record{j}.rec{k}(3);%% ����k��
        output{i,13} = month(output{i,1});   %% �·�
        output{i,14} = weeknum(output{i,1}); %% ����
        output{i,15} = record{j}.rec{k}(9);%% ���ӯ��ʱ��
        output{i,16} = record{j}.rec{k}(10);%% ��󸡿���ʱ��
%         output{i,17} = record{j}.rec{k}(11);   %% ǰ����ʱ��
%         output{i,18} = record{j}.rec{k}(12); %% ����֮�����س���
%         output{i,19} = record{j}.rec{k}(13); %% ����֮�����س���ʱ��
%          output{i,20} = record{j}.rec{k}(14); %% ���ղ���
    end
end

if l_print
    [suc mes] = xlswrite(filename,output); 
end

n_record = i;

i_month = 0;
for i = 2:n_record-1
    if  output{i,13} ~= output{i+1,13}
        i_month = i_month + 1;
        mon(i_month,1) = i;  
    end
end
i_month = i_month + 1; 
mon(i_month,1) = n_record;

i_week = 0;
for i = 2:n_record-1
    if  output{i,14} ~= output{i+1,14}
        i_week = i_week + 1;
        week(i_week,1) = i;  
    end
end
i_week = i_week + 1;
week(i_week,1) = n_record;


%% ȫ����¼
iw = 0; il = 0; sw = 0; sl = 0; 
for j = 2:n_record
    if output{j,7} >= 0 
        iw = iw + 1;  sw = sw + output{j,7};
    elseif output{j,7} < 0
        il = il + 1;  sl = sl + output{j,7};
    end
end

%% per(1)  eg.,12����
iw_1 = 0; il_1 = 0; sw_1 = 0; sl_1 = 0;
if i_month > per(1)
i_month_temp = i_month - per(1);
else
 i_month_temp = 1;  
end
n_temp = mon(i_month_temp,1); 
for j = (n_temp + 1):n_record
    if output{j,7} >= 0 
        iw_1 = iw_1 + 1;  sw_1 = sw_1 + output{j,7};
    elseif output{j,7} < 0
        il_1 = il_1 + 1;  sl_1 = sl_1 + output{j,7};
    end
end

%% per(2)  eg.,6����
iw_2 = 0; il_2 = 0; sw_2 = 0; sl_2 = 0;
if i_month > per(2)
i_month_temp = i_month - per(2);
else
 i_month_temp = 1;  
end
n_temp = mon(i_month_temp,1);
for j = (n_temp + 1):n_record
    if output{j,7} >= 0 
        iw_2 = iw_2 + 1;  sw_2 = sw_2 + output{j,7};
    elseif output{j,7} < 0
        il_2 = il_2 + 1;  sl_2 = sl_2 + output{j,7};
    end
end

%% per(3)  eg.,3����
iw_3 = 0; il_3 = 0; sw_3 = 0; sl_3 = 0;
if i_month > per(3)
i_month_temp = i_month - per(3);
else
i_month_temp = 1;
end
    

n_temp = mon(i_month_temp,1); 
for j = (n_temp + 1):n_record
    if output{j,7} >= 0 
        iw_3 = iw_3 + 1;  sw_3 = sw_3 + output{j,7};
    elseif output{j,7} < 0
        il_3 = il_3 + 1;  sl_3 = sl_3 + output{j,7};
    end
end

%% per(4)  eg.,1����
iw_4 = 0; il_4 = 0; sw_4 = 0; sl_4 = 0;
if  i_month > per(4)
i_month_temp = i_month - per(4);
else
i_month_temp = 1; 
end
n_temp = mon(i_month_temp,1); 
for j = (n_temp + 1):n_record
    if output{j,7} >= 0 
        iw_4 = iw_4 + 1;  sw_4 = sw_4 + output{j,7};
    elseif output{j,7} < 0
        il_4 = il_4 + 1;  sl_4 = sl_4 + output{j,7};
    end
end

%% per(5): eg.,2��
iw_5 = 0; il_5 = 0; sw_5 = 0; sl_5 = 0;
if i_week > per(5)
i_week_temp = i_week - per(5);
else
i_week_temp = 1;  
end
n_temp = week(i_week_temp,1); 
for j = (n_temp + 1):n_record
    if output{j,7} >= 0 
        iw_5 = iw_5 + 1;  sw_5 = sw_5 + output{j,7};
    elseif output{j,7} < 0
        il_5 = il_5 + 1;  sl_5 = sl_5 + output{j,7};
    end
end

stas = [iw sw il sl i_month iw_1 sw_1 il_1 sl_1 per(1)  iw_2 sw_2 il_2 sl_2 per(2) iw_3 sw_3 il_3 sl_3 per(3)...
     iw_4 sw_4 il_4 sl_4 per(4) iw_5 sw_5 il_5 sl_5 per(5)/4]; 

   
        
        
        
        
        
        
        






