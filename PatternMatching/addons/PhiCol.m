r2deg = 57.2957795;
phirange = (0:al_res:360)/r2deg;
phivalrange = (0:al_res:360)/360;
masklen = length(model.mask(1,1,:));
imsize = size(model.mask(:,:,1));
phifinalim = zeros(size(im));


for i = 1:length(sc)
    valpos = find(phirange>model.theta(sc(i)),1,'first');
    mm = (phivalrange(valpos)-phivalrange(valpos-1))*((model.mask(:,:,sc(i)))/max(max(model.mask(:,:,sc(i)))));
    for j=1:21
        for k=1:21
            if mm(j,k)>0
                mm(j,k) = mm(j,k) + phivalrange(valpos-1);
            end
        end
    end
    
    phifinalim(xc(i)-10:xc(i)+10,yc(i)-10:yc(i)+10)= mm;
    
end
