%parameters for generating the library images
z = 0; NA = 1.40; n0 = 1.52; n=1.49; n1 = 1.0; d0 = []; d = 0.01; d1 = []; 
lamem = 0.57; mag = 100; focus = 0.6; atf = []; ring = []; pixel = 10; pic = 0; be_res = [5]; 
al_res = [5]; nn = [10];

model = PatternGeneration(z,NA,n0,n,n1,d0,d,d1,lamem,mag,focus,atf,ring,pixel,nn,be_res,al_res,pic);
bck = Disk((size(model.mask,1)-1)/2);

%inputs = the number of photons to introduce into the system
%inputs = rand(1,900000);
sidelen = length(model.mask(:,1,1));
statimg = zeros(sidelen);
imlength = zeros(1,sidelen*sidelen);
tmpno = size(model.mask);
imageno = tmpno(3);
r2deg = 57.2957795;
centre = nn+6;
limit = 100000;
step = 1000;
minim = 3000;
poissval = 300;



for mapval = 183:imageno
    thetaval = round(model.theta(mapval)*r2deg);
    phival = round(model.phi(mapval)*r2deg);
    for counts = 1:15
        lend = 0;
        rsum = 0;
        finalimg = zeros(sidelen);
        finalimg1 = zeros(sidelen+10);
        outfile = sprintf('N5deg/noise-%i-orientation_stats-%i-%i.txt',[poissval;mapval;counts]);
        
        %convert predicted image into probability map
        for i=1:sidelen
            for j=1:sidelen
                rsum=rsum + model.mask(i,j,mapval);
                rlen = j+((i-1)*sidelen);
                imlength(rlen) = rsum;
            end
        end
        
        %convert probability mask back into image(depricated for now since we know it works)
        %for i=1:sidelen
        %    for j=1:sidelen
        %        rlen = j+((i-1)*sidelen)
        %        if rlen >1
        %            statimg(i,j) = imlength(rlen) - imlength(rlen-1);
        %        end
        %    end
        %end
        
        linfile = fopen(outfile,'w');
        fprintf(linfile, 'Theta = %3i \t Phi = %3i\n',[thetaval;phival]);
        fprintf(linfile, 'photons \t x_coord \t y_coord \t theta \t phi \t error\n');
        
        
        while lend < limit
	    inputs = rand(1,step);
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
            lend = lend+step;
            
            if lend < minim
	      continue
	    end
	    
            poissimg = poissrnd(poissval,sidelen+10,sidelen+10);
            finalimg1(6:end-5,6:end-5) = finalimg1(6:end-5,6:end-5) + finalimg;
            finalimg1 = finalimg1 + poissimg;
            finalimg1 = finalimg1/max(max(finalimg));
            
	    [err, bim, cim, sim, xc, yc, bc, cc, sc, len, imm] = FindPattern(finalimg1, model.mask, bck, bck);
	    if size(xc) ~= 0
                errarray = double(err(yc(1), xc(1)));
                thetadeg = round(model.theta(sc(1))*r2deg);
                phideg = round(model.phi(sc(1))*r2deg);
                fprintf(linfile,'%7i \t %3i \t %3i \t %3i \t %3i \t %f\n',[lend;xc(1);yc(1);thetadeg;phideg;errarray]);
                %            imagefile = [outfile(1:end-4),'-',int2str(lend),'.png'];
                %            imwrite(finalimg1,imagefile,'png');
            end
            
            if size(xc) == 0
		continue
	    end
	    
            if thetadeg == thetaval && phideg == phival && xc(1) == centre && yc(1) == centre
                break
            end
           
        end
        
        OutFile = fclose(linfile);
    end
end