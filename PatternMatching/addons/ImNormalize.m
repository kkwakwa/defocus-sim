for i = 0:2:118
    filename = sprintf('gridsequenceend%i.png',i);
    midfile = double(imread(filename));
    imagemax = max(max(midfile));
    subfile = midfile/imagemax;
    %subfile = subfile *(200/double(max(max(subfile))));
    imagefile = ['sub-',filename];
    imwrite(subfile,imagefile,'png');
end