classdef adaptive_filter
    %Performs sample-wise adaptive filtering
    %   input x and e, outputs r
    
    properties
        length;  %number of filter coefficients
        type;    %filter type
        adaptation_constant;
        w=[];           %filter coefficients
        x_delayed = []; %delayed input signals
        w_history = []; %keep track of filter coefficients as they evolve
        r;
        R=[];
        re=[];
        F =[];
        F_inverse=[];
        state_history =[];
        est_p =[];                
    end
    
    methods
        function obj = adaptive_filter(length,type,adaptation_constant)
            if(nargin>0)
            disp(length)
            obj.length=length;
            obj.type=type;
            obj.adaptation_constant=adaptation_constant;
            obj.w=zeros(length,1);
            obj.x_delayed=zeros(length,1);
            disp(size(obj.x_delayed))
            obj.w_history=zeros(0,length);
            obj.R=eye(length)*0.005;
            obj.re=zeros(length,1);
            obj.F = dftmtx(length);
            obj.F_inverse = conj(dftmtx(length))/length;
            obj.est_p = ones(length, length);
            %initialize your variables here
            
            end
        end
        function obj = filter(obj,x,e)
            obj.x_delayed=[x ; obj.x_delayed(1:obj.length-1)];
            e_hat=obj.w.' * obj.x_delayed;
            obj.r=e-e_hat;
            obj.w_history=[obj.w_history ; obj.w.']; %you may want to remove this line to gain speed
            obj=update_filter(obj,e);        
        end
    end
    
end

