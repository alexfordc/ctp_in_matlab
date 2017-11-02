function oper_info = handle_simple_vol(todaydata, signal, outpara)

%%% �򵥳������� (���������������ź�)
%%  �����س�ֹӯ����
%%% INPUT
%%  1 signal.name =     ''     STRING 
%%  2 signal.inplace =  []     VECTOR
%%  3 signal.direct  =  []     BOOL +1 or -1
%%  4 signal.inprcie =  []     VECTOR
%%  5 todaydata : data in today  [���̼� ��߼� ��ͼ� ���̼�]
%%  6 outpara =   [�۸�λ��r ֹ��s ��������d ����e ��һ����ӯ����p ��һ���س��ٷֱ�q �ڶ�����ӯ����u �ڶ����س��ٷֱ�v �ɽ�������n �ɽ�����ֵ����m]
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
d = outpara(3);  %% ��������
e = outpara(4);  %% ����
p = outpara(5);  %% ��һ����ӯ����
q = outpara(6);  %% ��һ���س��ٷֱ�
u = outpara(7);  %% �ڶ�����ӯ����
v = outpara(8);  %% �ڶ����س��ٷֱ�
n = outpara(9);  %% �ɽ�������
m = outpara(10);  %% �ɽ�����ֵ����

if isempty(signal)
   oper_info = {};  
   return;
else
   oper_info.name    = signal.name; 
   oper_info.inplace = signal.inplace; 
   oper_info.inprice = signal.inprice;  
   oper_info.direct  = signal.direct;   %% OUTPUT 1, 2, 3, 4 
  
