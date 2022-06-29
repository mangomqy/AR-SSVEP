function results = Test_TRCA(eeg, model,position)

% 2022/03/26
% Quincy Ma

% Input:
%   eeg             : Input eeg data 
%                     ( # of channels, Data length [sample])
%   model           : Learning model for tesing phase of the ensemble 
%                     ( # of targets, of fbs, of channels, Data length)


% Reference:
%   [1] M. Nakanishi, Y. Wang, X. Chen, Y. -T. Wang, X. Gao, and T.-P. Jung,
%       "Enhancing detection of SSVEPs for a high-speed brain speller using 
%        task-related component analysis",
%       IEEE Trans. Biomed. Eng, 65(1): 104-112, 2018.



is_ensemble = 0;
r = zeros(model.num_fbs,model.num_targs);
fb_coefs = [1:model.num_fbs].^(-1.25)+0.25;
for fb_i = 1:1:model.num_fbs
    testdata = FilterBank(eeg, model.fs, fb_i);
    for class_i = 1:1:model.num_targs
        traindata =  squeeze(model.trains(class_i, fb_i, :, :));
        if ~is_ensemble
            w = squeeze(model.W(fb_i, class_i, :));
        else
            w = squeeze(model.W(fb_i, :, :))';
        end
        r_tmp = corrcoef(testdata'*w, traindata(:,position(1):position(2))'*w);
        r(fb_i,class_i) = r_tmp(1,2);
    end % class_i
end % fb_i
rho = fb_coefs*r;
[~, tau] = max(rho);
results = tau;
end