function img = readAndPreprocess(filename)

img = imread(filename);

if size(img,3) == 3
    img = rgb2gray(img);
end

img = imresize(img,[100 100]);
img = im2single(img);

end
