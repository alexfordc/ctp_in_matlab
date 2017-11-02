%% ����C#�⣬�밴�Լ�Ŀ¼���е���
p = pwd;cd(p);
NET.addAssembly(fullfile(cd,'QuantBoxCSharp.dll'));
import QuantBoxCSharp.*;

%% ���m�ļ�����·��
addpath(cd) 
addpath(fullfile(cd,'\MD�ص�')) 
addpath(fullfile(cd, '\TD�ص�')) 
addpath(fullfile(cd, '\����'))   
addpath(fullfile(cd, '\������'))  
addpath(fullfile(cd, '\������\��������'))  
addpath(fullfile(cd, '\UI'))  

%% ����
global md;
md =  MdApiWrapper();
addlistener(md,'OnConnect',@OnMdConnect);
addlistener(md,'OnDisconnect',@OnMdDisconnect);
addlistener(md,'OnRspError',@OnRspError);
addlistener(md,'OnRtnDepthMarketData_Tick',@OnRtnDepthMarketData);
addlistener(md,'OnHistoryTick',@OnMdHistoryTick);
addlistener(md,'OnHistoryKLine',@OnMdHistoryKLine);

ConnectMD();


%% ����
global td;
td = TraderApiWrapper();
addlistener(td,'OnConnect',@OnTdConnect);
addlistener(td,'OnDisconnect',@OnTdDisconnect);
addlistener(td,'OnErrRtnOrderAction',@OnErrRtnOrderAction);
addlistener(td,'OnErrRtnOrderInsert',@OnErrRtnOrderInsert);
addlistener(td,'OnRspError',@OnRspError);
addlistener(td,'OnRspOrderAction',@OnRspOrderAction);
addlistener(td,'OnRspOrderInsert',@OnRspOrderInsert);
addlistener(td,'OnRspQryDepthMarketData',@OnRspQryDepthMarketData);
addlistener(td,'OnRspQryInstrument',@OnRspQryInstrument);
addlistener(td,'OnRspQryInstrumentCommissionRate',@OnRspQryInstrumentCommissionRate);
addlistener(td,'OnRspQryInstrumentMarginRate',@OnRspQryInstrumentMarginRate);
addlistener(td,'OnRspQryInvestorPosition',@OnRspQryInvestorPosition);
addlistener(td,'OnRspQryInvestorPositionDetail',@OnRspQryInvestorPositionDetail);
addlistener(td,'OnRspQrySettlementInfo',@OnRspQrySettlementInfo);
addlistener(td,'OnRspQryOrder',@OnRspQryOrder);
addlistener(td,'OnRspQryTrade',@OnRspQryTrade);
addlistener(td,'OnRspQryTradingAccount',@OnRspQryTradingAccount);
addlistener(td,'OnRtnInstrumentStatus',@OnRtnInstrumentStatus);
addlistener(td,'OnRtnOrder',@OnRtnOrder);
addlistener(td,'OnRtnTrade',@OnRtnTrade);

ConnectTD();
