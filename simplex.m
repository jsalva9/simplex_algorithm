function [vb, vn, xb, z,B_inv, iout] = simplex(c, A, b, vb, vn, xb, z,B_inv, regla, niter)
tol = 1e-12;
[m, n] = size(A);

% 1. Vector de costos
r = (c(vn,:))' - (c(vb,:))'*B_inv*A(:,vn);

if regla == 1   % apliquem cost reduit mes negatiu
    minim = 0;
    q = -1;
    for i = 1:n-m
        if r(i) < minim
           minim = r(i);
           q = i;
        end
    end
end

if regla == 2    % apliquem regla de Bland
    q = -1;
    minim = inf;
    for i = 1:n-m
        if (r(i) < 0)
            if (vn(i) < minim)
                q = i;  % INDEX de la VNB d'entrada. Entra vn(q)
                minim = vn(i);
            end
        end
    end
end

 if (q == -1) 
        iout = 1;       % SBF optima trobada
        return;
 end
    
% 2. Direccio basica
db = -B_inv*A(:,vn(q));
if min(db) >= tol
    iout = 2;           % Problema il.limitat
    return;
end

% 3. Longitud de pas
theta = inf;    
p = 0;                 % INDEX de la vb de sortida
for i = 1:m
    if (db(i) < 0) & (-xb(i)/db(i) < theta)
        theta = -xb(i)/db(i);
        p = i;
    end
end

% 4. Actualitzacions
k = vb(p);
vb(p) = vn(q);
vn(q) = k;

% Actualització de la inversa al nou conjunt de vb
aux = eye(m);
for i = 1:m
    aux(i,p) = -db(i)/db(p);
end
aux(p,p) = -1/db(p);
B_inv = aux*B_inv;

xb = B_inv*b;
z = c(vb,:)'*xb;

fprintf('Iteracio %2d : N(q) = %2d , rq = %11.3f , B(p) = %2d , theta* = %7.3f , z = %8.3f \r' , niter, vb(p), r(q), vn(q), theta, z)

iout = 0;
end