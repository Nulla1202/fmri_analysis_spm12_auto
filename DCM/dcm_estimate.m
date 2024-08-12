% participants = {'01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18','19','20','21'};
% regions = {'SFG','OrIFG'};
% 
% for j = 1:length(regions)
%     for i = 1:length(participants)
%         participant = participants{i};
%         region = regions{j};
%         
%         % Construct the paths for the DCM files
%         P = {};
%         for num = 1:4
%             DCM_filename = sprintf('/Users/Dai/Documents/MATLAB/Ghoonuts_MRI/A%s/YoshimuraStandard/test/DCM/DCM_model_L_AI_%s_%d.mat', participant, region, num);
%             P{end+1} = DCM_filename;
%         end
%         
%         % Estimate the DCM parameters for each file
%         for k = 1:length(P)
%             DCM = load(P{k}); % Load the DCM file
%             DCM = DCM.DCM; % Extract the DCM structure if it's saved in a variable 'DCM' within the .mat file
%             DCM = spm_dcm_estimate(DCM); % Estimate parameters
%             
%             % You might want to save the updated DCM structure back to file
%             save(P{k}, 'DCM');
%         end
%     end
% end
% 
% participants = {'01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18','19','20','21'};
% regions = {'L_AI'};
% 
% for j = 1:length(regions)
%     for i = 1:length(participants)
%         participant = participants{i};
%         region = regions{j};
%         
%         % Construct the paths for the DCM files
%         P = {};
%         for num = 1:4
%             DCM_filename = sprintf('/Users/Dai/Documents/MATLAB/Ghoonuts_MRI/A%s/YoshimuraStandard/test/DCM/DCM_model_SMA_%s_%d.mat', participant, region, num);
%             P{end+1} = DCM_filename;
%         end
%         
%         % Estimate the DCM parameters for each file
%         for k = 1:length(P)
%             DCM = load(P{k}); % Load the DCM file
%             DCM = DCM.DCM; % Extract the DCM structure if it's saved in a variable 'DCM' within the .mat file
%             DCM = spm_dcm_estimate(DCM); % Estimate parameters
%             
%             % You might want to save the updated DCM structure back to file
%             save(P{k}, 'DCM');
%         end
%     end
% end



%participants = {'01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18','19','20','21'};
participants = {'20','21'};
regions = {'L_MFG','L_AG','L_AI','L_OpIFG','L_OrIFG','L_SFG','SMA','R_AI'};

for i = 1:length(participants)
    participant = participants{i};
    for j = 1:length(regions)
        for k = j+1:length(regions)
            region1 = regions{j};
            region2 = regions{k};
            
            % Construct the paths for the DCM files
            P = {};
            for num = 1:4
                DCM_filename = sprintf('/Users/Dai/Documents/MATLAB/Ghoonuts_MRI/A%s/YoshimuraStandard/test/DCM/DCM_model_%s_%s_%d.mat', participant, region1, region2, num);
                P{end+1} = DCM_filename;
            end
            
            % Estimate the DCM parameters for each file
            for l = 1:length(P)
                DCM = load(P{l}); % Load the DCM file
                DCM = DCM.DCM; % Extract the DCM structure if it's saved in a variable 'DCM' within the .mat file
                DCM = spm_dcm_estimate(DCM); % Estimate parameters
                
                % You might want to save the updated DCM structure back to file
                save(P{l}, 'DCM');
            end
        end
    end
end
