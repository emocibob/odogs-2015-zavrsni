function segmKMeans( dirZaOkvire, ime )
% Color-Based Segmentation Using K-Means Clustering
% https://www.mathworks.com/help/images/examples/color-based-segmentation-using-k-means-clustering.html

% Read Image

dat = fullfile(dirZaOkvire, ime);
okvir = imread(dat);
imshow(okvir), title('Test okvir');

% Convert Image from RGB Color Space to L*a*b* Color Space

cform = makecform('srgb2lab');
labOkvir = applycform(okvir, cform);

% Classify the Colors in 'a*b*' Space Using K-Means Clustering

ab = double(labOkvir(:, :, 2:3));
brRedaka = size(ab, 1);
brStupaca = size(ab, 2);
ab = reshape(ab, brRedaka*brStupaca, 2);

brBoja = 4;
% repeat the clustering 3 times to avoid local minima
[cluster_idx, cluster_center] = kmeans(ab,brBoja, 'distance','sqEuclidean', 'Replicates',3);

% Label Every Pixel in the Image Using the Results from KMEANS

pixelOznake = reshape(cluster_idx, brRedaka, brStupaca);
%figure;
imshow(pixelOznake, []);
title(['Okvir ', ime, ' oznaèen indeksima pripadnih klastera']);

% Create Images that Segment the H&E Image by Color.

segmentiraneSlike = cell(1, 3);
rgbOznaka = repmat(pixelOznake, [1 1 3]);

for k = 1:brBoja
    boja = okvir;
    boja(rgbOznaka ~= k) = 0;
    segmentiraneSlike{k} = boja;
end

for k = 1:brBoja
    figure;
    imshow(segmentiraneSlike{k});
    title(['Objekti klastera br. ', num2str(k)]);
end

end
