function [ output, tradeDetail, output1, totalDiff] = Signal4( Open, High, Low ,Close, Date, Sig, maxLots, flag,ppoint,lpoint)
%% ��������Ҫ���sig�ֱ�ΪBK��SP��SK�� BP���źţ��������ײ��Բ���ͼ�б��BS��
%maxLots:���ֲ�����Ĭ��Ϊ1�������ֻ����1�ʳֲ�
%flag:�Ƿ�Ҫ��ͼ��1����ͼ��0������




if nargin==6
    maxLots=1;
    flag=0;
elseif nargin==7
    flag=0;
end
% if rem(maxLots,1)~=0
%     error('maxLots����Ϊ������');
% end
% 
% if isempty(flag)
%     flag=0;
% end

Sig1=Sig(:,1);
Sig2=Sig(:,2);
Sig3=Sig(:,3);
Sig4=Sig(:,4);

%%���Sig1��Sig2��ͬһʱ��㷢�����������źţ��򲻿���
ind1=(Sig1==Sig2);
ind3=(Sig3==Sig4);
Sig1(ind1)=0;
Sig2(ind1)=0;
Sig3(ind3)=0;
Sig4(ind3)=0;

if sum(Sig1+Sig3)==0
%     error(message('MATLAB:signal2:nosignal'));
    disp('MATLAB:Signal2:û�в��������ź�');
end



%% �������
%%����Ƶ�ʣ�ƽ�������ʣ�ʤ��
%%��������
%%��ֵ����
tradeNumber=0;%�ܽ��״���
buyNumber=0;%��ͷ���״���
sellNumber=0;%��ͷ���״���
Position1=0;%��ͷ��λ
Position2=0;%��ͷ��λ
winNumber=0;%��¼�ɹ����״���
ret=[];%%ÿ�ν��׵������ʣ����ǳɱ���
lret=[];%%ÿ�ν��׵�����
cost=[];%%ÿ�ν��׳ɱ�����һ��Ϊ�����ѣ��ڶ���Ϊ���ӷѣ�������Ϊ���
%%���б���
inPrice1=[];%%��ͷ���ּ۸�
outPrice1=[];%%��ͷƽ�ּ۸�
inDate1={};%%����ʱ��
outDate1={};%%����ʱ��
inPos1=[];%%��¼����λ�ã�������ͼ
outPos1=[];%%��¼����λ�ã�������ͼ
inDire1=[];%%ÿ�εĽ����ķ���  1��ʾ����  -1��ʾ����
outDire1=[];%%ÿ�εĳ�������

inPrice2=[];%%��ͷ���ּ۸�
outPrice2=[];%%��ͷƽ�ּ۸�
inDate2={};%%����ʱ��
outDate2={};%%����ʱ��
inPos2=[];%%��¼����λ�ã�������ͼ
outPos2=[];%%��¼����λ�ã�������ͼ
%%���׼�¼���������Ҫ�õ��ı���
inDire2=[];%%ÿ�εĽ����ķ���  1��ʾ����  -1��ʾ����
outDire2=[];%%ÿ�εĳ�������


