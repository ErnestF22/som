%function testNetwork_test
%Shows an example of how to use the test utilities for localization

%%AUTORIGHTS%%

function testNetwork_test(testNum)
randn('state',0)
rand('state',0)
close all

if ~exist('testNum','var')
    testNum=4;
end

switch testNum
    case 1
        methodAbsolutePoses='references';
        structType='array';
    case 2
        methodAbsolutePoses='poses';
        structType='array';
    case 3
        methodAbsolutePoses='references';
        structType='single';
    case 4
        methodAbsolutePoses='poses';
        structType='single';
end

N=8;
A=adjgallery(N,'banded',2);
[G,X]=testNetworkCreateAbsolutePoses(N);

t_node=testNetworkCreateStruct(A,'Type',structType);  
t_node=testNetworkAddGroundTruth(t_node,G,methodAbsolutePoses,'flagInvertG',true);
t_node=testNetworkAddGeoTag(t_node,5,'random',methodAbsolutePoses);

t_node=testNetworkProjectImages(t_node,X,methodAbsolutePoses);

figure
set(gcf,'Name','Images in each camera')
testNetworkDisplayImages(t_node)

t_node=testNetworkAddMeasurements(t_node,'Method','Essential');

t_node=testNetworkInitializeStates(t_node,'MethodR','NoisyTruth',...
    'MethodT','NoisyTruth','MethodScale','NoisyTruth',...
    'SigmaR',0.05,'SigmaT',0.05);

%Note:
% - measurements errors should be all zero
% - errors should be in the order of 2 times the variances given during
%   state initialization
% figure(3)
% subplot(2,1,1)
% hist([rotErr rotErrMs])
% subplot(2,1,2)
% hist([translErr translErrMs])
% disp(['Geometric std of ratios (est/mes)', num2str(geostd(scaleRatios)), '/', num2str(geostd(scaleRatiosMs))])
figure
testNetworkDisplayErrors(t_node,'rtsn','optsComputeErrors',{methodAbsolutePoses},'boxplots')

%see inside testNetworkDisplayErrors for examples of use of
%   testNetworkComputeErrors
%   testNetworkDisplay
