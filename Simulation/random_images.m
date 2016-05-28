function random_images(pattern_number, total_photons, photons,step)
  r2deg = 57.2957795;
  
  [z,NA,n0,n,n1,d0,d,d1,lamem,mag,focus,atf,ring,pixel,nn,be_res,al_res,pic]...
  = parameters;
  model = PatternGeneration(z, NA, n0, n, n1, d0, d, d1, lamem, mag, focus,...
          atf, ring, pixel, nn, be_res, al_res, pic);
  
  theta = round(model.theta(pattern_number) * r2deg);
  phi = round(model.phi(pattern_number) * r2deg);
  sidelen = (length(model.mask(:,1,1));
  imlength = zeros(1,sidelen*sidelen);
  
  orig_filename = sprintf('Simulation.images/orientation-%i-%i.png',[theta;phi]);
  mask1 = model.mask(:,:,pattern_number) *...
          1/max(max(model.mask(:,:,pattern_number)));
  imwrite(mask1, orig_filename);
  
endfunction
