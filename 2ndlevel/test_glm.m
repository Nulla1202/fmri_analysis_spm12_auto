sub = {'02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18','19','20','21'};
%sub = {'01'};
for i = 1:length(sub)
    p = sub{i};
% % 実験設計の設定
% % 1st-level解析のためのバッチ設定
% % Load the data from the text file
     data = readmatrix(['/Users/Dai/Documents/MATLAB/Ghoonuts_MRI/semanticJudgemant_logdata/result_c.vs.t_2ndlevel/result' p '.txt']); % Replace 'your_file_name.txt' with the actual file name
% % Select the first 11 data points as 'ctrl'
     ctrl = data(1:11)+1;
% % Select every 10th data point starting from the 12th
     target = data(12:21)+1;
% % SPMのパスを設定
     spm('fmri');
% % 
% % % 実験データのパス
      func_files = spm_select('ExtFPList', ['/Users/Dai/Documents/MATLAB/Ghoonuts_MRI/A' p '/Yoshimura Standard/fMRI_language_Session2 7'], 'swu.*\.nii$', Inf);
% % % 
% % % % 実験設計のパス
      matlabbatch{1}.spm.stats.fmri_spec.dir = {['/Users/Dai/Documents/MATLAB/Ghoonuts_MRI/A' p '/Yoshimura Standard/all']};
% % % 
% % % % 'ctrl'条件の設定%
      matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).name = 'ctrl';
      matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).onset = ctrl;  % 例: [10, 50, 90]
      matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).duration = 16;  % 例: [5, 5, 5]
% 
% % % % 'target'条件の設定
      matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).name = 'target';
      matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).onset = target;  % 例: [30, 70, 110]
      matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).duration = 16;  % 例: [5, 5, 5]
% % % 
      %matlabbatch{1}.spm.stats.fmri_spec.sess.cond(3).name = 'all';
      %matlabbatch{1}.spm.stats.fmri_spec.sess.cond(3).onset = all;  % 例: [30, 70, 110]
      %matlabbatch{1}.spm.stats.fmri_spec.sess.cond(3).duration = [16];  % 例: [5, 5, 5]
 
% % % % その他の1st-level解析設定
      matlabbatch{1}.spm.stats.fmri_spec.timing.units = 'scans';
      matlabbatch{1}.spm.stats.fmri_spec.timing.RT = 1.5;  % TRを設定
      matlabbatch{1}.spm.stats.fmri_spec.sess.scans = cellstr(func_files);
% % % % モデルの推定
      matlabbatch{2}.spm.stats.fmri_est.spmmat = {['/Users/Dai/Documents/MATLAB/Ghoonuts_MRI/A' p '/Yoshimura Standard/all/SPM.mat']};
      matlabbatch{2}.spm.stats.fmri_est.method.Classical = 1;

% % コントラストの定義
     matlabbatch{3}.spm.stats.con.spmmat = {['/Users/Dai/Documents/MATLAB/Ghoonuts_MRI/A' p '/Yoshimura Standard/all/SPM.mat']};
     matlabbatch{3}.spm.stats.con.consess{1}.tcon.name = 'ALL';
     matlabbatch{3}.spm.stats.con.consess{1}.tcon.weights = [1 1 0];
     matlabbatch{3}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
     %matlabbatch{3}.spm.stats.con.spmmat = {['/Users/Dai/Documents/MATLAB/Ghoonuts_MRI/A' p '/Yoshimura Standard/final/SPM.mat']};
     matlabbatch{3}.spm.stats.con.consess{2}.tcon.name = 'C>T';
     matlabbatch{3}.spm.stats.con.consess{2}.tcon.weights = [1 -1 0];
     matlabbatch{3}.spm.stats.con.consess{2}.tcon.sessrep = 'none';
     %matlabbatch{3}.spm.stats.con.spmmat = {['/Users/Dai/Documents/MATLAB/Ghoonuts_MRI/A' p '/Yoshimura Standard/final/SPM.mat']};
     matlabbatch{3}.spm.stats.con.consess{3}.tcon.name = 'C<T';
     matlabbatch{3}.spm.stats.con.consess{3}.tcon.weights = [-1 1 0];
     matlabbatch{3}.spm.stats.con.consess{3}.tcon.sessrep = 'none';
 
% % % バッチの実行
     spm_jobman('run', matlabbatch);

end
