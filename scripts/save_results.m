% ------------------------------------------------------------------------ 
%  Copyright (C)
%  Torr Vision Group (TVG)
%  University of Oxford - UK
% 
%  Qizhu Li <liqizhu@robots.ox.ac.uk>
%  August 2018
% ------------------------------------------------------------------------ 
% This file is part of the weakly-supervised training method presented in:
%    Qizhu Li*, Anurag Arnab*, Philip H.S. Torr,
%    "Weakly- and Semi-Supervised Panoptic Segmentation,"
%    European Conference on Computer Vision (ECCV) 2018.
% Please consider citing the paper if you use this code.
% ------------------------------------------------------------------------
% This function saves results at save paths instructed by opts. When only
% 2 arguments are passed in, it checks whether the results already exist,
% and returns a boolean to indicate the finding
%
%  INPUT:
%  - opts : options generated by get_opts.m
%  - k: current iteration number through opts.list
%  - results: struct containing the processed labels
%
%  OUTPUT:
%  - skip: whether to skip the current iteration based on whether the
%          output already exists, and whether opts.force_overwrite is true
%
%  DEMO:
%  - See scripts/run_sub.m
% ------------------------------------------------------------------------

function skip = save_results(opts, k, results)

pred_sem_save_path = fullfile(opts.pred_root, opts.sem_save_dir, sprintf(opts.pred_template, opts.list{k}));
pred_ins_save_path = fullfile(opts.pred_root, opts.ins_save_dir, sprintf(opts.pred_template, opts.list{k}));
if exist(pred_sem_save_path, 'file') && exist(pred_ins_save_path, 'file') && ~opts.force_overwrite
    skip = true;
    return;
else
    skip = false;
    if nargin < 3
        return;
    end
end

if opts.save_sem
    imwrite(results.final_pred, opts.cmap, pred_sem_save_path);
end

if opts.save_ins
    imwrite(results.ins_pred, opts.cmap, pred_ins_save_path);
end

end