if maxLots==1
    for i=1:length(Close)
        if Sig1(i)==1 && Position1==0
            Position1=1;
            buyNumber=buyNumber+1;
            inPrice1(buyNumber)=Close(i);
            inDire1(buyNumber)=1;
            inDate1(buyNumber)=Date(i);
            inPos1(buyNumber)=i;
        end
        %%ֹӯֹ��
        if Position1==1
            if exist('ppoint','var')  %%ֹӯ
            if i>inPos1(buyNumber) && High(i)>(ppoint+inPrice1(buyNumber));
                Position1=0;
                outPrice1(buyNumber)=inPrice1(buyNumber)+ppoint;
                outDire1(buyNumber)=-1;
                outDate1(buyNumber)=Date(i);
                outPos1(buyNumber)=i;
            end
            end
            if exist('lpoint','var')  %%ֹ��
            if i>inPos1(buyNumber) && Low(i)<(inPrice1(buyNumber)-lpoint);
                Position1=0;
                outPrice1(buyNumber)=inPrice1(buyNumber)-lpoint;
                outDire1(buyNumber)=-1;
                outDate1(buyNumber)=Date(i);
                outPos1(buyNumber)=i;
            end
            end
        end
        
        if Sig2(i)==1 && Position1==1
            Position1=0;
            outPrice1(buyNumber)=Close(i);
            outDire1(buyNumber)=-1;
            outDate1(buyNumber)=Date(i);
            outPos1(buyNumber)=i;
        end
        if Sig3(i)==1 && Position2==0
            Position2=-1;
            sellNumber=sellNumber+1;
            inPrice2(sellNumber)=Close(i);
            inDire2(sellNumber)=-1;
            inDate2(sellNumber)=Date(i);
            inPos2(sellNumber)=i;
        end
        %%ֹӯֹ��
        if Position2==-1
            if exist('ppoint','var')  %%ֹӯ
            if i>inPos2(sellNumber) && Low(i)<(inPrice2(sellNumber)-ppoint);
                Position2=0;
                outPrice2(sellNumber)=inPrice2(sellNumber)-ppoint;
                outDire2(sellNumber)=1;
                outDate2(sellNumber)=Date(i);
                outPos2(sellNumber)=i;
            end
            end
            if exist('lpoint','var')  %%ֹӯ
            if i>inPos2(sellNumber)  && High(i)>(inPrice2(sellNumber)+lpoint);
                Position2=0;
                outPrice2(sellNumber)=inPrice2(sellNumber)+lpoint;
                outDire2(sellNumber)=1;
                outDate2(sellNumber)=Date(i);
                outPos2(sellNumber)=i;
            end
            end
        end
        
        if Sig4(i)==1 && Position2==-1
            Position2=0;
            outPrice2(sellNumber)=Close(i);
            outDire2(sellNumber)=1;
            outDate2(sellNumber)=Date(i);
            outPos2(sellNumber)=i;
        end
        
        %������������δƽ�֣��򲻿������һ�ν���
        if i==length(Close) && Position1==1
            Position1=0;
            inPrice1(buyNumber)=[];
            inDire1(buyNumber)=[];
            inDate1(buyNumber)=[];
            inPos1(buyNumber)=[];
            buyNumber=buyNumber-1;
        end
        if i==length(Close) && Position2==-1
            Position2=0;
            inPrice2(sellNumber)=[];
            inDire2(sellNumber)=[];
            inDate2(sellNumber)=[];
            inPos2(sellNumber)=[];
            sellNumber=sellNumber-1;
        end
        
    end
    
else %�������Ӳ�
    for i=1:length(Close)
        if Sig1(i)==1 && (Position1-Position2)<maxLots
            Position1=Position1+1;
            buyNumber=buyNumber+1;
            inPrice1(buyNumber)=Close(i);
            inDire1(buyNumber)=1;
            inDate1(buyNumber)=Date(i);
            inPos1(buyNumber)=i;
        elseif Sig2(i)==1 && Position1>0
            
            outPrice1(buyNumber-Position1+1:buyNumber)=Close(i);
            outDire1(buyNumber-Position1+1:buyNumber)=-1;
            outDate1(buyNumber-Position1+1:buyNumber)=Date(i);
            outPos1(buyNumber-Position1+1:buyNumber)=i;
            Position1=0;
        end
        if Sig3(i)==1 && (Position1-Position2)<maxLots
            Position2=Position2-1; %���յ���
            sellNumber=sellNumber+1;
            inPrice2(sellNumber)=Close(i);
            inDire2(sellNumber)=-1;
            inDate2(sellNumber)=Date(i);
            inPos2(sellNumber)=i;
        elseif Sig4(i)==1 && Position2<0
            
            outPrice2(sellNumber+Position2+1:sellNumber)=Close(i);
            outDire2(sellNumber+Position2+1:sellNumber)=1;
            outDate2(sellNumber+Position2+1:sellNumber)=Date(i);
            outPos2(sellNumber+Position2+1:sellNumber)=i;
            Position2=0;
        end
        
        %������������δƽ�֣��򲻿������һ�ν���
        if i==length(Close) && Position1>0
            
            inPrice1(end-Position1+1:end)=[];
            inDire1(end-Position1+1:end)=[];
            inDate1(end-Position1+1:end)=[];
            inPos1(end-Position1+1:end)=[];
            buyNumber=buyNumber-Position1;
            Position1=0;
        end
        if i==length(Close) && Position2<0
            
            inPrice2(end+Position2+1:end)=[];
            inDire2(end+Position2+1:end)=[];
            inDate2(end+Position2+1:end)=[];
            inPos2(end+Position2+1:end)=[];
            sellNumber=sellNumber+Position2;
            Position2=0;
        end
    end
    
