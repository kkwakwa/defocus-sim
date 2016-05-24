r2deg = 57.2957795;
thetarange = (0:al_res:90)/r2deg;
thetavalrange = (0:al_res:90)/90;
masklen = length(model.mask(1,1,:));
imsize = size(model.mask(:,:,1));
finalim = zeros(size(im));


for i = 1:length(sc)
    valpos = find(thetarange>model.theta(sc(i)),1,'first');
    mm = (thetavalrange(valpos)-thetavalrange(valpos-1))*((model.mask(:,:,sc(i)))/max(max(model.mask(:,:,sc(i)))));
    for j=1:21
        for k=1:21
            if mm(j,k)>0
                mm(j,k) = mm(j,k) + thetavalrange(valpos-1);
            end
        end
    end
    
    for j=1:21
        for k=1:21
            if finalim(xc(i)-11+j,yc(i)-11+k) == 0
                finalim(xc(i)-11+j,yc(i)-11+k)= mm(j,k);
            end
        end
    end
    
end
