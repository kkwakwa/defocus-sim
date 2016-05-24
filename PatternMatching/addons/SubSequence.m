endfile = imread('grid2-3-240b-0239.png');
for i = 236:-4:0
    filename = sprintf('grid2-3-240b-%04i.png',i);
    midfile = imread(filename);
    subfile = abs(endfile - midfile);
    %subfile = imabsdiff(endfile,midfile);
    %subfile = subfile *(200/double(max(max(subfile))));
    imagefile = ['sub-',filename];
    imwrite(subfile,colormap(gray),imagefile,'png');
    endfile = midfile;
end

