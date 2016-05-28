function finalimg = random_pattern(startpattern, step, imlength)

  inputs = rand(1,step);
  finalimg = startpattern;
  sidelen = size(finalimg)(1);
    for i=1:step
      coords = find(imlength(1,:)>inputs(1,i), 1, 'first');
      if mod(coords,sidelen) == 0
          icoord = round(floor((coords)/sidelen));
      else
          icoord = round(floor(coords/sidelen))+1;
      end
      if rem(coords,sidelen) == 0
          jcoord = round(sidelen);
      else
          jcoord = round(rem(coords,sidelen));
      end
      finalimg(icoord,jcoord) = finalimg(icoord,jcoord) + 1;
    end

endfunction