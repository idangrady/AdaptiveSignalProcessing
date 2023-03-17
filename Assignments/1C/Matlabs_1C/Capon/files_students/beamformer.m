function beamformed_data = beamformer(dataset, scan, pw_indices, adaptive)

    time = (0:dataset.N_ax-1).'/dataset.fs;
       
    [X, Z] = meshgrid(scan.x, scan.z);

    beamformed_channel_data = zeros(dataset.N_ax*dataset.N_el, length(pw_indices));

    tic 
    sum_ = 0;
    for pw=1:length(pw_indices) %for every selected plane wave     

        %% Time-Of-Flight correction
        tof_data = zeros(dataset.N_ax*dataset.N_el,dataset.N_el);
        transmit_delay = Z*cos(dataset.angles(pw_indices(pw)))+X*sin(dataset.angles(pw_indices(pw)));
        
        for nrx=1:dataset.N_el
            receive_delay = sqrt((dataset.probe_geometry(nrx)-X).^2+(0-Z).^2);
            delay = (transmit_delay+receive_delay)/dataset.c0;
            tof_data(:,nrx) = interp1(time, dataset.data(:,nrx,pw_indices(pw)), reshape(delay,[],1),'spline',0);
        end  
        
                
        %% Apodization
    
        for i = 1:(2048*128)
            warning('off','MATLAB:singularMatrix');
            y = tof_data(i,:);
            
            N = length(y);
            L = max(round(N/3),1);
            delta = 1/L;
            con_ave = 1/(N-L+1);
            a = ones(L,1);
            switch adaptive
                case 0
                w = ones(N,1); 
                beamformed_channel_data(i, pw) = w'*y';
                case 1
                    z =0;
                    Rx = zeros(L,L);                            % Init autocorr
                    for batch=1:(N-L+1)
                    cur_y = y(batch:batch+L-1);
                    Rx = Rx+ cur_y'*cur_y;                      % compute the auto cor
                    end
                    Rx = con_ave*Rx;                            %  Normlize  
                    Rx =Rx+ 0.001*eye(L);                       %  Making it stable
                    
                    R_inv = inv(Rx);                            % invert the autocor
                    W = (R_inv*a)*inv(a'*R_inv*a);              %compute weights
                    for j=1:(N-L+1)
                        z = z+ W'*transpose(y(j:j+L-1));        % iterate over the Zs
                    end
                    beamformed_channel_data(i, pw) = con_ave*z; %   store
                        
            end
        end
    end

    time = toc; 
    
    fprintf('Reconstruction time:  %f s \n',time)
    
    % Sum the contributions of different PW's. 
    % Alternatively, (adaptive) apodization could also be applied here. 

    beamformed_data = sum(beamformed_channel_data, 2); 
    beamformed_data(isnan(beamformed_data)) = 0;
    beamformed_data = reshape(beamformed_data, 2048, 128);
 
end


%{
                case 1
                  % Code your adaptive capon estimator for the weights w here
                 warning('off','MATLAB:singularMatrix');
                    z=0;
                    range = N-L;
                    R_x = zeros(L,L);                       %   Init Rx
                    for batch =1:range

                      cur_y = y(batch:batch+L-1);           %   slice the current batch

                      R_x =  con_ave * (cur_y'*cur_y);      %   compute Rx
                      if i>=0
                          R_x =R_x+ 0.001*eye(L);
                      else
                        diag_loading = delta * eye(L) * diag(R_x);
                        R_x = R_x + diag_loading;           %   making it stable- delta =1/L
                      end
                      W_cur = (inv(R_x)*a)/(a'*inv(R_x)*a); %   compute the weights
                      z = z+ W_cur'*transpose(cur_y);        %   sum the z
                    end
                   z = (1/(N-L+1))*z;                       %   take the average z
                  beamformed_channel_data(i, pw) = z;       %   store
                  if(mod(i, 10000)==0)
                  disp(i)
                  end
%}