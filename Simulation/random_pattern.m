function finalimg = random_pattern(startpattern, step, imlength)
%use photons and probability map to figure out which pixel in the final
%image to increment by one until .
%Inputs:
%startpattern: array the same size as the predicted images
%step: the number of photons to add to the image
%imlength: the 1D probability array
%Output:
%finalimg:the starting array with 'step' number of photons randomly added
%following the probability distribution


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