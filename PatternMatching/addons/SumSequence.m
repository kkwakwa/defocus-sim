endfile = imread('posfile090.png');
for i = 94:2:118
    filename = sprintf('pos-gridsequenceend%i.png',i);
    midfile = imread(filename);
    subfile = endfile + midfile;
    %subfile = imabsdiff(endfile,midfile);
    %subfile = subfile *(200/double(max(max(subfile))));
    imagefile = sprintf('posfile%03i.png',i);
    imwrite(subfile,colormap(gray),imagefile,'png');
    endfile = subfile;
end