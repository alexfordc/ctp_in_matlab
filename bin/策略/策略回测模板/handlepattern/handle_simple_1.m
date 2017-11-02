function oper_info = handle_simple_1(todaydata, signal, outpara)

%%% �򵥳������� (���������������ź�)
%%  �����س�ֹӯ����
%%% INPUT
%%  1 signal.name =     ''     STRING 
%%  2 signal.inplace =  []     VECTOR
%%  3 signal.direct  =  []     BOOL +1 or -1
%%  4 signal.inprcie =  []     VECTOR
%%  5 todaydata : data in today  [���̼� ��߼� ��ͼ� ���̼�]
%%  6 outpara =   [�۸�λ��r ֹ��s ��������d ����e ��һ����ӯ����p ��һ���س��ٷֱ�q �ڶ�����ӯ����u �ڶ����س��ٷֱ�v]
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
m = outpara(9);  %% ������

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
       for j = p_in : m-1
              A = max(todaydata(p_in:j,2)) - price_in; 
              B = todaydata(j+1,3) - price_in;   
              
            if  j ~= p_in && price_in >= todaydata(j,1) + s       %% 1 ��������ֹ�����  (�����㲻�ÿ��ǿ�����������)
                oper_info.outplace(i) = j; 
                oper_info.outprice(i) = todaydata(j,1); 
                oper_info.profit(i)   = todaydata(j,1) - price_in;  
                [z,x] = max(todaydata(p_in:m,2));
                oper_info.bestprice(i) = z;
                [h,g] = min(todaydata(p_in:m,3));
                oper_info.badprice(i) = h;
                break; 
                
            elseif  price_in >= todaydata(j,3) + s   %% 2 ֹ����� 
                oper_info.outplace(i) = j; 
                oper_info.outprice(i) = price_in - s;
                oper_info.profit(i)   = - s;
                [z,x] = max(todaydata(p_in:m,2));
                oper_info.bestprice(i) = z;
                [h,g] = min(todaydata(p_in:m,3));
                oper_info.badprice(i) = h;
                break;
                
            elseif  d <= A && A < p                   %% 3 �������� =< ��ӯ < ��һ��ֹӯ
               if  todaydata(j+1,1) - price_in < e       %% 3.1  �������� ���� 
                oper_info.outplace(i) = j+1; 
                oper_info.outprice(i) = todaydata(j+1,1); 
                oper_info.profit(i)   = todaydata(j+1,1) - price_in; 
                [z,x] = max(todaydata(p_in:m,2));
                oper_info.bestprice(i) = z;
                [h,g] = min(todaydata(p_in:m,3));
                oper_info.badprice(i) = h;
                break;
               elseif B <= e                           %% 3.2  �������� 
                oper_info.outplace(i) = j+1; 
                oper_info.outprice(i) = price_in + e;  
                oper_info.profit(i)   = e; 
                [z,x] = max(todaydata(p_in:m,2));
                oper_info.bestprice(i) = z;
                [h,g] = min(todaydata(p_in:m,3));
                oper_info.badprice(i) = h;
                break;
               end
              
             
            elseif  p <= A && A < u                   %% 4 ��һ��ֹӯ =< ��ӯ <  �ڶ���ֹӯ       
               if todaydata(j+1,1) - price_in < q * A      %% 4.1  ��һ�� ���ջس�ֹӯ ���� 
                oper_info.outplace(i) = j+1; 
                oper_info.outprice(i) = todaydata(j+1,1); 
                oper_info.profit(i)   = todaydata(j+1,1) - price_in; 
                [z,x] = max(todaydata(p_in:m,2));
                oper_info.bestprice(i) = z;
                [h,g] = min(todaydata(p_in:m,3));
                oper_info.badprice(i) = h;
                break;
               elseif B <= q * A                               %% 4.2  ��һ�� �س�ֹӯ ���� 
                oper_info.outplace(i) = j+1; 
                oper_info.outprice(i) = price_in + r*floor(q*A/r);  
                oper_info.profit(i)   = r*floor(q * A/r);
                [z,x] = max(todaydata(p_in:m,2));
                oper_info.bestprice(i) = z;
                [h,g] = min(todaydata(p_in:m,3));
                oper_info.badprice(i) = h;
                break;
               end
                
            elseif  u <= A                            %% 5 ��һ��ֹӯ =< ��ӯ <  �ڶ���ֹӯ       
               if todaydata(j+1,1) - price_in < v * A       %% 5.1  �ڶ��� ���ջس�ֹӯ ���� 
                oper_info.outplace(i) = j+1; 
                oper_info.outprice(i) = todaydata(j+1,1); 
                oper_info.profit(i)   = todaydata(j+1,1) - price_in; 
                [z,x] = max(todaydata(p_in:m,2));
                oper_info.bestprice(i) = z;
                [h,g] = min(todaydata(p_in:m,3));
                oper_info.badprice(i) = h;
                break;
               elseif B <= v * A                          %% 5.2  �ڶ��� �س�ֹӯ ���� 
                oper_info.outplace(i) = j+1; 
                oper_info.outprice(i) = price_in + r*floor(v * A/r);  
                oper_info.profit(i)   = r*floor(v * A/r);
                [z,x] = max(todaydata(p_in:m,2));
                oper_info.bestprice(i) = z;
                [h,g] = min(todaydata(p_in:m,3));
                oper_info.badprice(i) = h;
                break;
               end
               
            end
       end %% for j = p_in:len_dya
       
       if j == m-1                                     %%  6 �������̳��� 
                oper_info.outplace(i) = m; 
                oper_info.outprice(i) = todaydata(m,4); 
                oper_info.profit(i)   = todaydata(m,4) - price_in; 
                [z,x] = max(todaydata(p_in:m,2));
                oper_info.bestprice(i) = z;
                [h,g] = min(todaydata(p_in:m,3));
                oper_info.badprice(i) = h;
       end
       
    elseif signal.direct(i)< 0      
        
       for j = p_in : m-1
              A = price_in - min(todaydata(p_in:j,3)); 
              B = price_in - todaydata(j+1,2);   
              
            if  j ~= p_in && todaydata(j,1) >= price_in + s       %% 1 ��������ֹ�����   (�����㲻�ÿ��ǿ�����������)
                oper_info.outplace(i) = j; 
                oper_info.outprice(i) = todaydata(j,1); 
                oper_info.profit(i)   = price_in - todaydata(j,1);  
                [z,x] = min(todaydata(p_in:m,3));
                oper_info.bestprice(i) = z;
                [h,g] = max(todaydata(p_in:m,2));
                oper_info.badprice(i) = h;
                break;
                
            elseif  todaydata(j,2) >= price_in + s   %% 2 ֹ����� 
                oper_info.outplace(i) = j; 
                oper_info.outprice(i) = price_in + s;
                oper_info.profit(i)   = - s;
                [z,x] = min(todaydata(p_in:m,3));
                oper_info.bestprice(i) = z;
                [h,g] = max(todaydata(p_in:m,2));
                oper_info.badprice(i) = h;
                break;
                
            elseif  d <= A && A < p                   %% 3 �������� =< ��ӯ < ��һ��ֹӯ
               if  price_in  - todaydata(j+1,1) < e       %% 3.1  �������� ���� 
                oper_info.outplace(i) = j+1; 
                oper_info.outprice(i) = todaydata(j+1,1); 
                oper_info.profit(i)   = price_in - todaydata(j+1,1); 
                [z,x] = min(todaydata(p_in:m,3));
                oper_info.bestprice(i) = z;
                [h,g] = max(todaydata(p_in:m,2));
                oper_info.badprice(i) = h;
                break;
               elseif B <= e                           %% 3.2  �������� 
                oper_info.outplace(i) = j+1; 
                oper_info.outprice(i) = price_in - e;  
                oper_info.profit(i)   = e; 
                [z,x] = min(todaydata(p_in:m,3));
                oper_info.bestprice(i) = z;
                [h,g] = max(todaydata(p_in:m,2));
                oper_info.badprice(i) = h;
                break;
               end
             
            elseif  p <= A && A < u                   %% 4 ��һ��ֹӯ =< ��ӯ <  �ڶ���ֹӯ       
               if price_in  - todaydata(j+1,1) < q * A      %% 4.1  ��һ�� ���ջس�ֹӯ ���� 
                oper_info.outplace(i) = j+1; 
                oper_info.outprice(i) = todaydata(j+1,1); 
                oper_info.profit(i)   = price_in - todaydata(j+1,1); 
                [z,x] = min(todaydata(p_in:m,3));
                oper_info.bestprice(i) = z;
                [h,g] = max(todaydata(p_in:m,2));
                oper_info.badprice(i) = h;
                break;
               elseif B <= q * A                               %% 4.2  ��һ�� �س�ֹӯ ���� 
                oper_info.outplace(i) = j+1; 
                oper_info.outprice(i) = price_in - r*floor(q*A/r);  
                oper_info.profit(i)   = r*floor(q * A/r);
                
                [z,x] = min(todaydata(p_in:m,3));
                oper_info.bestprice(i) = z;
                [h,g] = max(todaydata(p_in:m,2));
                oper_info.badprice(i) = h;
                break;
               end
                
            elseif  u <= A                            %% 5 ��һ��ֹӯ =< ��ӯ <  �ڶ���ֹӯ       
               if price_in-todaydata(j+1,1)  < v * A       %% 5.1  �ڶ��� ���ջس�ֹӯ ���� 
                oper_info.outplace(i) = j+1; 
                oper_info.outprice(i) = todaydata(j+1,1); 
                oper_info.profit(i)   = price_in - todaydata(j+1,1); 
                [z,x] = min(todaydata(p_in:m,3));
                oper_info.bestprice(i) = z;
                [h,g] = max(todaydata(p_in:m,2));
                oper_info.badprice(i) = h;
                break;
               elseif B <= v * A                          %% 5.2  �ڶ��� �س�ֹӯ ���� 
                oper_info.outplace(i) = j+1; 
                oper_info.outprice(i) = price_in - r*floor(v * A/r);  
                oper_info.profit(i)   = r*floor(v * A/r);
                [z,x] = min(todaydata(p_in:m,3));
                oper_info.bestprice(i) = z;
                [h,g] = max(todaydata(p_in:m,2));
                oper_info.badprice(i) = h;
                break;
                
               end
               
            end %% for j 
       end
       if  j == m-1                                   %%  6 �������̳��� 
            oper_info.outplace(i) = m; 
            oper_info.outprice(i) = todaydata(m,4); 
            oper_info.profit(i)   =  price_in - todaydata(m,4); 
            [z,x] = min(todaydata(p_in:m,3));
                oper_info.bestprice(i) = z;
                [h,g] = max(todaydata(p_in:m,2));
                oper_info.badprice(i) = h;
        end
    end  %% for j
    end%% if signal.direct > 0 or < 0
    
end  %% for i = 1:length(signal)