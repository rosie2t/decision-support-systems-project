function P=pairwise_MAUT(S,n)

n=3; %The number of criteria

P=zeros(n,n);

for i=1:n
 for j=1:n
   if (i==j)
     P(i,i)=1; %Fill the diagonal with 1
   elseif j>i %Fill the upper triangular part of the matrix
     P(i,j)=S(ceil(length(S).*rand(1,1)));

end
end
end

%Fill the lower triangular part of the matrix
for k=2:n
 for m=1:(k-1)
    P(k,m)=1/P(m,k);

end
end

endfunction
