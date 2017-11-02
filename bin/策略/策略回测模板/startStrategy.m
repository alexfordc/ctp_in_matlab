%% main.m �ز�ģ�������� ����ģ����в����Ķ���ͱ���������
%% Ԥ��֪ʶ  ��Ʒһ����225��BAR�� ��ָһ����270��BAR
clear;clc;tic;    
disp('һ����������')
%%
addpath('DATA')
data.sec_point = [1, 75, 135, 175,270]; %% һ���ж��ٸ�һ���ӵ�bar
data.sec_pointnew = [1,75, 135,270];
per = [12 6 3 1 2];      %% �ָ���� [�� �� �� �� ��]
factor =300; %% ÿ����
fee =80;  %% ÿ�������ѽ��
deposit = 100000; %% ��֤��
l_print =1; %%�Ƿ����
disp('������������')
%%
initime=30 ;%��ʼ����ʱ��
slipe =0.2  ;%����
endtime=5  ;%��������ʱ��
maxtime = 3 ;%���״���
disp('������������')
%%
    minmove =0.2; %��С����
    stoploss =12; %ֹ���λ
    sp1 =9  ;%����������
    pp1 =0.1   ;%�������
    sp2 =18   ;%һ��ֹӯ��
    pp2 =0.2   ;%һ���ز����
    sp3 =60   ;%����ֹӯ��
    pp3 =0.6  ; %�����ز����

disp('������ȡ����')
%%
load('data.mat')
% load('IF000.mat')
len_day = data.sec_point(end); %һ���ж��ٸ�bar 
n_day = size(raw_data,1)/len_day;%%��������
disp('��������ÿ��ļ۸�����')
%%
for i =1:n_day  
 all_daydata{i} = raw_data(len_day*(i-1)+1:len_day*(i-1) + len_day,:); 
end

disp('�ġ�OUTPUT ͳ�Ʊ�ͷ')
%%
if ~exist('sys_result','dir')
mkdir sys_result ;
end 
output{1,1} = 'ģ��-���� ͳ�Ʊ�';  
output{2,1} = 'model 1'; output{2,2}= 'model 2'; output{2,3}= 'model 3';   output{2,4}= 'model 4';
output{2,5} = '�ܽ��״���'; output{2,6} = '��ʤ��'; output{2,7} = 'ƽ��ӯ����'; output{2,8} = '��ӯ����'; output{2,9} = '�ۺ�����'; 
output{2,10} = [num2str(per(1)) '���½��״���']; output{2,11} = [num2str(per(1)) '����ʤ��']; output{2,12} = [num2str(per(1)) '����ƽ��ӯ����'];
output{2,13} = [num2str(per(1)) '���¾�ӯ����']; output{2,14} = [num2str(per(1)) '�����ۺ�����']; 
output{2,15} = [num2str(per(2)) '���½��״���']; output{2,16} = [num2str(per(2)) '����ʤ��']; output{2,17} = [num2str(per(2)) '����ƽ��ӯ����'];
output{2,18} = [num2str(per(2)) '���¾�ӯ����']; output{2,19} = [num2str(per(2)) '�����ۺ�����']; 
output{2,20} = [num2str(per(3)) '���½��״���']; output{2,21} = [num2str(per(3)) '����ʤ��']; output{2,22} = [num2str(per(3)) '����ƽ��ӯ����'];
output{2,23} = [num2str(per(3)) '���¾�ӯ����']; output{2,24} = [num2str(per(3)) '�����ۺ�����'];
output{2,25} = [num2str(per(4)) '���½��״���']; output{2,26} = [num2str(per(4)) '����ʤ��']; output{2,27} = [num2str(per(4)) '����ƽ��ӯ����'];
output{2,28} = [num2str(per(4)) '���¾�ӯ����']; output{2,29} = [num2str(per(4)) '�����ۺ�����'];
output{2,30} = [num2str(per(5)) '�ܽ��״���']; output{2,31} = [num2str(per(5)) '��ʤ��']; output{2,32} = [num2str(per(5)) '��ƽ��ӯ����'];
output{2,33} = [num2str(per(5)) '�ܾ�ӯ����']; output{2,34} = [num2str(per(5)) '���ۺ�����'];
i_run = 2; 
disp('�塢ģ�ͽ���ģ��Ͳ��Լ�Ч���ģ��')
        %% ����ѭ���Ż�����
%          for initime = 30:1:30
%              for endtime =5:1:5
%                  for slipe = 1:1:1
%                      for maxtime =3:1:3
%                          for stoploss = 17:1:17
%                              for sp1 =17:1:17
%                                  for pp1 = 5:1:5
%                                      for sp2 = 35:1:35
%                                          for pp2 = 0.4:0.1:0.4
%                                              for sp3 = 90:1:90
%                                                  for pp3 =0.6:0.1:06
clear models
i_run = i_run + 1;
model_info = ['fsys is dealing with ', num2str(i_run-2), '-th parameters group']   ;
disp(model_info);

models{1}.name = '4candle'; % ���õĲ�������
models{1}.inpara{1} = [initime slipe endtime 0 150];           %%  'price_break' [���ʱ��t ����c ����ǰn���Ӳ����� һ������������ ǰ��������]
models{1}.inpara{2} = data.sec_point;
models{1}.outpara{1} = 'simple'; 
models{1}.outpara{2} =[minmove stoploss sp1 pp1 sp2 pp2 sp3 pp3 1];   %%[�۸�λ�� ֹ��  �������� ����  ��һ����ӯ���� ��һ���س��ٷֱ� �ڶ�����ӯ���� �ڶ����س��ٷֱ�]

