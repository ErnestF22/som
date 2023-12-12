%this function finds K1 for distance measurments:
% y = L-x and u = Ky+k_added
function [K,y1,y2,y3,y4,k_added] = optFirstorderWithU(Wb,Wl,Cb,Cl,z,Ah,Ax,bx,bh,L,xe)
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
%Y: vectorized of landmarks
%d:dimestion

I=kron(ones(size(L,2),1),eye(2));
L=reshape(L,[],1);

nBarriers = size(Ah,1);
nConvex = size(Ax,1);
nLandmark = length(L);
k_added = 0;
cvx_begin

variables  S_l sb K(2,nLandmark) k_added(2,1)... 
           lB(nConvex,nBarriers) lL(nConvex,1)
dual variables y1 y2 y3 y4;

Sb = kron(ones(nBarriers,1),sb);
minimize(Wb'*Sb+Wl*S_l)

subject to
%constraints for safety:
y1: bx'*lB <= (Sb+Ah*K*L+Cb*bh)';%+(Ah*k_added)'
y2: Ax'*lB == (Ah*K*I-Ah*Cb)'

%constraints for stability:
y3: bx'*lL<= (S_l-z'*K*L+Cl*z'*xe)';%-z'*k_added
y4: Ax'*lL == (-z'*K*I+z'*Cl)'

% % 
% abs(K*L - K*kron(ones(4,1),eye(2))*xe)<= 10^-4
% K*kron(ones(4,1),eye(2)) == [Cb 0;0 Cb]

lB>=0
lL>=0
sb<=0
S_l<=0
sb>=-0.1
S_l>=-0.1

cvx_end
end



