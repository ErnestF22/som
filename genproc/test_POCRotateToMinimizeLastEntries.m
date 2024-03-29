% function POCRotateToMinimizeLastEntries
dLow=3;
d=5;
nbCols=10;

% Generate low-rank data
xLow=rand(dLow,nbCols);
xTrue=[xLow; zeros(d-dLow,nbCols)];
QTrue=rot_randn(eye(d));
x=QTrue*xTrue;


% Recover a Q for aligning the data
[Q,~,~]=svd(x*x');
disp('x=')
disp(x)
disp('Q''*x=')
disp(Q'*x)


%% EF

R = zeros(4,3,3);
R(:,:,1) =[
  -0.812728367573879   0.364762014232424   0.418766102871191;
   0.079417601237271  -0.664534191278519   0.502715344803537;
   0.478086669628382   0.364716187242740   0.738515371539764;
   0.323417039560469   0.540670957568491  -0.162810562263695];
R(:,:,2) =[
   0.111053954925067   0.177477305244115   0.961827739577185;
   0.332264361402711   0.718792405475127  -0.271244238005747;
   0.930324009264719  -0.203198726571996  -0.014043867783920;
   0.108464976018847  -0.640741415450950  -0.033417547878209];
R(:,:,3) =[
   0.802707958560606   0.569735175619352   0.002353364399888;
  -0.348949474173510   0.325241590467006  -0.687813737114413;
   0.422731050230770  -0.498396630273226  -0.692740191566677;
   0.234931174832727  -0.566763210189909   0.216835771266807];
R(:,:,4) =[
   0.364717163475128   0.244934411691577  -0.897332776488672;
  -0.591701607362632   0.779542628572305  -0.037217492655861;
  -0.667380656121294  -0.574810862029427  -0.436756991949220;
   0.267345578505134  -0.043736679124839   0.051498315147307];


x = [matStackH(R)];
QRots = POCRotateToMinimizeLastEntries(x);
disp('x=')
disp(x)
disp('QRots''*x=')
disp(QRots'*x)

disp('det(QRots)')
disp(det(QRots))

%%

nrs = 4;
d = 3;
N = 5;
rot_true = randrot(d, N);
rot_true_stief_stacked = cat_zero_row(matStackH(rot_true), nrs-d);

Q_gauge = make_rand_stiefel_3d_array(nrs,nrs,1);

rots_gauged = Q_gauge * rot_true_stief_stacked;

Q = POCRotateToMinimizeLastEntries(rots_gauged);

disp('rot_true_stief_stacked=')
disp(rot_true_stief_stacked)
rots_no_gauge = Q*rots_gauged;
disp('rots_no_gauge=')
disp(rots_no_gauge)

%!!!!!!!!!!!!!!!!!!!!!!!!!!!! These should all be equal
disp("multiprod(matUnstackH(rot_true), multitransp(matUnstackH(rots_no_gauge(1:d,:))))")
disp(multiprod(matUnstackH(rot_true), multitransp(matUnstackH(rots_no_gauge(1:d,:)))))
%!!!!!!!!!!!!!!!!!!!!!!!!!!!!

check_transf = multiprod(multitransp(matUnstackH(rot_true_stief_stacked(1:d, :))), ...
    matUnstackH(rots_no_gauge(1:d, :)));

disp("check_transf")
disp(check_transf)

comp = [rot_true_stief_stacked; rots_no_gauge];
disp("comp");
disp(comp);

%% SE-Sync round solution

sz = [nrs, d, N];
problem = struct('sz', sz);

rots_nogauge_se_sync = round_solution_se_sync(rot_true_stief_stacked, problem);
disp("[rots_nogauge_se_sync; rot_true_stief_stacked]")
disp([rots_nogauge_se_sync; rot_true_stief_stacked])




