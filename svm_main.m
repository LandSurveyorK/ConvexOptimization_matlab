[v1,fval1] = svm(1,1);
[v2,fval2] = svm(1,10);
[v3,fval3] = svm(10,1);

[dv1,dfval1] = svmd(1,1);
[dv2,dfval2] = svmd(1,10);
[dv3,dfval3] = svmd(10,1);

distance(v1,dv1);
distance(v2,dv2);
distance(v3,dv3);

r1 = error(v1,1,1);
r2 = error(v2,1,10);
r3 = error(v3,10,1);