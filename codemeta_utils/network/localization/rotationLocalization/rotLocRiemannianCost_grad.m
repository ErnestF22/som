function gradc=rotLocRiemannianCost_grad(E,R,RRel,funs)
gradc=rotLocBaseCost_grad(E,R,RRel,...
    @(Ri,Rj,Rij) rotLocRiemannianCostPair_grad(Ri,Rj,Rij,funs));
