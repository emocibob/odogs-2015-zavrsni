function segmKMeans( dirZaOkvire, ime, primjeniBlur )
% automatska segmentacija boja na temelju L*a*b* modela boja i k-means grupiranja

% proèitaj sliku i po potrebi je zamuti
dat = fullfile(dirZaOkvire, ime);
okvir = imread(dat);
if primjeniBlur == true
   okvir = blurFilter(okvir, 10, false);
end
imshow(okvir), title('Test okvir');

% pretvaranje iz RGB u L*a*b* model boja
cform = makecform('srgb2lab');
labOkvir = applycform(okvir, cform);

% grupiraj boje pomoæu k-means grupiranja
ab = double(labOkvir(:, :, 2:3));
brRedaka = size(ab, 1);
brStupaca = size(ab, 2);
ab = reshape(ab, brRedaka*brStupaca, 2);
brBoja = 4;
[cluster_idx, cluster_center] = kmeans(ab,brBoja, 'distance','sqEuclidean', 'Replicates',3);

% oznaèi svaki piksel na temelju rezultata grupiranja
pixelOznake = reshape(cluster_idx, brRedaka, brStupaca);
imshow(pixelOznake, []);
title(['Okvir ', ime, ' oznaèen indeksima pripadnih klastera']);

% napravi slike koje pokazuju segmentirana podruèja
segmentiraneSlike = cell(1, brBoja);
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
