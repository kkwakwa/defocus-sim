%parameters for generating the library images
z = 0; NA = 1.40; n0 = 1.52; n=1.49; n1 = 1.0; d0 = []; d = 0.01; d1 = [];
lamem = 0.57; mag = 140; focus = 0.70; atf = []; ring = []; pixel = 16; pic = 0; be_res = [5];
al_res = [5]; nn = [];

mapval = 559;
r2deg = 57.2957795;

for focus = 0.4:0.2:1.2
    model = PatternGeneration(z,NA,n0,n,n1,d0,d,d1,lamem,mag,focus,atf,ring,pixel,nn,be_res,al_res,pic);
    bck = Disk((size(model.mask,1)-1)/2);
    
    %inputs = the number of photons to introduce into the system
    sidelen = length(model.mask(:,1,1));
    statimg = zeros(sidelen);
    imlength = zeros(1,sidelen*sidelen);
    
    %for mapval = 800:826
    for counts = 1:10
        inputs = rand(1,20000);
        lstart = 1;
        lend = 1000;
        rsum = 0;
        finalimg = zeros(sidelen);
        finalimg1 = zeros(sidelen+10);
        outfile = sprintf('focus_stats-%1.1f-%i.txt',[focus;counts]);
        
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
        fprintf(linfile, 'focus \t photons \t theta \t phi \t error\n');
        
        while lend < length(inputs(1,:))
            for i=lstart:lend
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
            
            finalimg1(6:end-5,6:end-5) = finalimg1(6:end-5,6:end-5) + finalimg;
            finalimg1 = finalimg1/max(max(finalimg));
            [err, bim, cim, sim, xc, yc, bc, cc, sc, len, imm] = FindPattern(finalimg1, model.mask, bck, bck);
            if size(xc) ~= 0
                errarray = err(yc(1), xc(1));
                thetadeg = round(model.theta(sc(1))*r2deg);
                phideg = round(model.phi(sc(1))*r2deg);
                fprintf(linfile,'%.2f \t %i \t %i \t %i \t %.4f\n',[focus;lend;thetadeg;phideg;errarray]);
                %            imagefile = [outfile(1:end-4),'-',int2str(lend),'.png'];
                %            imwrite(finalimg1,imagefile,'png');
            end
            lstart = lend+1;
            lend = lend+1000;
        end
        
        OutFile = fclose(linfile);
    end
end
