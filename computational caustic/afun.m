function y = afun(x,transp_flag)
       if strcmp(transp_flag,'transp')      % y = A'*x
          y = Lap2(x);
       elseif strcmp(transp_flag,'notransp') % y = A*x
          y = Lap2(x);
       end
end