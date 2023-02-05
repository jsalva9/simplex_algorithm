function [vb,f1out,niter,B_inv] = fase_1(A,b,m,n,regla)
tol = 1e-12;

% Ampliacio de la matriu A pel problema de fase 1
auxi1 = zeros(n,1);
auxi2 = ones(m,1);
c1 = [auxi1; auxi2];
aux = eye(m);
A1 = [A, aux];
vb1 = n+1:n+m;
vn1 = 1:n;
xb1 = inv(A1(:,vb1))*b;
z1 = c1(vb1)'*xb1;
B_inv = eye(m);
iout = 0;
niter = 0;
while (iout == 0)
    niter = niter + 1;
    [vb1, vn1, xb1, z1,B_inv, iout] = simplex( c1, A1, b, vb1, vn1, xb1, z1,B_inv, regla,niter);
end
vb = vb1;
if (z1 > tol) 
    f1out = 0;                  % Problema infactible.
    fprintf('Iteracio %2d : Problema infactible \r', niter)
    return;
end
correcte = true;
for i = 1:m
    if(vb1(i) > n) correcte = false;
    end
end
if correcte == true
    f1out = 1;      % La base trobada no conté variables artificals
    fprintf('Iteracio %2d : SBF inicial trobada \r', niter)
else f1out = 2;     % La base trobada conté variables artificials
end
end