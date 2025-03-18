function U=utility(x,xi_minus,xi_plus)

%x the value of the criterion
%xi_minus the worst value of the criterion xi
%xi_plus the best value of the criterion xi


U=(x - xi_minus)/(xi_plus - xi_minus);

endfunction
