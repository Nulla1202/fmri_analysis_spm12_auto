participants = {'01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18','19','20','21'};
rois = {'L_MFG','L_AG','L_AI','L_OpIFG','L_OrIFG','L_SFG','SMA','R_AI'};

for i = 1:length(participants)
    participant = participants{i};
    for w = 1:length(rois)
        for x = w+1:length(rois)
            num = 1;
            P = {['/Users/Dai/Documents/MATLAB/Ghoonuts_MRI/A' participant '/YoshimuraStandard/test/VOI_' rois{w} '_8mm_1.mat'], ['/Users/Dai/Documents/MATLAB/Ghoonuts_MRI/A' participant '/YoshimuraStandard/test/VOI_' rois{x} '_8mm_1.mat']};
            m  = numel(P);
            xY = [];
            for j = 1:m
                p  = load(P{j},'xY');
                xY = spm_cat_struct(xY,p.xY);
            end
            SPM_path = ['/Users/Dai/Documents/MATLAB/Ghoonuts_MRI/A' participant '/YoshimuraStandard/test/SPM.mat'];
            SPM = load(SPM_path);
            SPM = SPM.SPM;
            settings = struct();
            settings.a = [0 1 ; 1 0];
            settings.c = [0 ; 0];
            [rows, cols] = find(settings.a == 1);
            num_ones = numel(rows);
            for k = 1:(2^num_ones - 1)
                binary = dec2bin(k, num_ones) == '1';
                new_matrix = settings.a;
                for l = 1:num_ones
                    if binary(l)
                        new_matrix(rows(l), cols(l)) = 0;
                    end
                end
                settings.b = new_matrix;
                DCM = spm_dcm_specify_ui(SPM,xY,settings);
                mkdir(['/Users/Dai/Documents/MATLAB/Ghoonuts_MRI/A' participant '/YoshimuraStandard/test/DCM']);
                save(['/Users/Dai/Documents/MATLAB/Ghoonuts_MRI/A' participant '/YoshimuraStandard/test/DCM/DCM_model_' rois{w} '_' rois{x} '_' int2str(num) '.mat'], "DCM");
                num = num + 1;
            end
            settings.b = settings.a;
            DCM = spm_dcm_specify_ui(SPM,xY,settings);
            save(['/Users/Dai/Documents/MATLAB/Ghoonuts_MRI/A' participant '/YoshimuraStandard/test/DCM/DCM_model_' rois{w} '_' rois{x} '_' int2str(num) '.mat'], "DCM");
        end
    end
end
