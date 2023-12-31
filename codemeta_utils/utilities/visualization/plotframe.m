%Plots 2-D or 3-D axes
%function plotframe(o,r,vararging)
%
%O  column vector for the origin of the frame
%R  the column of R are the axis vectors (they should be orthonormal)

%%AUTORIGHTS%%

function plotframe(o,r,varargin)
style={'r','g','b'};
label={'x','y','z'};
scale=1;

%optional parameters
ivarargin=1;
while(ivarargin<=length(varargin))
    switch(lower(varargin{ivarargin}))
        case 'style'
            ivarargin=ivarargin+1;
            style=varargin{ivarargin};
        case 'scale'
            ivarargin=ivarargin+1;
            scale=varargin{ivarargin};
        case 'label'
            ivarargin=ivarargin+1;
            label=varargin{ivarargin};
        otherwise
                error(['Argument ' varargin{ivarargin} ' not valid!'])
    end
    ivarargin=ivarargin+1;
end

if ~iscell(style)
    tmp=style;
    style=cell(1,3);
    [style{:}]=deal(tmp);
end

h=ishold();

dimData=length(o);
switch dimData
    case 2
        plot2dvect(o,scale*r(:,1),label{1},style{1})
        hold on
        plot2dvect(o,scale*r(:,2),label{2},style{2})
    case 3
        plot3dvect(o,scale*r(:,1),label{1},style{1})
        hold on
        plot3dvect(o,scale*r(:,2),label{2},style{2})
        plot3dvect(o,scale*r(:,3),label{3},style{3})
end        
if(~h)
    hold off
end

