%% Data preprocessing 
% Quincy(Qiyuan) Ma
% 11/06/2022

%% Load raw EEG data
% All data were collected with Neuracle device. The electrodes position 
% are based on 10-20 principle. We collected 8 channels from occipital region.
% EEG data were saved with the format of BDF. And were transformed to Mat.


% Config
Subject_Num = 15;
Target_Num = 8;
Trials = 30;
Channels_Num = 8;
Raw_Sample_Rate = 1000;
Down_Sample_Rate = 250;
Data_Length = 4.5 * Down_Sample_Rate; % 0.5s pre-stimulus and 4s stimulus

DataPath = 'Data/raw_data_mat';
Save_Path = 'Data/preprocessed_data';


%% Experiment1

for sub_i = 1:Subject_Num
    eeg_data_all = zeros(Subject_Num, Target_Num, Trials, Channels_Num, Data_Length);
    eeg_trials = zeros(1, Target_Num);
    % spilt data
    EEG_Data_Path
    EEG_Data_Mat = load(EEG_Data_Path);
    % EEG_data.data: channels X data_length
    eeg_data = EEG_Data_Mat.data;
    trigger_data = EEG_Data_Mat.event;
    
    for event_i = 1:length(event)
        if strcmp(trigger_data(event_i).type, '1')
            eeg_trials(1) = eeg_trials(1) + 1;
            eeg_data_all(sub_i,1,eeg_trials(1),:,:) = eeg_data(:,trigger_data(event_i).latency - 499:trigger_data(event_i).latency + 4000);        
        elseif strcmp(trigger_data.type, '2')
            eeg_trials(2) = eeg_trials(2) + 1;
            eeg_data_all(sub_i,1,eeg_trials(2),:,:) = eeg_data(:,trigger_data(event_i).latency - 499:trigger_data(event_i).latency + 4000);
        elseif strcmp(trigger_data.type, '3')
            eeg_trials(3) = eeg_trials(3) + 1;
            eeg_data_all(sub_i,1,eeg_trials(3),:,:) = eeg_data(:,trigger_data(event_i).latency - 499:trigger_data(event_i).latency + 4000);
        elseif strcmp(trigger_data.type, '4')
            eeg_trials(4) = eeg_trials(4) + 1;
            eeg_data_all(sub_i,1,eeg_trials(4),:,:) = eeg_data(:,trigger_data(event_i).latency - 499:trigger_data(event_i).latency + 4000);
        elseif strcmp(trigger_data.type, '5')
            eeg_trials(5) = eeg_trials(5) + 1;
            eeg_data_all(sub_i,1,eeg_trials(5),:,:) = eeg_data(:,trigger_data(event_i).latency - 499:trigger_data(event_i).latency + 4000);
        elseif strcmp(trigger_data.type, '6')
            eeg_trials(6) = eeg_trials(6) + 1;
            eeg_data_all(sub_i,1,eeg_trials(6),:,:) = eeg_data(:,trigger_data(event_i).latency - 499:trigger_data(event_i).latency + 4000);
        elseif strcmp(trigger_data.type, '7')
            eeg_trials(7) = eeg_trials(7) + 1;
            eeg_data_all(sub_i,1,eeg_trials(7),:,:) = eeg_data(:,trigger_data(event_i).latency - 499:trigger_data(event_i).latency + 4000);        
        elseif strcmp(trigger_data.type, '8')
            eeg_trials(8) = eeg_trials(8) + 1;
            eeg_data_all(sub_i,1,eeg_trials(8),:,:) = eeg_data(:,trigger_data(event_i).latency - 499:trigger_data(event_i).latency + 4000);
        
        end
        
    end 
    
end
save_experiment_1_name = [Save_Path,'\experiment1.mat'];
save(save_experiment_1_name,'eeg_data_all');


%% Experiment2


%% Experiment3

%% Experiment4


%% load data







