function P_null=new_value_MAUT(Pc)

% Pc - The initial pairwise comparison matrix for the criteria
[N,~, M] = size(Pc); % Obtaining the dimensions of the matrix Pc

Pc_null = Pc; % Copying the initial matrix Pc to the Pc_null matrix

% Updating the values of the matrix Pc_null
for m = 1:M
  for i = 1:N
    for j = 1:N
      if i ~= j && Pc(i, j, m) == 0 % If the value is 0 and not on the main diagonal
        Pc_null(i, j, m) = 1 / Pc_null(j, i, m);  % Calculating the reciprocal value

end
end
end
end
end
