function signals = find_pattern(hisdata,todaydata, models, ATR, day)
%%% 
%% INPUT
%%   1 models
%%      .outpara{1} = 'simple'    (��������)
%%      .outpara{2} =   [�۸�λ��r ֹ��s ��������d ����e ��һ����ӯ����p ��һ���س��ٷֱ�q �ڶ�����ӯ����u
%%    To find various patterns 
%%   signals{i}   <------>   models{i} 
%% OUTPUT 
%%     1 signals{i}.name = models{i}.name 
%%     2 signals{i}.inplace = [ ]          (where to get in) 
%%     3 signals{i}.direct =  [+1 or -1]   (+1  Buy; -1 Sell)
%%     4 signals{i}.inprice = [ ]


 func_name = 'find_pattern';
 current_path = which(func_name);
 current_path = current_path(1:end - (length(func_name) + 2));
 func_path = [current_path, 'findpattern', '\'];
 addpath(func_path);

 for i = 1:length(models)
    switch models{i}.name 
     case 'tcdtci'       %% n����
         signals{i} = find_tcdtci(todaydata,models{i}.inpara); 
         
      case 'boll4'       %% n����
         signals{i} = find_boll4(hisdata,todaydata,models{i}.inpara);     
         
     case 'sr'       %% n����
         signals{i} = find_sr(hisdata,todaydata,models{i}.inpara); 
         
     case 'atr'       %% n����
         signals{i} = find_atr(todaydata,models{i}.inpara);
         
     case '4q'       %% n����
         signals{i} = find_4q(todaydata,models{i}.inpara);     
         
    case 'rangebreakout'       %% n����
         signals{i} = find_rangebreakout(todaydata,models{i}.inpara);     
         
     case 'mv'       %% n����
         signals{i} = find_mv(todaydata,models{i}.inpara);     
         
      case 'price_break_2se'       %% n����
         signals{i} = find_pb_2se(hisdata,todaydata,models{i}.inpara);      
         
     case  'ncucd'       %% n���� n����
         signals{i} = find_ncucd(todaydata,models{i}.inpara); 
         
     case  'out'
         signals{i} = find_out(todaydata,models{i}.inpara);
         
     case  'fmi'
         signals{i} = find_fmi(todaydata,models{i}.inpara);    
         
     case 'price_break'  %% �۸�ͻ��
         signals{i} = find_pb(todaydata,models{i}.inpara);
         
      case 'price_break_original'  %% �۸�ͻ��
         signals{i} = find_pb_original(hisdata,todaydata,models{i}.inpara); 
         
      case 'halfday_break'  %% �۸�ͻ��
         signals{i} = find_halfday_break(hisdata,todaydata,models{i}.inpara);     
         
    case 'price_break_atr'  %% �۸�ͻ��
         signals{i} = find_pb_atr(todaydata,models{i}.inpara,ATR, day);      
         
    case 'price_break_open'  %% �۸�ͻ��
         signals{i} = find_pb_open(todaydata,models{i}.inpara);      
         
    case 'boll'  %% �۸�ͻ��
         signals{i} = find_boll(todaydata,models{i}.inpara);      
         
     case 'price_break_forgettime'  %% �۸�ͻ��
         signals{i} = find_pb_forgettime(todaydata,models{i}.inpara);
         
     case 'price_break_goback'  %% �۸�ͻ��
         signals{i} = find_pb_goback(todaydata,models{i}.inpara);    
         
     case 'turtlesoup'  %% �۸�ͻ��
         signals{i} = find_turtlesoup(todaydata,models{i}.inpara); 
  
     case 'amp_break'    %% ����ͻ��
         signals{i} = find_ab(hisdata,todaydata,models{i}.inpara); 
         
    case 'open'    %% ����ģ��
         signals{i} = find_open(hisdata,todaydata,models{i}.inpara);     
         
     case 'fix_time'     %% �̶�ʱ��ͻ��
         signals{i} = find_ft(hisdata,todaydata,models{i}.inpara); 
         
     case 'fix_time_1'     %% �̶�ʱ��ͻ��
         signals{i} = find_ft_1(hisdata,todaydata,models{i}.inpara); 
         
      case 'fix_time_atr'     %% �̶�ʱ��ͻ��
         signals{i} = find_ft_atr(hisdata,todaydata,models{i}.inpara,ATR, day);     
    
     case 'supp_resis'   %% ֧������
         signals{i} = find_supris(hisdata,todaydata,models{i}.inpara); 
         
     case 'measure'      %% С��
         signals{i} = find_measure(todaydata,models{i}.inpara);
         
     case 'halfday'      %% С��
         signals{i} = find_halfday(todaydata,models{i}.inpara);    
         
     case 'measure1'      %% С��
         signals{i} = find_measure1(todaydata,models{i}.inpara);    
        
     case 'overleap_break' %% ����ͻ��
         signals{i} = find_overleap(hisdata,todaydata,models{i}.inpara);   
         
      case 'outinfo' %% ���̱ȼ�
         signals{i} = find_outinfo(hisdata,todaydata,models{i}.inpara);          
         
      case 'tcdtci_vol'  %% ���ǳɽ������ص�n����ģ��
         signals{i} = find_tcdtci_vol(todaydata,models{i}.inpara);             
                  
      case 'tcdtci_amp'  %% ���Ƿ��ȵ�n����ģ�� (�趨�����޲���)
         signals{i} = find_tcdtci_amp(todaydata,models{i}.inpara);       
         
        case 'measure_obv'  %% ���ǳɽ������صķ���OBV + С��ģ��
            signals{i} = find_measure_obv(todaydata,models{i}.inpara);
        
        case 'tcdtci_obv'  %% ����obv��n����ģ�� (�趨�����޲���)
         signals{i} = find_tcdtci_obv(todaydata,models{i}.inpara);  
         
         case 'kconfig'  %% ����obv��n����ģ�� (�趨�����޲���)
         signals{i} = find_kconfig(todaydata,models{i}.inpara); 
         
         case 'kconfig_1'  %% ����obv��n����ģ�� (�趨�����޲���)
         signals{i} = find_kconfig_1(todaydata,models{i}.inpara); 
         
         case 'price_break_obv'  %% ����obv��ͻ��ģ�� (�趨�����޲���)
         signals{i} = find_pb_obv(todaydata,models{i}.inpara);
         
         case 'fix_time_obv'  %% ����obv��ͻ��ģ�� (�趨�����޲���)
         signals{i} = find_ft_obv(todaydata,models{i}.inpara);
            
        case 'hdli'  %% ���иߺ����е�
         signals{i} = find_hdli(todaydata,models{i}.inpara);
         
        case 'kestner'  %% ���иߺ����е�
         signals{i} = find_kestner(todaydata,models{i}.inpara);  
        case '4candle' %%��ϰ����4����
         signals{i} = find_4candle(todaydata,models{i}.inpara);    
         
     otherwise
         signals{i} = [ 'pattern: ', models{i}.name, ' is not defined yet.']; 
    end
  end
        
 rmpath(func_path);

         