function symVar = trifocal_line_embedding(R)
%    Processed by symFileClean
%TRIFOCAL_LINE_EMBEDDINGAUTO
%    SYMVAR = TRIFOCAL_LINE_EMBEDDINGAUTO(R(1,1),R(1,2),R(1,3),R(2,1),R(2,2),R(2,3),R(3,1),R(3,2),R(3,3),R(4,1),R(4,2),R(4,3),R(5,1),R(5,2),R(5,3),R(6,1),R(6,2),R(6,3))

%    This function was generated by the Symbolic Math Toolbox version 5.8.
%    06-Nov-2013 19:36:44

t2 = conj(R(1,1));
t3 = conj(R(5,1));
t4 = conj(R(2,1));
t5 = conj(R(6,1));
t6 = conj(R(5,2));
t7 = conj(R(6,2));
t8 = conj(R(5,3));
t9 = conj(R(6,3));
t10 = conj(R(3,1));
t11 = conj(R(4,1));
t12 = conj(R(1,3));
t13 = conj(R(2,3));
t14 = conj(R(3,3));
t15 = conj(R(1,2));
t16 = conj(R(2,2));
t17 = conj(R(3,2));
t18 = conj(R(4,2));
t19 = conj(R(4,3));
symVar = [t2.*t3;t2.*t5;t2.*t6;t2.*t7;t2.*t8;t2.*t9;t3.*t4;t4.*t5;t4.*t6;t4.*t7;t4.*t8;t4.*t9;t3.*t10;t5.*t10;t6.*t10;t7.*t10;t8.*t10;t9.*t10;t11.*t15;t11.*t16;t11.*t17;t11.*t12;t11.*t13;t11.*t14;t3.*t12;t3.*t13;t3.*t14;t5.*t15;t5.*t16;t5.*t17;t15.*t18;t7.*t15;t15.*t19;t9.*t15;t16.*t18;t7.*t16;t16.*t19;t9.*t16;t17.*t18;t7.*t17;t17.*t19;t9.*t17;t12.*t18;t13.*t18;t14.*t18;t6.*t12;t6.*t13;t6.*t14;t12.*t19;t8.*t12;t13.*t19;t8.*t13;t14.*t19;t8.*t14;t2.^2;t4.^2;t10.^2;1.0;t2.*t15;t4.*t16;t10.*t17;t2.*t12;t4.*t13;t10.*t14;t15.^2;t16.^2;t17.^2;t12.*t15;t13.*t16;t14.*t17;t12.^2;t13.^2;t14.^2;t2.*t4;t15.*t16;t12.*t13;t2.*t10;t15.*t17;t12.*t14;t4.*t10;t16.*t17;t13.*t14;t11.^2;t3.^2;t5.^2;t11.*t18;t3.*t6;t5.*t7;t11.*t19;t3.*t8;t5.*t9;t18.^2;t6.^2;t7.^2;t18.*t19;t6.*t8;t7.*t9;t19.^2;t8.^2;t9.^2;t3.*t11;t6.*t18;t8.*t19;t5.*t11;t7.*t18;t9.*t19;t3.*t5;t6.*t7;t8.*t9];
