function simulate_pattern(total_photons, step, noise, runs)
%load system parameters from parameter file, loop through each generated pattern
%a set number of times(runs) adding (step) numbers of photons before fitting 
%it against the predicted patterns. 
%When the predicted orientation matches the fit result, save the data to a text 
%file and start again. The text file also tracks parameters and records the
%date and time the simulation took place in its title

  r2deg = 57.2957795; %radians to degrees
  [z,NA,n0,n,n1,d0,d,d1,lamem,mag,focus,atf,ring,pixel,nn,be_res,al_res,pic]...
  = parameters;
  model = PatternGeneration(z, NA, n0, n, n1, d0, d, d1, lamem, mag, focus,...
          atf, ring, pixel, nn, be_res, al_res, pic);
  bck = Disk((size(model.mask,1)-1)/2);
          
  maplength = size(model.mask)(3);
  today = localtime(time());
  outfile=sprintf('Simulation/results/simulation_%i_%i_%i_%i-%i.txt',...
          [1900+today.year;today.mon;today.mday;today.hour;today.min]);
  linfile = fopen(outfile,'w');
  fprintf(linfile, 'photons \t theta \t phi\n');
  for pattern_no = 1:maplength
    theta = round(model.theta(pattern_no) * r2deg);
    phi = round(model.phi(pattern_no) * r2deg);
    mask1 = model.mask(:,:,pattern_no);
    sz=size(mask1);
    imlength = prob_grid(mask1);
    for run = 1:runs
      finalimg = zeros(sz);
      for photons = step:step:total_photons
        finalimg = random_pattern(finalimg, step, imlength);
        finalimg1 = pad_background(finalimg, noise);
        [err, bim, cim, sim, xc, yc, bc, cc, sc, len, imm] =...
        FindPattern(finalimg1, model.mask, bck, bck);
        if size(xc) == 0 %no localizations
          continue
        end
        
        thetadeg = round(model.theta(sc(1))*r2deg);
        phideg = round(model.phi(sc(1))*r2deg);
        if thetadeg == theta && phideg == phi
          fprintf(linfile,'%7i\t%3i\t%3i\n',[photons;thetadeg;phideg]);
          printf('%i\n',photons)
          break
        end
        
      end
    end
  end
  OutFile = fclose(linfile);  
endfunction     
