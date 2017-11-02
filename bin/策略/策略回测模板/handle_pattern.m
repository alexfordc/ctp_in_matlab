function oper_infos = handle_pattern(todaydata, signals, models)
%%% 
%%  To handle various patterns 
%%   oper_info{i}   <------>   models{i}.outpara{1} = 'simple' ... ������������
%%                             models{i}.outpara{2} = [   ]        �������Բ���
%%     1 oper_infos{i}.name = models{i}.name 
%%     2 oper_infos{i}.inplace  = [ ]          (where to get in) 
%%     3 oper_infos{i}.inprice  = [+1 or -1]   (+1  Buy; -1 Sell)
%%     4 oper_infos{i}.outplace = [ ]
%%     5 oper_infos{i}.outprice = [ ]
%%     6 oper_infos{i}.profit   = [ ]
%%    models
%%      .outpara{1} = 'simple'    (��������)
%%      .outpara{2} =   [�۸�λ��r ֹ��s ��������d ����e ��һ����ӯ����p ��һ���س��ٷֱ�q �ڶ�����ӯ����u
%%    �ڶ����س��ٷֱ�v]

 func_name = 'handle_pattern';
 current_path = which(func_name);
 current_path = current_path(1:end - (length(func_name) + 2));
 func_path = [current_path, 'handlepattern', '\'];
 addpath(func_path);
 
 if isempty(signals)
     oper_infos = {};
     return; 
 end
 
for i = 1:length(models)
    
    switch models{i}.outpara{1}
         
        case 'simple' %% �����س�ֹӯ����
            oper_infos{i} = handle_simple(todaydata, signals{i}, models{i}.outpara{2});
            
        case 'simple_ab' %% �����س�ֹӯ����
            oper_infos{i} = handle_simple_ab(todaydata, signals{i}, models{i}.outpara{2});    
            
        case 'simple_2' %% ֹӯ����
            oper_infos{i} = handle_simple_2(todaydata, signals{i}, models{i}.outpara{2});
            
        case 'simple_lastmin' %% ֹӯ����
            oper_infos{i} = handle_simple_lastmin(todaydata, signals{i}, models{i}.outpara{2});    
            
        case 'simple_closeconfirm' %% �����س�ֹӯ����
            oper_infos{i} = handle_simple_closeconfirm(todaydata, signals{i}, models{i}.outpara{2});   
            
        case 'simple_turtlesoup' %% �����س�ֹӯ����
            oper_infos{i} = handle_simple_turtlesoup(todaydata, signals{i}, models{i}.outpara{2});    
            
        case 'dynamic' %% �����س�ֹӯ����
            oper_infos{i} = handle_dynamic(todaydata, signals{i}, models{i}.outpara{2});    
            
        case 'simpvol' %% �����س�ֹӯ����
            oper_infos{i} = handle_simvol(todaydata, signals{i}, models{i}.outpara{2});
            
       case 'simple_1' %% �����س�ֹӯ����
            oper_infos{i} = handle_simple_1(todaydata, signals{i}, models{i}.outpara{2});     
            
        case 'volume'  %% ������    
            oper_infos{i} = handle_vol(todaydata, signals{i}, models{i}.outpara{2});
            
       case 'simple_vol'  %% ���۳���    
            oper_infos{i} = handle_simple_vol(todaydata, signals{i}, models{i}.outpara{2});     
            
       case 'simvol'  %% ���۳���    
            oper_infos{i} = handle_simvol(todaydata, signals{i}, models{i}.outpara{2}); 
            
       case 'simple_ke'  %% ���۳���    
            oper_infos{i} = handle_simple_ke(todaydata, signals{i}, models{i}.outpara{2}); 
       
        case 'touch_1' %% �����س�ֹӯ����
            oper_infos{i} = handle_touch_1(todaydata, signals{i}, models{i}.outpara{2});     
       
         case 'simple_endchange' %% �����س�ֹӯ����,���̳�����ȷ������
            oper_infos{i} = handle_simple_endchange(todaydata, signals{i}, models{i}.outpara{2});     
           
        otherwise 
            
            
            
    end
end


 rmpath(func_path);