end
ave = 0;
%%% Step 1: Find the place to get out , OUTPUT 5, 6, 7
for i = 1:length(signal.inplace)
    price_in = signal.inprice(i);
    p_in     = signal.inplace(i);

    if signal.direct(i) > 0                
       for j = p_in+1 : len_day-1
              A = max(todaydata(p_in:j,2)) - price_in; 
              B = todaydata(j+1,3) - price_in; 
           ave = sum(todaydata(j-n+1:j,5))/n;
          if j ~= p_in && todaydata(j,5) < m*ave   
            if  j ~= p_in && price_in >= todaydata(j,1) + s       %% 1 ��������ֹ�����  (�����㲻�ÿ��ǿ�����������)
                oper_info.outplace(i) = j; 
                oper_info.outprice(i) = todaydata(j,1); 
                oper_info.profit(i)   = todaydata(j,1) - price_in;  
                break; 
                
            elseif  price_in >= todaydata(j,3) + s   %% 2 ֹ����� (����û�����գ���ֹ������õõ���)
                oper_info.outplace(i) = j; 
                oper_info.outprice(i) = price_in - s;
                oper_info.profit(i)   = - s;
                break;
                
            elseif  d <= A && A < p                   %% 3 �������� =< ��ӯ < ��һ��ֹӯ
               if  todaydata(j+1,1) - price_in < e       %% 3.1  �������� ���� 
                oper_info.outplace(i) = j+1; 
                oper_info.outprice(i) = todaydata(j+1,1); 
                oper_info.profit(i)   = todaydata(j+1,1) - price_in; 
                break;
               elseif B <= e                           %% 3.2  �������� 
                oper_info.outplace(i) = j+1; 
                oper_info.outprice(i) = price_in + e;  
                oper_info.profit(i)   = e; 
                break;
               end
              
             
            elseif  p <= A && A < u                   %% 4 ��һ��ֹӯ =< ��ӯ <  �ڶ���ֹӯ       
               if todaydata(j+1,1) - price_in < q * A      %% 4.1  ��һ�� ���ջس�ֹӯ ���� 
                oper_info.outplace(i) = j+1; 
                oper_info.outprice(i) = todaydata(j+1,1); 
                oper_info.profit(i)   = todaydata(j+1,1) - price_in; 
                break;
               elseif B <= q * A                               %% 4.2  ��һ�� �س�ֹӯ ���� 
                oper_info.outplace(i) = j+1; 
                oper_info.outprice(i) = price_in + r*floor(q*A/r);  
                oper_info.profit(i)   = r*floor(q * A/r);
                break;
               end
                
            elseif  u <= A                            %% 5 ��һ��ֹӯ =< ��ӯ <  �ڶ���ֹӯ       
               if todaydata(j+1,1) - price_in < v * A       %% 5.1  �ڶ��� ���ջس�ֹӯ ���� 
                oper_info.outplace(i) = j+1; 
                oper_info.outprice(i) = todaydata(j+1,1); 
                oper_info.profit(i)   = todaydata(j+1,1) - price_in; 
                break;
               elseif B <= v * A                          %% 5.2  �ڶ��� �س�ֹӯ ���� 
                oper_info.outplace(i) = j+1; 
                oper_info.outprice(i) = price_in + r*floor(v * A/r);  
                oper_info.profit(i)   = r*floor(v * A/r);
                break;
               end
            end
          else
            oper_info.outplace(i) = j+1; 
            oper_info.outprice(i) = todaydata(j+1,1);  
            oper_info.profit(i)   = todaydata(j+1,1) - price_in;  
          end
       end %% for j = p_in:len_dya
       
       if j == len_day-1                                     %%  6 �������̳��� 
                oper_info.outplace(i) = len_day; 
                oper_info.outprice(i) = todaydata(len_day,4); 
                oper_info.profit(i)   = todaydata(len_day,4) - price_in; 
       end
       
    elseif signal.direct(i)< 0      
        
       for j = p_in+1 : len_day-1
              A = price_in - min(todaydata(p_in:j,3)); 
              B = price_in - todaydata(j+1,2);   
              ave = sum(todaydata(j-n+1:j,5))/n;
          if  j ~= p_in && todaydata(j,5) < m*ave  
            if  j ~= p_in && todaydata(j,1) >= price_in + s       %% 1 ��������ֹ�����   (�����㲻�ÿ��ǿ�����������)
                oper_info.outplace(i) = j; 
                oper_info.outprice(i) = todaydata(j,1); 
                oper_info.profit(i)   = price_in - todaydata(j,1);  
                
            elseif  todaydata(j,2) >= price_in + s   %% 2 ֹ����� 
                oper_info.outplace(i) = j; 
                oper_info.outprice(i) = price_in + s;
                oper_info.profit(i)   = - s;
                break;
                
            elseif  d <= A && A < p                   %% 3 �������� =< ��ӯ < ��һ��ֹӯ
               if  price_in  - todaydata(j+1,1) < e       %% 3.1  �������� ���� 
                oper_info.outplace(i) = j+1; 
                oper_info.outprice(i) = todaydata(j+1,1); 
                oper_info.profit(i)   = price_in - todaydata(j+1,1); 
                break;
               elseif B <= e                           %% 3.2  �������� 
                oper_info.outplace(i) = j+1; 
                oper_info.outprice(i) = price_in - e;  
                oper_info.profit(i)   = e; 
                break;
               end
             
            elseif  p <= A && A < u                   %% 4 ��һ��ֹӯ =< ��ӯ <  �ڶ���ֹӯ       
               if price_in  - todaydata(j+1,1) < q * A      %% 4.1  ��һ�� ���ջس�ֹӯ ���� 
                oper_info.outplace(i) = j+1; 
                oper_info.outprice(i) = todaydata(j+1,1); 
                oper_info.profit(i)   = price_in - todaydata(j+1,1); 
                break;
               elseif B <= q * A                               %% 4.2  ��һ�� �س�ֹӯ ���� 
                oper_info.outplace(i) = j+1; 
                oper_info.outprice(i) = price_in - r*floor(q*A/r);  
                oper_info.profit(i)   = r*floor(q * A/r);
                break;
               end
                
            elseif  u <= A                            %% 5 ��һ��ֹӯ =< ��ӯ <  �ڶ���ֹӯ       
               if price_in - todaydata(j+1,1) < v * A       %% 5.1  �ڶ��� ���ջس�ֹӯ ���� 
                oper_info.outplace(i) = j+1; 
                oper_info.outprice(i) = todaydata(j+1,1); 
                oper_info.profit(i)   = price_in - todaydata(j+1,1); 
                break;
               elseif B <= v * A                          %% 5.2  �ڶ��� �س�ֹӯ ���� 
                oper_info.outplace(i) = j+1; 
                oper_info.outprice(i) = price_in - r*floor(v * A/r);  
                oper_info.profit(i)   = r*floor(v * A/r);
                break;
               end
               
            end %% for j 
              else 
            oper_info.outplace(i) = j+1; 
            oper_info.outprice(i) = todaydata(j+1,1);  
            oper_info.profit(i)   = price_in - todaydata(j+1,1); 
              end
       end
       if  j == len_day-1                                   %%  6 �������̳��� 
            oper_info.outplace(i) = len_day; 
            oper_info.outprice(i) = todaydata(len_day,4); 
            oper_info.profit(i)   =  price_in - todaydata(len_day,4); 
        end
    end  %% for j
    end%% if signal.direct > 0 or < 0
    
end  %% for i = 1:length(signal)