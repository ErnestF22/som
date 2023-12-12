%this function finds K1
function [K] = optFirstorderwithScalerWithX(Wb,Wl,Cb,Cl,exitDir,Ah,Ax,bx,bh,xe,L)
%Wb:steering factor for cbf
%Wl:steering factor for clf
%Cb:cbf coefficoient
%Cl:clf coefficoient
%z:exit direction
%Ah:barrier matrix
%bh:barrier bias
%Au:velocity matrix
%bu:velocity bias
%Ax:convex cell matrix
%bx:convex cell bias
%d:dimestion
%y:bering measurments  EI = diag(reshape(E,[],1));
%L:landmark matrix
nBarriers = size(Ah,1);
nConvex = size(Ax,1);
nLandmarks = size(L,2);

Ix = repmat(eye(2),nLandmarks,1);
diagonalLandmarks = diag(reshape(L,[],1));
Iz = blkdiag([1;1],[1;1],[1;1],[1;1]);

A = [Ax zeros(nConvex,nLandmarks) zeros(nConvex,2*nLandmarks);
    zeros(nLandmarks,2) eye(nLandmarks) zeros(nConvex,2*nLandmarks)
    ];

b = [bx;ones(nLandmarks,1)];

A = A';
A1 = A(1:2,:);
A2 = A(3:2+nLandmarks,:);
A3= A(3+nLandmarks:end,:);


cvx_begin

    variables Sb(nBarriers,1) S_l K(2,2*nLandmarks) ...
             Pb1(nConvex,nBarriers) Pb2(nLandmarks,nBarriers) ...
             Pl1(nConvex,1) Pl2(nLandmarks,1)
CH1 = -Cb*Ah;
CH2 = -Ah*K*diagonalLandmarks*Iz;
CH3 = Ah*K;
CL1 = Cl*exitDir';
CL2 = exitDir'*K*diagonalLandmarks*Iz;
CL3 = -exitDir'*K;


minimize(Wb'*Sb+Wl*S_l)

%constraints for safety:
[Pb1;Pb2]'*b <= Sb+Cb*bh
A1*[Pb1;Pb2]==CH1'
A2*[Pb1;Pb2]>=CH2'
A3*[Pb1;Pb2]==CH3'
Pb1>=0
Pb2>=0



%constraints for stability:
[Pl1;Pl2]'*b <= S_l+Cl*exitDir'*xe
A1*[Pl1;Pl2]==CL1'
A2*[Pl1;Pl2]>=CL2'
A3*[Pl1;Pl2]==CL3'
Pl1>=0
Pl2>=0


Sb<=0
S_l<=0

cvx_end
end