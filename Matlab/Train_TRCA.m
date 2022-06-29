function model = Train_TRCA(train_data,fs,num_fbs)

% 07/05/2022
% Quincy Ma

% Input
%   train_data: targets X channels X data_length (9 X 3.25*fs)
%   fs: 250
%
[tar_num, chan_num, data_length, block_num] = size(train_data);

eeg = zeros(tar_num,chan_num-1,565,3);

for tar_i = 1:tar_num
    for block_i = 1:block_num
        data_temp = squeeze(train_data(tar_i,:,:,block_i));
        trigger_data = data_temp(chan_num,:);
        trigger_position = find(trigger_data~=0);
        trigger_num = length(trigger_position);
        % trigger_num == 3
        if trigger_num == 3

            anchor_point1 = trigger_position(1);
            anchor_point2 = trigger_position(2);
            anchor_point3 = trigger_position(3);
            anchor_point4 = [];

            data_temp = data_temp(1:8,anchor_point3-564:anchor_point3);
            eeg(tar_i,:,:,block_i) = data_temp;
            % trigger_num == 4
        elseif trigger_num == 4

            anchor_point1 = trigger_position(1);
            anchor_point2 = trigger_position(2);
            anchor_point3 = trigger_position(3);
            anchor_point4 = trigger_position(4);

            data_temp = data_temp(1:8,anchor_point4-564:anchor_point4);
            eeg(tar_i,:,:,block_i) = data_temp;
        else

            disp('ERROR: wrong trigger number')
        end
    end
end


%% Train Model
[num_targs, num_chans, num_smpls, ~] = size(eeg);
trains = zeros(num_targs, num_fbs, num_chans, num_smpls);
W = zeros(num_fbs, num_targs, num_chans);

for targ_i = 1:1:num_targs
    eeg_tmp = squeeze(eeg(targ_i, :, :, :));
    for fb_i = 1:1:num_fbs
        eeg_tmp = FilterBank(eeg_tmp, fs, fb_i);
        trains(targ_i,fb_i,:,:) = squeeze(mean(eeg_tmp, 3));
        w_tmp = TRCA_FCN(eeg_tmp);
        W(fb_i, targ_i, :) = real(w_tmp(:,1));
    end % fb_i
end % targ_i

model = struct('trains', trains, 'W', W,...
    'num_fbs', num_fbs, 'fs', fs, 'num_targs', num_targs);


end



