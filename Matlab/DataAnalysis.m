%% Analyze EEG data
% Quincy(Qiyuan) Ma
% 11/06/2022

classdef DataAnalysis

    properties
        data
    end




    methods
        
        function process(eeg_data)
        
        end

        function calculate_SNR(eeg_data)
        

        end


        %% suit for experiment1 and experiment3
        function obj = classification_1(eeg_data,data_length)
            %Input:eeg_data (Subject_Num, Target_Num, Trials, Channels_Num, Data_Length)

            
            [Subject_Num, Target_Num, Trial_Num, ~, ~] = size(eeg_data);
            eeg_data = eeg_data(:,:,:,:,161:161 + data_length * 250);
            
            %% No_training method:FBCCA
            % parameters
            test_data = eeg_data;
            anticipated_result = zeros(15,8,30);

            %
            for tar_i = 1:8
                anticipated_result(:,tar_i,:) = target_i;
            end
            for sub_i = 1:Subject_Num
                for target_i = 1:Target_Num
                    for trial_i = 1:Trial_Num
                        temp_data = squeeze(test_data(sub_i,target_i,trial_i,:,:));
                        [results,rho,per] = fbcca_v2(eeg, list_freqs, fs, num_harms, num_fbs)
                    end

                end
            end


            %% Training method:TRCA
            % 
            train_data = eeg_data(:,:,1:5,:,:);
            test_data = eeg_data(:,:,6:30,:,:);





            %% Cold Start method 

        end




        
        function FBCCA
        
        end

        function TRCA

        end



    end

end