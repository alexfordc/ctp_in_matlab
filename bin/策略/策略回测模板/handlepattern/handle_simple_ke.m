function oper_info = handle_simple_ke(todaydata, signal, outpara)

%%% �򵥳������� (���������������ź�)
%%  �����س�ֹӯ����
%%% INPUT
%%  1 signal.name =     ''     STRING 
%%  2 signal.inplace =  []     VECTOR
%%  3 signal.direct  =  []     BOOL +1 or -1
%%  4 signal.inprcie =  []     VECTOR
%%  5 todaydata : data in today  [���̼� ��߼� ��ͼ� ���̼�]
%%  6 outpara =   [�۸�λ��r ֹ��s ��������d ����e ��һ����ӯ����p ��һ���س��ٷֱ�q �ڶ�����ӯ����u �ڶ����س��ٷֱ�v �������س��ٷֱ�w  ��˹���ɸ�Ӯ��������m ]
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
w = outpara(9);  %% ��������ӯ����
m=outpara(10);   %% ��˹���ɸ�Ӯ��������m

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
    price_in = signal.inprice(i);
    p_in     = signal.inplace(i);

    if signal.direct(i) > 0                
       for j = p_in : len_day
              A = max(todaydata(p_in:j,2)) - price_in; 
              if j ~= len_day                                     %%  ��С����ӯ����������һ��
                 B = todaydata(j+1,3) - price_in;                 %% ���һ��ѡȡ�������������¸�
                 lu2= todaydata(j+1,1);
              else
                 B  = todaydata(j,3) - price_in;
                 lu2= todaydata(j,1);
              end
                B1  = todaydata(j,3) - price_in;
              if j == p_in                                       %%  ��������K�ߣ�������ֹ��
                 lu =todaydata(j+1,3);
              else
                 lu = todaydata(j,3) ;
              end
                             
            if  j ~= p_in && price_in >= todaydata(j,1) + s       %% 1 ��������ֹ�����  (�����㲻�ÿ��ǿ�����������)
                oper_info.outplace(i) = j; 
                oper_info.outprice(i) = todaydata(j,1); 
                oper_info.profit(i)   = todaydata(j,1) - price_in;  
                break; 
                
            elseif  price_in >= lu + s   %% 2 ֹ�����
                oper_info.outplace(i) = j; 
                oper_info.outprice(i) = price_in - s;
                oper_info.profit(i)   = - s;
                break;
                
            elseif  d <= A && A < p                   %% 3 �������� =< ��ӯ < ��һ��ֹӯ
               if  todaydata(j,2) - price_in < e       %% 3.1  �������� ���� 
                oper_info.outplace(i) = j; 
                oper_info.outprice(i) = todaydata(j,1); 
                oper_info.profit(i)   = todaydata(j,1) - price_in; 
                break;
               elseif B1 <= e                           %% 3.2  �������� 
                oper_info.outplace(i) = j; 
                oper_info.outprice(i) = price_in + e;  
                oper_info.profit(i)   = e; 
                break;
               end
              
             
            elseif  p <= A && A < u                   %% 4 ��һ��ֹӯ =< ��ӯ <  �ڶ���ֹӯ       
                                
                if lu2 - price_in < q * A      %% 4.1  ��һ�� ���ջس�ֹӯ ���� 
                oper_info.outplace(i) = j+1; 
                oper_info.outprice(i) = lu2; 
                oper_info.profit(i)   = lu2 - price_in; 
                break;
               elseif B <= q * A                               %% 4.2  ��һ�� �س�ֹӯ ���� 
                oper_info.outplace(i) = j+1; 
                oper_info.outprice(i) = price_in + r*floor(q*A/r);  
                oper_info.profit(i)   = r*floor(q * A/r);
                break;
               end
                
            elseif  u <= A                            %% 5 ��һ��ֹӯ =< ��ӯ <  �ڶ���ֹӯ       
               if lu2  - price_in < v * A       %% 5.1  �ڶ��� ���ջس�ֹӯ ���� 
                oper_info.outplace(i) = j+1; 
                oper_info.outprice(i) = lu2; 
                oper_info.profit(i)   = lu2 - price_in; 
                break;
               elseif B <= v * A                          %% 5.2  �ڶ��� �س�ֹӯ ���� 
                oper_info.outplace(i) = j+1; 
                oper_info.outprice(i) = price_in + r*floor(v * A/r);  
                oper_info.profit(i)   = r*floor(v * A/r);
                break;
               end
            elseif  w<=A      %% 5 �������س�ֹӯ 
                 if  todaydata(j,4) <  sum(todaydata(j-m+1:j,3))/m  && todaydata(j-1,4) >= sum(todaydata(j-m:j-1,3))/m   %% ���̼۴�Խ�¹�
                oper_info.outplace(i) = j+1; 
                oper_info.outprice(i) = lu2; 
                oper_info.profit(i)   = lu2 - price_in; 
                break;
                end
               
            end
       end %% for j = p_in:len_dya
       if j == len_day                                     %%  6 �������̳��� 
                oper_info.outplace(i) = len_day; 
                oper_info.outprice(i) = todaydata(len_day,4); 
                oper_info.profit(i)   = todaydata(len_day,4) - price_in; 
       end
       
    elseif signal.direct(i)< 0      
        
       for j = p_in : len_day
              A = price_in - min(todaydata(p_in:j,3)); 
              if j ~= len_day                                %%  ��С����ӯ����������һ��
              B = price_in - todaydata(j+1,2);   
              lu2=todaydata(j+1,1);
              else
                  B = price_in - todaydata(j,2);
                  lu2=todaydata(j,1);
              end
              B1 = price_in - todaydata(j,2);
              if j == p_in                                  %%  ���ֵ���K�ߣ�������ֹ��������һ��
                 lu= todaydata(j+1,2);
              else
                  lu= todaydata(j,2);
              end 
              
            if  j ~= p_in && todaydata(j,1) >= price_in + s       %% 1 ��������ֹ�����   (�����㲻�ÿ��ǿ�����������)
                oper_info.outplace(i) = j; 
                oper_info.outprice(i) = todaydata(j,1); 
                oper_info.profit(i)   = price_in - todaydata(j,1);  
                
            elseif  lu >= price_in + s   %% 2 ֹ�����
                oper_info.outplace(i) = j; 
                oper_info.outprice(i) = price_in + s;
                oper_info.profit(i)   = - s;
                break;
                
            elseif  d <= A && A < p                   %% 3 �������� =< ��ӯ < ��һ��ֹӯ
               if  price_in  - todaydata(j,3) < e       %% 3.1  �������� ���� 
                oper_info.outplace(i) = j; 
                oper_info.outprice(i) = todaydata(j,1); 
                oper_info.profit(i)   = price_in - todaydata(j,1); 
                break;
               elseif B1 <= e                           %% 3.2  �������� 
                oper_info.outplace(i) = j; 
                oper_info.outprice(i) = price_in - e;  
                oper_info.profit(i)   = e; 
                break;
               end
             
            elseif  p <= A && A < w                   %% 4 ��һ��ֹӯ =< ��ӯ <  �ڶ���ֹӯ       
               if price_in  - lu2 < q * A      %% 4.1  ��һ�� ���ջس�ֹӯ ���� 
                oper_info.outplace(i) = j+1; 
                oper_info.outprice(i) = lu2; 
                oper_info.profit(i)   = price_in - lu2; 
                break;
               elseif B <= q * A                               %% 4.2  ��һ�� �س�ֹӯ ���� 
                oper_info.outplace(i) = j+1; 
                oper_info.outprice(i) = price_in - r*floor(q*A/r);  
                oper_info.profit(i)   = r*floor(q * A/r);
                break;
               end
                
