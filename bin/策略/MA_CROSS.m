function MA_CROSS(InstrumentID, short, long)   
%���ߴ�����ԣ����ߣ�shortMA�����ϴ������ߣ�longMA��,���룻...�´�...������

    persistent clpr; %���̼�����
    dimension = 0;
    if isfield(clpr, InstrumentID)
        dimension = size(getfield(clpr, InstrumentID));
    end
    
    global NPrice;
    if isfield(clpr, InstrumentID)
        closePrice = getfield(clpr, InstrumentID);
        closePrice(dimension(1)+1, 1) = getfield(NPrice, InstrumentID);
    else
        clpr = setfield(clpr, InstrumentID, getfield(NPrice, InstrumentID));
    end
    if (dimension(1) < 10)
        return;
    end
    
    [short, long] = movavg(clpr.InstrumentID, 5, 10, 1);    
    len = length(clpr.InstrumentID); 
    if (short(len)- long(len))*(short(len-1)- long(len-1)) < 0
        if short(len) > long(len)            
            str = sprintf('��%d����', NPrice.InstrumentID);
            disp(str);
        else
            str = sprintf('��%d����', NPrice.InstrumentID);
            disp(str);
        end
    end
    
    
    %��ʱ������
    %{
    for i = 1 : 500
     pdf('Normal',-2:2,0,1);
     pdf('Poisson',0:4,1:5);
    end
	%}
end