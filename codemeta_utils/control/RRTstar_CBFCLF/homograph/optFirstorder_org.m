%this function finds K1
function [K] = optFirstorder_org(Wb,Wl,Cb,Cl,z,Ah,Ax,bx,bh,y,xe)
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

Y=zeros(2*size(y,2),1);
for i=1:size(y,2)
    Y(2*i-1)=y(1,i);
    Y(2*i)=y(2,i);
end
nBarriers = size(Ah,1);
nConvex = size(Ax,1);
nLandmark=length(Y);
I=kron(ones(size(y,2),1),eye(2));
cvx_begin
%K1(nVelocity,nLandmark)
    variables Sb(nBarriers,1) S_l K(2,8)...
              lB(nBarriers*nConvex,1) lL(nConvex,1) %lU(nVelocity*nConvex,1)  k7 k8
    minimize(Wb'*Sb+Wl*S_l)

    subject to
    
        for h=1:nBarriers %constraints for barries:
          lB((h-1)*nConvex+1:h*nConvex,1)'*bx <= Sb(h)+Cb*bh(h)+Ah(h,:)*(K*Y)%
            Ax'*lB((h-1)*nConvex+1:h*nConvex,1) == (Ah(h,:)*K*I-Ah(h,:)*Cb)'
        end
        lL'*bx <= S_l-z'*(K*Y)+Cl*z'*xe %constraints for stability 
        Ax'*lL == (-z'*K*I+z'*Cl)'

        lB>=0
        lL>=0

        Sb<=0
        S_l<=0

cvx_end

end