disp('5.1 : strategy ��������')
%%
strategy.name = 'simple';
strategy.para = 0;  %% -1:ƽ������ 0��ƽ�������� 1����ƽ������

disp('5.2: ������ԵĽ����ͳ��������б��')
%%
computeStrategy; 

disp('5.3:���������������')
if ~isempty(models)
%% fix_time   [ʱ�䴰�� ���ನ������ ���ղ������� ���� ����ǰn���Ӳ����� ����������� ���մ�������]
output{i_run,1} = [models{1}.name ' : ' num2str(models{1}.inpara{1}(1)) ' ' num2str(models{1}.inpara{1}(2))  ' ' num2str(models{1}.inpara{1}(3)) ' ' num2str(models{1}.inpara{1}(4)) ' ' num2str(models{1}.inpara{1}(5))...%% ' ' num2str(models{1}.inpara{1}(6))  ' ' num2str(models{1}.inpara{1}(7))...%%  ' ' num2str(models{1}.inpara{1}(8)) ...
                     ' ' num2str(models{1}.outpara{2}(1)) ' ' num2str(models{1}.outpara{2}(2)) ' ' num2str(models{1}.outpara{2}(3)) ' ' num2str(models{1}.outpara{2}(4)) ' ' num2str(models{1}.outpara{2}(5)) ' ' num2str(models{1}.outpara{2}(6))...
                     ' ' num2str(models{1}.outpara{2}(7)) ' ' num2str(models{1}.outpara{2}(8))];
end

if length(models) > 1
output{i_run,2} = [models{2}.name ' : '  num2str(models{2}.inpara{1}(1)) ' ' num2str(models{2}.inpara{1}(2)) ' ' num2str(models{2}.inpara{1}(3))...
                   ' ' num2str(models{2}.outpara{2}(1)) ' ' num2str(models{2}.outpara{2}(2)) ' ' num2str(models{2}.outpara{2}(3)) ' ' num2str(models{2}.outpara{2}(4))...
                    ' ' num2str(models{2}.outpara{2}(5)) ' ' num2str(models{2}.outpara{2}(6)) ' ' num2str(models{2}.outpara{2}(7)) ' ' num2str(models{2}.outpara{2}(8))];
%                      ' ' num2str(models{2}.outpara{2}(9)) ' ' num2str(models{2}.outpara{2}(10)) ];   
end

if length(models) > 2
output{i_run,3} = [models{3}.name ' : '  num2str(models{3}.inpara{1}(1)) ' ' num2str(models{3}.inpara{1}(2)) ' ' num2str(models{3}.inpara{1}(3)) ' ' num2str(models{3}.inpara{1}(4)) ...      
                     ' ' num2str(models{3}.outpara{2}(1)) ' ' num2str(models{3}.outpara{2}(2)) ' ' num2str(models{3}.outpara{2}(3)) ' ' num2str(models{3}.outpara{2}(4))...
                    ' ' num2str(models{3}.outpara{2}(5)) ' ' num2str(models{3}.outpara{2}(6)) ' ' num2str(models{3}.outpara{2}(7)) ' ' num2str(models{3}.outpara{2}(8))];      
end

if length(models) > 3
output{i_run,4} = [models{4}.name ' : '  num2str(models{4}.inpara{1}(1)) ' ' num2str(models{4}.inpara{1}(2)) ' ' num2str(models{4}.inpara{1}(3)) ' ' num2str(models{4}.inpara{1}(4)) ...      
                    num2str(models{4}.inpara{1}(5))];  
end


for i_c = 1:length(per)+1
    trades(i_c) = stas(1+5*(i_c-1))+stas(3+5*(i_c-1)); 
    P(i_c) = stas(1+5*(i_c-1))/trades(i_c) ; 
    A(i_c) = - ( stas(2+5*(i_c-1))/stas(1+5*(i_c-1)) ) / ( stas(4+5*(i_c-1))/stas(3+5*(i_c-1)) ); 
    Profit(i_c) = stas(2+5*(i_c-1)) + stas(4+5*(i_c-1));
    kelly = max(0,((1 + A(1)) * P(1) - 1)/A(1));
    ProPer(i_c) = Profit(i_c)/ stas(5+5*(i_c-1)) / deposit * kelly;
end

for i_c = 1:6
    output{i_run,0+5*i_c} = trades(i_c);
    output{i_run,1+5*i_c} = P(i_c);
    output{i_run,2+5*i_c} = A(i_c);
    output{i_run,3+5*i_c} = Profit(i_c);
    output{i_run,4+5*i_c} = ProPer(i_c);
end
%                                                  end %%pp3
%                                              end %%sp3
%                                          end %%pp2
%                                      end %%sp2
%                                  end %%pp1
%                              end %%sp1
%                          end %%stoploss
%                      end %%maxtime
%                  end %%slipe
%              end %%endtime
%          end %%initime
%          

disp('����OUTPUT ͳ�Ʊ�����')
%%
xlswrite('.\sys_result\���׼�Ч\��ָ��Ч.xls',output);
rmpath('DATA')
toc;