end

inPrice=[inPrice1,inPrice2];
outPrice=[outPrice1,outPrice2];
inDate=[inDate1,inDate2];
outDate=[outDate1,outDate2];
inPos=[inPos1,inPos2];
outPos=[outPos1,outPos2];
inDire=[inDire1,inDire2];
outDire=[outDire1,outDire2];


[inPos, ind] = sort(inPos); %���볡������

outPos=outPos(ind);

inPrice=inPrice(ind);
outPrice=outPrice(ind);
inDate=inDate(ind);
outDate=outDate(ind);
inDire=inDire(ind);
outDire=outDire(ind);

tradeNumber=buyNumber+sellNumber;

%%����ÿ�������ʣ�RetFun������
for i=1:tradeNumber
    date1=inDate(i);
    date2=outDate(i);
    date1=datestr(date1,'yyyy-mm-dd');
    date2=datestr(date2,'yyyy-mm-dd');
    %���ڷ�����Num,�賿4��Ϊ�ֽ���
    Num(i)=daysact(date1, date2);
    if hour(inDate(i))>4 && hour(outDate(i))<4 
        Num(i)=Num(i)-1;
    elseif hour(inDate(i))<4 && hour(outDate(i))>4
        Num(i)=Num(i)+1;
    end

    [ret(i),lret(i),cost(i,:)]=RetFun(inPrice(i),outPrice(i),inDire(i),Num(i));
% [ret(i),lret(i),cost(i,:)]=RetFunNoCost(inPrice(i),outPrice(i),inDire(i),Num(i));
%     [ret(i),lret(i),cost(i,:)]=RetFunnodc(inPrice(i),outPrice(i),inDire(i),Num(i));
% [ret(i),lret(i),cost(i,:)]=RetFun40(inPrice(i),outPrice(i),inDire(i),Num(i));
    
end

%  tradeDetail={};
%  tradeDetail{1,1}='����ʱ��';tradeDetail{1,2}='����ʱ��';tradeDetail{1,3}='��������';tradeDetail{1,4}='�����۸�';
%  tradeDetail{1,5}='�����۸�';tradeDetail{1,6}='ÿ��������';tradeDetail{1,7}='����ʱ��(��)';
% for i=1:tradeNumber
% tradeDetail{i+1,1}=inDate{i};tradeDetail{i+1,2}=outDate{i};tradeDetail{i+1,3}=inDire(i);
% tradeDetail{i+1,4}=inPrice(i);tradeDetail{i+1,5}=outPrice(i);tradeDetail{i+1,6}=ret(i);tradeDetail{i+1,7}=Num(i);
% end
% 
% % disp('���׼�¼��ϸ��');
% % disp(tradeDetail);
% 
% %����Ƶ��
% % day0=datestr(Date(1),'yyyy-mm-dd');
% % dayend=datestr(Date(end),'yyyy-mm-dd');
% % Totaldays=daysact(day0,dayend);
% Totaldays=round(length(Close)/22); %ÿ��22������Сʱ
% Fre=tradeNumber/Totaldays; %��λ����/��
% 
% %ƽ��������
% aveReturn=mean(ret);
% 
% %ʤ��
% winRatio=length(ret(ret>0))/tradeNumber;
% 
% %����ʤ��
% bwin=length(ret(ret(inDire==1)>0))/buyNumber;
% 
% %����ʤ��
% swin=length(ret(ret(inDire==-1)>0))/sellNumber;
% 
% %%���׼�Чд�뽻�׼�Ч��
% output{1,1}='ʤ��';output{1,2}='���״���';output{1,3}='����Ƶ��(��/��)';output{1,4}='ƽ��������';output{1,5}='��󵥴�ӯ��';output{1,6}='��󵥴ο���';
% output{1,7}='�������';output{1,8}='����ʤ��';output{1,9}='���մ���';output{1,10}='����ʤ��';
% output{2,1}=winRatio;output{2,2}=tradeNumber;output{2,3}=Fre;output{2,4}=aveReturn;output{2,5}=max(ret);output{2,6}=min(ret);
% output{2,7}=buyNumber;output{2,8}=bwin;output{2,9}=sellNumber;output{2,10}=swin;
% % disp('���׼�Ч�б����£�');
% % disp(output);




