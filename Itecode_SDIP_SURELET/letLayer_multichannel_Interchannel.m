classdef letLayer_multichannel_Interchannel < nnet.layer.Layer
    % LETLAYER
    %
    % Reference: 
    % (21) in F. Luisier, T. Blu and M. Unser, "A New SURE Approach to Image Denoising: Interscale Orthonormal Wavelet Thresholding," in IEEE Transactions on Image Processing, vol. 16, no. 3, pp. 593-606, March 2007, doi: 10.1109/TIP.2007.891064.Example custom Soft-thresholding layer.
    %  
    % Copyright (c) Shogo MURAMATSU, 2021
    % All rights reserved.
    %
    
    properties
        NumberOfChannels
        IsInterScale
    end
    
    properties(Learnable)
        % Layer learnable parameters
        Sigma_R
        Sigma %'Sigma',hatsigmawR

        a1_1
        a2_2

        a1
        a2
        a3
        a4
    end
    
    methods
        function layer = letLayer_multichannel_Interchannel(varargin) 
            p = inputParser;
            addParameter(p,'Name','')
            addParameter(p,'Sigma_R',1)
            addParameter(p,'Sigma',1)
            addParameter(p,'IsInterScale',true)
            addParameter(p,'NumberOfChannels',1)
            parse(p,varargin{:})
            
            % Set layer name.
            layer.Name = p.Results.Name;
            layer.IsInterScale = p.Results.IsInterScale;
            layer.NumberOfChannels = p.Results.NumberOfChannels;
            
            % Initialize scaling coefficient.   parameter(interscale)   
%           layer.Sigma_R = p.Results.Sigma_R.*ones(3,3,layer.NumberOfChannels/3);  
            layer.Sigma_R = p.Results.Sigma_R;
            layer.Sigma = permute(p.Results.Sigma.*ones(layer.NumberOfChannels,1),[2 3 1]); 

            layer.a1_1 = permute(ones(layer.NumberOfChannels,1),[2 3 1]);
            layer.a2_2 = permute(-ones(layer.NumberOfChannels,1),[2 3 1]);
            % Initialize scaling coefficient.  CxC parameter matrices (interscale-interchannel
            layer.a1 = permute(zeros(layer.NumberOfChannels/3,3,3),[2 3 1]);%
            layer.a2 = permute(zeros(layer.NumberOfChannels/3,3,3),[2 3 1]);
            layer.a3 = permute(zeros(layer.NumberOfChannels/3,3,3),[2 3 1]);%
            layer.a4 = permute(zeros(layer.NumberOfChannels/3,3,3),[2 3 1]);%
            
            %layer.NumInputs = 2;
            if layer.IsInterScale
                layer.InputNames = { 'child', 'parent' };
            else
                layer.NumInputs = 1;
            end
            
            % Set layer description.
            layer.Description = "LET for " + layer.NumberOfChannels + " channels";
        end
        
        function Z = predict(layer, varargin)
            Yn = varargin{1};  
            V = exp(-Yn.^2./(12*layer.Sigma.^2));
            Z1 = (layer.a1_1 + layer.a2_2.*V).*Yn;
            Yn = Z1;

            if layer.NumInputs < 2

                Z = Yn;
   
              
            else %
                P = varargin{2};
                Pn_ = dlresize(P,'OutputSize',size(Yn,1:2),'DataFormat','SSCB'); % Enlarged parent                 
                [nx,ny,nz] = size(Pn_);
               
                Pn = reshape(Pn_,[nx*ny,nz]);% 
                Yn_y = reshape(Yn,[nx*ny,nz]);% 

                Cnn = layer.NumberOfChannels/3;
                %  Calculate the relationship of RGB for each [Ps Pa] channel separately 
                for AC_n = 1:Cnn                 
                    a11 = layer.a1(:,:,AC_n);
                    a22 = layer.a2(:,:,AC_n);
                    a33 = layer.a3(:,:,AC_n);
                    a44 = layer.a4(:,:,AC_n);

%                     R_Sigma_R_ = layer.Sigma_R(:,:,AC_n);

                    Cn_R = AC_n;
                    Cn_G = Cnn + AC_n;
                    Cn_B = (2*Cnn) + AC_n;

                    Pn_AC_n(:,1) = Pn(:,Cn_R);
                    Pn_AC_n(:,2) = Pn(:,Cn_G);
                    Pn_AC_n(:,3) = Pn(:,Cn_B);


                    Yn_y_AC_n(:,1) = Yn_y(:,Cn_R);
                    Yn_y_AC_n(:,2) = Yn_y(:,Cn_G);
                    Yn_y_AC_n(:,3) = Yn_y(:,Cn_B);
               

                    Pnz = (Pn_AC_n*layer.Sigma_R).*Pn_AC_n;
                    Ynz = (Yn_y_AC_n*layer.Sigma_R).*Yn_y_AC_n;

                    r_Pnz = exp(-(abs(Pnz))/36);
                    r_Ynz = exp(-(abs(Ynz))/36);


                    Z_rgb = (r_Pnz.*r_Ynz).*(Yn_y_AC_n*a11) ...
                    + (1 - r_Pnz).*r_Ynz.*(Yn_y_AC_n*a22)...
                    + r_Pnz.*(1 - r_Ynz).*(Yn_y_AC_n*a33)...
                    + (1 - r_Pnz).*(1 - r_Ynz).*(Yn_y_AC_n*a44);

                    
                    Z_(:,Cn_R) = Z_rgb(:,1);
                    Z_(:,Cn_G) = Z_rgb(:,2);
                    Z_(:,Cn_B) = Z_rgb(:,3);
                    
                end
               
                Z = reshape(Z_,[nx ny nz]);% 
              
            end
        end
    end
end