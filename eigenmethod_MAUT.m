function [W,CR]=eigenmethod_MAUT(P)

[V,lamda]=eig(P); %Lambda is the eigenvalue
                  %V is the eigenvector

[nx,ny]=size(lamda); %nx is the number of rows
                     %ny is the number of columns

L=zeros(nx,1);

for i=1:nx
  if imag(lamda(i,i))==0 %Check for the imaginary part of the element
    L(i)=lamda(i,i); %Store in matrix L the real eigenvalues of the lambda matrix (real part, imag = 0)
 end
end

[Lmax,ind]=max(L);%Return Lmax as the maximum value
                  %Return the position of the maximum value

W=abs(V(:,ind)/sum(V(:,ind)));

N=[3 4 5 6 7 8 9 10]; %Possible values of the matrix
RI=[0.52 0.89 1.11 1.25 1.25 1.4 1.45 1.49]; %Random index

n=nx;
CI=(Lmax-n)/(n-1);

for i=1:length(N)
 if n==N(i)
   CR=CI/RI(i);
 elseif n==1 || n==2

   CR=0;

end
end

if CR==0;
  P=pairwise_MAUT(S,n);
end

endfunction