if tradeNumber<=0
    disp('MATLAB:Signal1:û�в��������ź�');
end

iniCap=100000; %��ʼ�ʽ�10w
finCap=iniCap+sum(lret);
totalRet=(finCap-iniCap)/iniCap;
ljret=cumsum(lret); %�ۼ�ӯ��
tradeCost=sum(cost,2);%ÿ�ν��׳ɱ�

holdCycle=[]; %��������
tradeDiff=zeros(size(Close));
% if maxLots==1
%     if tradeNumber>0
%         holdCycle=outPos-inPos; %�������ڣ�Сʱ��
%         tradeDiff(outPos)=lret';
%     end
%     totalDiff=iniCap+cumsum(tradeDiff);
% else
if ~isempty(inPos) & ~isempty(outPos)
[~,ind]=sortrows([outPos,inPos],[1,2]);
outPos0=outPos;
outPos0(:,1)=outPos(ind);%%�����������򣬼����ۼ�������
lret1=lret;
lret1(:,1)=lret(ind);
end
    if tradeNumber>0
        tradeDiff(outPos0(1))=lret(1);
        holdCycle=outPos-inPos; %�������ڣ�Сʱ��
        %% �����4Сʱ�����ݣ�holdCycleҪ����4
        for i=2:tradeNumber
            if outPos0(i)==outPos0(i-1)
                tradeDiff(outPos0(i))=lret1(i)+tradeDiff(outPos0(i));
            else
                tradeDiff(outPos0(i))=lret1(i);
            end
        end
        totalDiff=iniCap+cumsum(tradeDiff);
    else
        totalDiff=zeros(size(Close));
    end
% end

 tradeDetail={};
 tradeDetail{1,1}='����ʱ��';tradeDetail{1,2}='����ʱ��';tradeDetail{1,3}='��������';tradeDetail{1,4}='�����۸�';
 tradeDetail{1,5}='�����۸�';tradeDetail{1,6}='ÿ��������';tradeDetail{1,7}='ÿ��ӯ��';tradeDetail{1,8}='����ʱ��(��)';tradeDetail{1,9}='���׳ɱ�';tradeDetail{1,10}='�ۼ�ӯ��';
for i=1:tradeNumber
tradeDetail{i+1,1}=inDate{i};tradeDetail{i+1,2}=outDate{i};tradeDetail{i+1,3}=inDire(i);
tradeDetail{i+1,4}=inPrice(i);tradeDetail{i+1,5}=outPrice(i);tradeDetail{i+1,6}=ret(i);
tradeDetail{i+1,7}=lret(i);tradeDetail{i+1,8}=Num(i);tradeDetail{i+1,9}=tradeCost(i);
tradeDetail{i+1,10}=ljret(i);
end

% disp('���׼�¼��ϸ��');
% disp(tradeDetail);

%����Ƶ��
day0=datestr(Date(1),'yyyy-mm-dd');
dayend=datestr(Date(end),'yyyy-mm-dd');
% Totaldays=daysact(day0,dayend);
% Totaldays=round(length(Close)/22); %ÿ��22������Сʱ
Totaldays=416;
Fre=tradeNumber/Totaldays; %��λ����/��

%ƽ��������
aveReturn=mean(ret);

%ʤ��
winRatio=length(ret(ret>0))/tradeNumber;

%����ʤ��
bwin=length(ret(ret(inDire==1)>0))/buyNumber;

%����ʤ��
swin=length(ret(ret(inDire==-1)>0))/sellNumber;
if isnan(bwin)
    bwin=0;
end
if isnan(swin)
    swin=0;
end

%%���׼�Чд�뽻�׼�Ч��
output={};
output{1,1}='ʤ��';output{1,2}='���״���';output{1,3}='����Ƶ��(��/��)';output{1,4}='ƽ��������';output{1,5}='��󵥴�ӯ��';output{1,6}='��󵥴ο���';
output{1,7}='�������';output{1,8}='����ʤ��';output{1,9}='���մ���';output{1,10}='����ʤ��';output{1,11}='��������';output{1,12}='�ܳɱ�';
output{2,1}=winRatio;output{2,2}=tradeNumber;output{2,3}=Fre;output{2,4}=aveReturn;output{2,5}=max(ret);output{2,6}=min(ret);
output{2,7}=buyNumber;output{2,8}=bwin;output{2,9}=sellNumber;output{2,10}=swin;output{2,11}=totalRet;output{2,12}=sum(tradeCost);
% disp('���׼�Ч�б����£�');
% disp(output);






