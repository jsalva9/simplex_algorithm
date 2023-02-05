clear;
disp('Resolucio de PL amb algorisme del simplex primal. ')
regla = 2;
if regla == 1
    disp('Simplex amb regla del cost reduit mes negatiu. ')
else disp('Simplex amb Regla de Bland. ')
end

% Lectura de l'input
[A, b, c, m, n] = read();

disp('Executant Fase I... ')
[vb,f1out,niter,B_inv] = fase_1(A,b,m,n,regla);

if f1out == 0
    return
end
if f1out == 2
    disp('V aritificials a les VB')
    return
end

% Crea el vector de VNB a partir de vb
vn = zeros(1,n - m);
iter = 1;
for i = 1:n
    trobat = false;
    for j = 1:m
        if (vb(j) == i)
            trobat = true;
        end
    end
    if (trobat == false) 
        vn(iter) = i;
        iter = iter + 1;
    end
end

xb = B_inv*b;
z = c(vb,:)'*xb;

disp('Executant Fase II... ')
iout = 0;
while (iout == 0)
    niter = niter + 1;
        
    % regla = 1: simplex escollint VNB de cost reduit mes negatiu
    % regla = 2: simplex escollint VNB amb regla de Bland
    [vb, vn, xb, z,B_inv, iout] = simplex(c, A, b, vb, vn, xb, z,B_inv, regla, niter);
end
if iout == 1
    fprintf('Iteracio %2d : Solucio optima trobada ', niter)
    VB_opt = vb
    xb_opt = xb'
    z_opt = z
end
if iout == 2
   fprintf('Iteracio %2d : Problema il.limitat ', niter)
end
disp('Fi del simplex primal ')