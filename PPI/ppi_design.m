p = {'01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18','19','20','21'};
%p = {'01'};
q = {'L_AG'};
%q = {'L_MFG'};
for i = 1:length(p)
    for j = 1:length(q)
        ques = q{j};
        participant = p{i};
    % SPMのパスを設定
        spm('fmri');

    % 実験データのパス
        func_files = spm_select('ExtFPList', ['/Users/Dai/Documents/MATLAB/Ghoonuts_MRI/A' participant '/Yoshimura Standard/fMRI_language_Session2 7'], 'swu.*\.nii$', Inf);

    % Load PPI variables
        load(['/Users/Dai/Documents/MATLAB/Ghoonuts_MRI/A' participant '/Yoshimura Standard/test/PPI_C<T_' ques '.mat']);

    % 実験設計のパス
        matlabbatch{1}.spm.stats.fmri_spec.dir = {['/Users/Dai/Documents/MATLAB/Ghoonuts_MRI/A' participant '/Yoshimura Standard/test/PPI_' ques '_8mm']};

    % Define regressors
        matlabbatch{1}.spm.stats.fmri_spec.sess.regress(1) = struct('name', {'Psycho'}, 'val', {PPI.P});
        matlabbatch{1}.spm.stats.fmri_spec.sess.regress(2) = struct('name', {'Physio'}, 'val', {PPI.Y});
        matlabbatch{1}.spm.stats.fmri_spec.sess.regress(3) = struct('name', {'Interaction'}, 'val', {PPI.ppi});  % Corrected index to 3

    % その他の1st-level解析設定
        matlabbatch{1}.spm.stats.fmri_spec.timing.units = 'scans';
        matlabbatch{1}.spm.stats.fmri_spec.timing.RT = 1.5;
        matlabbatch{1}.spm.stats.fmri_spec.sess.scans = cellstr(func_files);

    % モデルの推定
        matlabbatch{2}.spm.stats.fmri_est.spmmat = {['/Users/Dai/Documents/MATLAB/Ghoonuts_MRI/A' participant '/Yoshimura Standard/test/PPI_' ques '_8mm/SPM.mat']};
        matlabbatch{2}.spm.stats.fmri_est.method.Classical = 1;

    % コントラストの定義
        matlabbatch{3}.spm.stats.con.spmmat = {['/Users/Dai/Documents/MATLAB/Ghoonuts_MRI/A' participant '/Yoshimura Standard/test/PPI_' ques '_8mm/SPM.mat']};
        matlabbatch{3}.spm.stats.con.consess{1}.tcon.name = ['C<T*' ques];
        matlabbatch{3}.spm.stats.con.consess{1}.tcon.weights = [0 0 1];
        matlabbatch{3}.spm.stats.con.consess{1}.tcon.sessrep = 'none';

    % バッチの実行
        spm_jobman('run', matlabbatch);
    end
end