%%���output����ϸ��Ϣ
%%��ʼ�ʽ�10W��ÿ�ο���1��׼��
%%��������=(finCap-iniCap)/iniCap;
%%ƽ��������=mean(ret) %���ʼ�ʽ��޹�
%%ƽ��ÿ��ӯ��=mean(lret)
if min(totalDiff)>0
    maxd=maxdrawdown(totalDiff);
else
    maxd=1;
end
output1={};
output1{1,1}='ģ�͵���ϸ������Ϣ';
output1{2,1}='��������';output1{2,2}=Totaldays;output1{2,4}='����������';output1{2,5}=length(Close);
output1{3,1}='ָ������'; output1{3,2}=tradeNumber;output1{3,4}='ƽ����������';output1{3,5}=floor(length(Close)/tradeNumber);
output1{4,1}='��ʼ�ʽ�'; output1{4,2}=iniCap; output1{4,4}='����Ȩ��'; output1{4,5}=finCap;
output1{5,1}='��������'; output1{5,2}=totalRet; output1{5,4}='��ӯ��'; output1{5,5}=finCap-iniCap;
output1{6,1}='�۳����ӯ����������'; output1{6,2}=(finCap-iniCap-lret(ret==max(ret)))/iniCap; output1{6,4}='�۳��������������'; output1{6,5}=(finCap-iniCap-lret(ret==min(ret)))/iniCap; 

output1{8,1}='�ɿ���(ʤ��)'; output1{8,2}=winRatio;
output1{9,1}='�ܽ��״���'; output1{9,2}=tradeNumber;output1{9,4}='�ʽ����س�'; output1{9,5}=maxd;
output1{10,1}='ӯ����������';output1{10,2}=winRatio;output1{10,4}='�����������';output1{10,5}=1-winRatio;
output1{11,1}='ƽ��������';output1{11,2}=aveReturn;output1{11,4}='ƽ��ÿ��ӯ��';output1{11,5}=mean(lret);
output1{12,1}='��׼�����';output1{12,2}=std(ret)/aveReturn;output1{12,4}='��׼���';output1{12,5}=std(ret);
output1{13,1}='��ͷ����';output1{13,2}=buyNumber;output1{13,4}='��ͷ����';output1{13,5}=sellNumber;
output1{14,1}='��ͷӯ������';output1{14,2}=bwin*buyNumber;output1{14,4}='��ͷӯ������';output1{14,5}=swin*sellNumber;

output1{16,1}='ӯ������';output1{16,2}=round(winRatio*tradeNumber);output1{16,4}='�������';output1{16,5}=tradeNumber-round(winRatio*tradeNumber);
output1{17,1}='��ӯ����';output1{17,2}=sum(lret(ret>0));output1{17,4}='�ܿ����';output1{17,5}=-sum(lret(ret<0));
output1{18,1}='���ӯ����';output1{18,2}=max(lret);output1{18,4}='�������';output1{18,5}=-min(lret);
output1{19,1}='���������';output1{19,2}=max(ret);output1{19,4}='��С������';output1{19,5}=min(ret);
output1{20,1}='ƽ��ӯ������';output1{20,2}=mean(holdCycle(ret>0));output1{20,4}='ƽ����������';output1{20,5}=mean(holdCycle(ret<0));

if isnan(output1{20,5})
    output1{20,5}=0;
end
if isnan(output1{20,2})
    output1{20,3}=0;
end
% output1{21,1}='�������ӯ������';output1{21,2}=max(holdCycle(ret>0));output1{21,4}='���������������';output1{21,5}=max(holdCycle(ret<0));
% output1{22,1}='�������ӯ��';output1{22,2}=max(holdCycle(ret>0));output1{21,4}='���������������';output1{21,5}=max(holdCycle(ret<0));
%����ղ�ʱ��
cyc1=outPos(1:end-1)-inPos(2:end);
kctime=length(Close)-(sum(holdCycle)-sum(cyc1(cyc1>0)));
output1{21,1}='�ղ���ʱ��(Сʱ)';output1{21,2}=kctime;output1{21,4}='�ղ�ʱ��/��ʱ��';output1{21,5}=kctime/length(Close);

