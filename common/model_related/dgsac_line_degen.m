function r = dgsac_line_degen(X)

r = any(pdist(X) < eps);
    
end