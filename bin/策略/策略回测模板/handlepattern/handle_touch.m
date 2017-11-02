function oper_info = handle_touch(todaydata, signal, outpara)

%%% �𽺼۸�ͻ�Ƴ�������
%%  �����س�ֹӯ����
%%% INPUT
%%  1 signal.name =     ''     STRING 
%%  2 signal.inplace =  []     VECTOR
%%  3 signal.direct  =  []     BOOL +1 or -1
%%  4 signal.inprcie =  []     VECTOR
%%  5 todaydata : data in today  [���̼� ��߼� ��ͼ� ���̼�]
%%  6 outpara =   [�۸�λ�� ֹ�� ֹӯ������ �ɽ������� �ɽ�����ֵ����]
%%
%%% OUTPUT
%%   1 oper_info.name     = signal.name 
%%   2 oper_info.inplace  = signal.inplace        
%%   3 oper_info.inprice  = signal.inprice 
%%   4 oper_info.direct   = signal.direct
%%   5 oper_info.outplace = 
%%   6 oper_info.outprice = 
%%   7 oper_info.profit   =   signal.outprice - signal.inprice (+1) or ---->   direct * (outprice - inprice) 
%%                          - signal.outprice + signal.inprice (-1)

%%% Step 0: INPUT check
len_day = size(todaydata,1);  %% ������
r = outpara(1);  %% �۸�λ��
s = outpara(2);  %% ֹ��
u3 = outpara(3);  %% ֹӯ��
n = outpara(4);
m = outpara(5);
ave = 0;
if isempty(signal)
    oper_info = {};
    return;
else
    oper_info.name    = signal.name;
    oper_info.inplace = signal.inplace;
    oper_info.inprice = signal.inprice;
    oper_info.direct  = signal.direct;   %% OUTPUT 1, 2, 3, 4
end

