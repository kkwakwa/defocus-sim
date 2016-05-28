function imlength = prob_grid(pattern)

rsum = 0;
sidelen = size(pattern)(1);
imlength = zeros(1,sidelen*sidelen);

  for i=1:sidelen
    for j=1:sidelen
      rsum=rsum + pattern(i,j);
      rlen = j+((i-1)*sidelen);
      imlength(rlen) = rsum;
    end
  end
  
endfunction