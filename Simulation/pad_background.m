function finalimg1 = pad_background(finalimg, noise)
%If there is a value for background noise, returns the original image on top
%of poisson distributed noise with a mean of the noise value
%Otherwise it returns a dark background
%Either way, it pads the original image with 5 pixels around the edges
%The padding helps with the analysis step, sonce that disregards a few pixels 
%around the image.
%Also helps to normalize image so max value=1

  finalsize = size(finalimg)(1)+10;
  if noise == 0
    finalimg1 = zeros(finalsize)
  else
    finalimg1 = poissrnd(noise,finalsize,finalsize);
  endif
  finalimg1(6:end-5,6:end-5) = finalimg1(6:end-5,6:end-5) + finalimg;
  finalimg1 = finalimg1/max(max(finalimg1));
endfunction