%%% Step 1: Find the place to get out , OUTPUT 5, 6, 7
for i = 1:length(signal.inplace)
    price_in = signal.inprice(i);  %%�볡�۸�
    p_in     = signal.inplace(i);  %%�볡ʱ��
    
    x = 0;
    j = p_in;
    
    if signal.direct(i) > 0
  
        for j = p_in:len_day-1    %% �ӵ����볡K�߿�ʼ
            
            if  x == 0 && todaydata(j,4) - price_in >= u3 && todaydata(j-1,4) - price_in < u3
                x = 1;
            elseif x >= 1 && todaydata(j,2) - price_in >= u3 && todaydata(j-1,4) - price_in < u3
                x = x+1;
            end
           
            if  j ~= p_in && todaydata(j,5) < m*ave
            if  price_in >= todaydata(j,1) + s       %% 1 ��������ֹ�����
                oper_info.outplace(i) = j;
                oper_info.outprice(i) = todaydata(j,1);
                oper_info.profit(i)   = todaydata(j,1) - price_in;
                [z,x] = max(todaydata(p_in:len_day,2));
                oper_info.bestprice(i) = z;
                [h,g] = min(todaydata(i:len_day,3));
                oper_info.badprice(i) = h;
                break;
                
            elseif  price_in >= todaydata(j,3) + s   %% 2 ֹ�����
                oper_info.outplace(i) = j;
                oper_info.outprice(i) = price_in - s;
                oper_info.profit(i)   = - s;
                [z,x] = max(todaydata(p_in:len_day,2));
                oper_info.bestprice(i) = z;
                [h,g] = min(todaydata(i:len_day,3));
                oper_info.badprice(i) = h;
                break;
                
            elseif x >= 2 && todaydata(j,4) - price_in < u3 %%�ڶ��δ�ֹӯ��
                oper_info.outplace(i) = j+1;   %%����һ��K�ߵĿ��̳���
                oper_info.outprice(i) = todaydata(j+1,1);
                oper_info.profit(i)   = todaydata(j+1,1) - price_in;
                [z,x] = max(todaydata(p_in:len_day,2));
                oper_info.bestprice(i) = z;
                [h,g] = min(todaydata(i:len_day,3));
                oper_info.badprice(i) = h;
                break;
            end  %% ֹ��ֹӯ
            else 
               oper_info.outplace(i) = j+1;   %%����һ��K�ߵĿ��̳���
                oper_info.outprice(i) = todaydata(j+1,1);
                oper_info.profit(i)   = todaydata(j+1,1) - price_in;
                [z,x] = max(todaydata(p_in:len_day,2));
                oper_info.bestprice(i) = z;
                [h,g] = min(todaydata(i:len_day,3));
                oper_info.badprice(i) = h;
                break;
            end
        end  %% for j = p_in+1:len_day-1
        
        if j == len_day-1                                    %%  6 �������̳���
            oper_info.outplace(i) = len_day;
            oper_info.outprice(i) = todaydata(len_day,4);
            oper_info.profit(i)   = todaydata(len_day,4) - price_in;
            [z,x] = max(todaydata(p_in:len_day,2));
                oper_info.bestprice(i) = z;
                [h,g] = min(todaydata(i:len_day,3));
                oper_info.badprice(i) = h;
        end
        
    elseif signal.direct(i)< 0
         
        for j = p_in:len_day-1
            
            if x == 0 && price_in - todaydata(j,4)> u3 && price_in - todaydata(j-1,4)< u3
               x = 1;
            elseif x >= 1 && price_in - todaydata(j,3)> u3 && price_in - todaydata(j-1,4)< u3
               x = x+1;
            end
            
            if  j ~= p_in && todaydata(j,5) < m*ave
            if  todaydata(j,1) >= price_in + s       %% 1 ��������ֹ�����
                oper_info.outplace(i) = j;
                oper_info.outprice(i) = todaydata(j,1);
                oper_info.profit(i)   = price_in - todaydata(j,1);
                [z,x] = min(todaydata(p_in:len_day,3));
                oper_info.bestprice(i) = z;
                [h,g] = max(todaydata(i:len_day,2));
                oper_info.badprice(i) = h;
                
            elseif  todaydata(j,2) >= price_in + s   %% 2 ֹ�����
                oper_info.outplace(i) = j;
                oper_info.outprice(i) = price_in + s;
                oper_info.profit(i)   = - s;
                [z,x] = min(todaydata(p_in:len_day,3));
                oper_info.bestprice(i) = z;
                [h,g] = max(todaydata(i:len_day,2));
                oper_info.badprice(i) = h;
                break;
                
            elseif x >= 2 && price_in - todaydata(j,4) < u3 %%�ڶ��δ�ֹӯ��
                oper_info.outplace(i) = j+1;   %%����һ��K�ߵĿ��̳���
                oper_info.outprice(i) = todaydata(j+1,1);
                oper_info.profit(i)   = price_in - todaydata(j+1,1);
                [z,x] = min(todaydata(p_in:len_day,3));
                oper_info.bestprice(i) = z;
                [h,g] = max(todaydata(i:len_day,2));
                oper_info.badprice(i) = h;
                break;    %% ֹ��ֹӯ
            end    
            else
                oper_info.outplace(i) = j+1;   %%����һ��K�ߵĿ��̳���
                oper_info.outprice(i) = todaydata(j+1,1);
                oper_info.profit(i)   = price_in - todaydata(j+1,1);
                [z,x] = min(todaydata(p_in:len_day,3));
                oper_info.bestprice(i) = z;
                [h,g] = max(todaydata(i:len_day,2));
                oper_info.badprice(i) = h;
            end
        end   %% for j = p_in+1:len_day-1
        
    if  j == len_day-1                                  %%  6 �������̳���
        oper_info.outplace(i) = len_day;
        oper_info.outprice(i) = todaydata(len_day,4);
        oper_info.profit(i)   =  price_in - todaydata(len_day,4);
        [z,x] = min(todaydata(p_in:len_day,3));
                oper_info.bestprice(i) = z;
                [h,g] = max(todaydata(i:len_day,2));
                oper_info.badprice(i) = h;
    end
    
end   %% if signal.direct > 0 or < 0

end  %% for i = 1:length(signal)
    
    
 