output1{22,1}='ƽ���ֲ�����';output1{22,2}=mean(holdCycle);
%�ɱ�����
if tradeNumber>=1
percost=sum(cost,1);%�ɱ����࣬�����ѣ����ӷѣ�����ܺ�
output1{23,1}='�ܳɱ�';output1{23,2}=sum(tradeCost);output1{23,4}='�������ܺ�';output1{23,5}=percost(1);
output1{24,1}='���ӷ��ܺ�';output1{24,2}=percost(2);output1{24,4}='����ܼ�';output1{24,5}=percost(3);
end











%% ��ͼ
% 
% clf;
% %% ͼ1
% subplot('Position',[0.13 0.38 0.775 0.54])%%˫ͼ����ͼ��ʾK�ߺ��ʽ����ߣ�Сͼ��ʾָ���ߣ�����KD��
% 
% [AX,H1,H2] =plotyy(1:length(Close),Close,1:length(totalDiff),totalDiff);
% % set(gca,'Xtick',[0 500,1000,1500,2000],...'XtickLabel','22-Jan-2006|22-Jan-2006|22-Jan-2007|22-Jan-2008|22-Jan-2009');
% tick1=get(gca,'XTick');
% % xlabel=datestr([Date{1},Date{tick1(2:end-1)}])
% % datenum(year(Date{tick1(2:end-1)}),month(Date{tick1(2:end-1)}),day(Date{tick1(2:end-1)}))
% xlb=Date{1};
% for i=2:length(tick1)-1
%     xlb=[xlb,'|',Date{tick1(i)}];
% end
% 
% 
% 
% %%���������
% %��ɫ��ʾ���֣���ɫ��ʾƽ��
% text(inPos(inDire==1),Close(inPos(inDire==1))-1,'\uparrow','Color','m','FontWeight','bold');
% text(inPos(inDire==-1),Close(inPos(inDire==-1))+1,'\downarrow','Color','m','FontWeight','bold');
% text(outPos(outDire==1),Close(outPos(outDire==1))-1,'\uparrow','Color','g','FontWeight','bold');
% text(outPos(outDire==-1),Close(outPos(outDire==-1))+1,'\downarrow','Color','g','FontWeight','bold');
% 
% set(AX(2),'XColor','k','YColor','r');
% set(AX(1),'Xtick',tick1(1:end-1));
% set(AX(2),'Xtick',tick1(1:end-1));
% set(AX(1),'XtickLabel',xlb);
% set(AX(2),'XtickLabel',[]);
% 
% HH1=get(AX(1),'Ylabel');
% set(HH1,'String','���̼�');
% set(HH1,'color','b');
% set(HH1,'FontSize',20);
% HH2=get(AX(2),'Ylabel');
% set(HH2,'String','�ʽ�����');
% set(HH2,'color','r');
% set(HH2,'FontSize',20);
% 
% set(H2,'color','r');
% 
% % set(H2,'Color','r');
% grid on;
% 
% set(gca,'XColor','b');
% ch=get(gca,'XTickLabel');
% ch1=ch(:,1:10);
% ch1(1,:)='          ';
% set(gca,'XTickLabel',ch1);
% title('�۸��������ʽ�����ͼ','FontSize',20);
% 
% if flag==1
% 
% %% ��ͼ�����BS��
% plotbar=[Open,High,Low,Close];
% cndlV2(plotbar,Date,'r','b');
% hold on;
% % set(gca,'XTickLabel',['0',Date(1000:1000:end)]);
% grid on;
% % whitebg('k');
% set(gca,'YLim',[2000 9000]);
% %%���������
% for i=1:tradeNumber
%     if inDire(i)==1
%         text(inPos(i),Low(inPos(i))-1,{'\uparrow';'BK'},'FontSize',8,'FontUnits','normalized');
%     else
%         text(inPos(i),High(inPos(i))+3,{'SK';'\downarrow'},'FontSize',8,'FontUnits','normalized');
%     end
%     if outDire(i)==1
%         text(inPos(i),Low(inPos(i))-1,{'\uparrow';'BP'},'FontSize',8,'FontUnits','normalized');
%     else
%         text(inPos(i),High(inPos(i))+3,{'SP';'\downarrow'},'FontSize',8,'FontUnits','normalized');
%     end
% end
% end
% end