%             elseif  u <= A                            %% 5 ��һ��ֹӯ =< ��ӯ <  �ڶ���ֹӯ       
%                if lu2 - price_in < v * A       %% 5.1  �ڶ��� ���ջس�ֹӯ ���� 
%                 oper_info.outplace(i) = j+1; 
%                 oper_info.outprice(i) = lu2; 
%                 oper_info.profit(i)   = price_in - lu2; 
%                 break;
%                elseif B <= v * A                          %% 5.2  �ڶ��� �س�ֹӯ ���� 
%                 oper_info.outplace(i) = j+1; 
%                 oper_info.outprice(i) = price_in - r*floor(v * A/r);  
%                 oper_info.profit(i)   = r*floor(v * A/r);
%                 break;
%                end
            elseif  w<=A      %% 5 �������س�ֹӯ 
              if  todaydata(j,4) >  sum(todaydata(j-m+1:j,2))/m && todaydata(j-1,4) <= sum(todaydata(j-m:j-1,2))/m   %% ���̼۴�Խ�¹�
                oper_info.outplace(i) = j+1; 
                oper_info.outprice(i) = lu2; 
                oper_info.profit(i)   = price_in-lu2; 
                break;
                end
                 
            end %% for j 
       end
       if  j == len_day                                   %%  6 �������̳��� 
            oper_info.outplace(i) = len_day; 
            oper_info.outprice(i) = todaydata(len_day,4); 
            oper_info.profit(i)   =  price_in - todaydata(len_day,4); 
        end
    end  %% for j
    end%% if signal.direct > 0 or < 0
    
end  %% for i = 1:length(signal)
    
    
 