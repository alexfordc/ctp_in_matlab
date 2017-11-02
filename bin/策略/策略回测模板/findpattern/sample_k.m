function  [y z]= sample_k(x,n)
%% sampling k-line data, and rebuild k-line according to the interval n; 

%%% INPUT
%% x [���̼� ��߼� ��ͼ� ���̼�]   (ԭʼ k������ function cal_k is needed�� 
%% n ����Ƶ��

%%% OUTPUT
%% y [���̼� ��߼� ��ͼ� ���̼�]   (������ k������)
%% z ÿ����������ԭʼ���ݵ����Ŀ
%% 
%%  �����
col = size(x,2); 

if n ==1 
    y = x; z = ones(length(x),1);
    return;
end
total = length(x); 
n_sample = ceil(total/n);

y = zeros(n_sample,4); 
z = zeros(n_sample,1);

for i = 1 : n_sample-1
    a1 = (i-1) * n + 1;
    a2 = (i-1) * n + n;
    y(i,1:4) = cal_k(x(a1:a2,1:4));
    if col >= 5
        y(i,5) = sum(x(a1:a2,5));
    end
    z(i,1) = n;
end

a1 = (n_sample-1)*n + 1;
a2 = total;
y(n_sample,1:4) = cal_k(x(a1:a2,1:4)) ;
if col >= 5
    y(n_sample,5) = sum(x(a1:a2,5));
end
z(n_sample,1) = a2 - a1 + 1;



