function random_images(pattern_number, total_photons, step)
  r2deg = 57.2957795;
  photons = 0;
  [z,NA,n0,n,n1,d0,d,d1,lamem,mag,focus,atf,ring,pixel,nn,be_res,al_res,pic]...
  = parameters;
  model = PatternGeneration(z, NA, n0, n, n1, d0, d, d1, lamem, mag, focus,...
          atf, ring, pixel, nn, be_res, al_res, pic);
  
  theta = round(model.theta(pattern_number) * r2deg);
  phi = round(model.phi(pattern_number) * r2deg);
  img_filename = sprintf('Simulation/images/orientation-%i-%i.png',[theta;phi]);
  mask1 = model.mask(:,:,pattern_number);
  
  imwrite(mask1 * 1/max(max(mask1)), img_filename);
  
  imlength = prob_grid(mask1);
  sz=size(mask1);
  finalimg = zeros(sz);
  
  imlength = prob_grid(mask1);
  while photons < total_photons
    finalimg = random_pattern(finalimg, step, imlength);
    img_filename = sprintf('Simulation/images/orientation-%i-%i_%i-photons.png',...
                  [theta;phi;photons]);
    imwrite(finalimg * 1/max(max(finalimg)), img_filename);
    photons += step
    
  end
  
endfunction
