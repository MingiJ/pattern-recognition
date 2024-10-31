function ercf = jackknife(ts)
% performs leave-one-ut test of cls1nn classifier
% ts - training set; each row represents one sample
    % the first column contains class label
% ercf - error coefficient of cls1nn on ts
    cls_res = zeros(rows(ts), 1);
    for i = 1:rows(ts)
        cls_res(i) = cls1nn(ts(1:end != i, :), ts(i, 2:end));
    %%%%%
    ercf = mean(cls_res != ts(:, 1));