%Compute scale of kernel for points from distances to neighbors
%function relationDefault=quickshift_scalesMembershipPrior(D,membershipPrior,varargin)
%For each point in the dataset, computes the closest point (either in the
%same or different class), and uses this to compute the scale to be used by
%the kernel
%Input arguments
%   D   [NPoints x NPoints] matrix quantifying relations between points (by
%   default, these are pairwise distances)
%   membershipPrior     [1 x NPoints] vector with labels for each point
%Optional arguments
%   'nearestIntraNeighbor'  the computed scale is equal to the distance
%       to the nearest neighbor in the same class
%   'proportionalInterNeighbor', ratio  the computed scale is equal to
%       ratio times the distance to the nearest neighbor in another class
%   'relationType',type     chooses how to interpret the values in D
%       according to the following table:
%           type    |   values in D
%       ------------+------------------
%       'distance'  |   pairwise distances
%       'similarity'|   pairwise similarities in the [0,1] range
%    'relationIndicator',s  the [NPoints x NPoints] matrix s is a logical
%       matrix that indicates if the corresponding entries in the D matrix
%       should be considered or not. Typically, if this option is used both
%       s and D are sparse matrices, allowing significant memory savings.
%       Note: the nearest neighbors of a point are determined by looking at
%       the corresponding *column* in D and DIndicator.
function relationDefault=quickshift_scalesMembershipPrior(D,membershipPrior,varargin)
strategy='nearestintraneighbor';
relationType='distance';
flagRelationIndicator=false;

%parse optional parameters
ivarargin=1;
while ivarargin<=length(varargin)
    switch lower(varargin{ivarargin})
        case 'nearestintraneighbor'
            strategy=lower(varargin{ivarargin});
        case 'proportionalinterneighbor'
            strategy=lower(varargin{ivarargin});
            ivarargin=ivarargin+1;
            ratioInterMembership=varargin{ivarargin};
        case 'relationtype'
            ivarargin=ivarargin+1;
            relationType=lower(varargin{ivarargin});
        case 'relationindicator'
            ivarargin=ivarargin+1;
            relationIndicator=lower(varargin{ivarargin});
            flagRelationIndicator=true;
        otherwise
            error(['Argument ' varargin{ivarargin} ' not valid!'])
    end
    ivarargin=ivarargin+1;
end

NPoints=size(D,1);
relationDefault=zeros(1,NPoints);

switch relationType
    case 'distance'
        relationClosestOperator=@(x) min(x);
    case 'similarity'
        relationClosestOperator=@(x) max(x);
    otherwise
        error('Relation type not recognized')
end

for iPoint=1:NPoints
    switch lower(strategy)
        case 'nearestintraneighbor'
            flagOther=(membershipPrior(iPoint)==membershipPrior)';
            if flagRelationIndicator
                flagOther=and(flagOther,relationIndicator(:,iPoint));
            end
            flagOther(iPoint)=false;
            relationDefault(iPoint)=relationClosestOperator(D(flagOther,iPoint));
        case 'proportionalinterneighbor'
            flagOther=(membershipPrior(iPoint)~=membershipPrior)';
            if flagRelationIndicator
                flagOther=and(flagOther,relationIndicator(:,iPoint));
            end
            relationDefault(iPoint)=ratioInterMembership*relationClosestOperator(D(flagOther,iPoint));
        otherwise
            error('Strategy not recognized.')
    end
    
end
