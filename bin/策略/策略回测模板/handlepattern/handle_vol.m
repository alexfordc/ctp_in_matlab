function oper_info = handle_vol(todaydata, signal, outpara)

%%% ���۳������� (���������������ź�)
%%  ��ϳɽ�������
%%% INPUT
%%  1 signal.name =     ''     STRING 
%%  2 signal.inplace =  []     VECTOR
%%  3 signal.direct  =  []     BOOL +1 or -1
%%  4 signal.inprcie =  []     VECTOR
%%  5 todaydata : data in today  [���̼� ��߼� ��ͼ� ���̼�]
%%  6 outpara =   [�۸�λ����r ֹ��s ����ɽ�δ���n �м�ɽ���������m]
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
n = outpara(3);  %% ����ɽ�δ���
m = outpara(4);  %% �м�ɽ���������


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
    k = 0;
    price_in = signal.inprice(i);
    p_in     = signal.inplace(i);

    if signal.direct(i) > 0                
       for j = p_in : len_day - 1
            
            if  j ~= p_in && price_in >= todaydata(j,1) + s       %% 1 ��������ֹ�����  (�����㲻�ÿ��ǿ�����������)
                oper_info.outplace(i) = j; 
                oper_info.outprice(i) = todaydata(j,1); 
                oper_info.profit(i)   = todaydata(j,1) - price_in;  
                break; 
                
            elseif  price_in >= todaydata(j,3) + s   %% 2 ֹ����� 
                oper_info.outplace(i) = j; 
                oper_info.outprice(i) = price_in - s;
                oper_info.profit(i)   = - s;
                break;
                
            elseif  j ~= p_in && todaydata(j-1,2) < todaydata(j,2) && todaydata(j+1,2)>=todaydata(j,2) ...
                    && (j+1<=75|| 75<j-1<=133 || 135<j-1<173 || 175<j-1)...
                    && todaydata(j-1,5) < todaydata(j,5) && todaydata(j+1,5)>=todaydata(j,5) &&  todaydata(j,5) >=m    %% 3 Ѱ�Ҽ۸�ͳɽ�����ɽ��
                k=k+1;
                if  k == n
                oper_info.outplace(i) = j + 2; 
                oper_info.outprice(i) = todaydata(j+2,1); 
                oper_info.profit(i)   = todaydata(j+2,1) - price_in; 
                break;
       
               end
               
            end
       end %% for j = p_in:len_dya
       if j == len_day - 1                                    %%  6 �������̳��� 
                oper_info.outplace(i) = len_day; 
                oper_info.outprice(i) = todaydata(len_day,4); 
                oper_info.profit(i)   = todaydata(len_day,4) - price_in; 
       end
       
    elseif signal.direct(i)< 0      
        
       for j = p_in : len_day - 1
             
            if  j ~= p_in && todaydata(j,1) >= price_in + s       %% 1 ��������ֹ�����   (�����㲻�ÿ��ǿ�����������)
                oper_info.outplace(i) = j; 
                oper_info.outprice(i) = todaydata(j,1); 
                oper_info.profit(i)   = price_in - todaydata(j,1);  
                
            elseif  todaydata(j,2) >= price_in + s   %% 2 ֹ����� 
                oper_info.outplace(i) = j; 
                oper_info.outprice(i) = price_in + s;
                oper_info.profit(i)   = - s;
                break;
                
            elseif  j ~= p_in && todaydata(j-1,3) > todaydata(j,2) && todaydata(j+1,3)<=todaydata(j,3) ...
                    && todaydata(j-1,5) < todaydata(j,5) && todaydata(j+1,5)>=todaydata(j,5) &&  todaydata(j,5) >=m    %% 3 Ѱ�Ҽ۸�ͳɽ�����ɽ��
                k=k+1;
                if  k == n
                
                oper_info.outplace(i) = j + 2; 
                oper_info.outprice(i) = todaydata(j+2,1);  
                oper_info.profit(i)   = todaydata(j+2,1) - price_in; 
                break;
                
                end
            end
            
    
   
       if  j == len_day - 1                                  %%  6 �������̳��� 
            oper_info.outplace(i) = len_day; 
            oper_info.outprice(i) = todaydata(len_day,4); 
            oper_info.profit(i)   =  price_in - todaydata(len_day,4); 
        end
    end  %% for j
    end%% if signal.direct > 0 or < 0
    
end  %% for i = 1:length(signal)