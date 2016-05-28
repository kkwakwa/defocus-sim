function imlength = prob_grid(pattern, sidelen)

rsum = 0
imlength = zeros(1,sidelen*sidelen);

  for i=1:sidelen
    for j=1:sidelen
      rsum=rsum + model.mask(i,j,mapval);
      rlen = j+((i-1)*sidelen);
      imlength(rlen) = rsum;
    end
  end
  
endfunction