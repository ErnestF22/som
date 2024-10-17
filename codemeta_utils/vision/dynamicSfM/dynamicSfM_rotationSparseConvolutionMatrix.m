function MRwb=dynamicSfM_rotationSparseConvolutionMatrix(Rwb)
NR=size(Rwb,3);
idx=bsxfun(@plus,[1;2;3]*ones(1,3),3*permute(0:NR-1,[1 3 2]));
idxEye=(1:3*NR)';
MRwb=sparse([vec(idx); idxEye],...
    [vec(multitransp(idx)); idxEye+3],...
    [vec(Rwb); -ones(3*NR,1)],...
    3*NR,3*(NR+1));
