function imlength = prob_grid(pattern)
%convert predicted image(pattern) into a 1-D probability map
%the predicted images are all normalized so all pixel intensities sum up to 1
%This function just unravels the image into a 1D array and runs a cumulative sum
%from the first pixel to the last.This means the value of the final pixel should
%always be 1

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