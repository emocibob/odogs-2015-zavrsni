function segmKMeans( dirZaOkvire, imeOkvira, brBoja, primjeniBlur, pokaziRez, spremi )
% automatska segmentacija boja na temelju L*a*b* modela boja i k-means grupiranja

% proèitaj sliku i po potrebi je zamuti
dat = fullfile(dirZaOkvire, imeOkvira);
okvir = imread(dat);
if primjeniBlur == true
   okvir = blurFilter(okvir, 4, false);
end

% pretvaranje iz RGB u L*a*b* model boja
cform = makecform('srgb2lab');
labOkvir = applycform(okvir, cform);

% grupiraj boje pomoæu k-means grupiranja
ab = double(labOkvir(:, :, 2:3));
brRedaka = size(ab, 1);
brStupaca = size(ab, 2);
ab = reshape(ab, brRedaka*brStupaca, 2);
[cluster_idx, cluster_center] = kmeans(ab, brBoja, 'distance','sqEuclidean', 'Replicates',3);

% oznaèi svaki piksel na temelju rezultata grupiranja i po potrebi prikaži nastalu mapu
pixelOznake = reshape(cluster_idx, brRedaka, brStupaca);
if pokaziRez == true
    figure;
    imshow(pixelOznake, []);
end

% napravi slike koje pokazuju segmentirana podruèja
segmentiraneSlike = cell(1, brBoja);
rgbOznaka = repmat(pixelOznake, [1 1 3]);
for k = 1:brBoja
    boja = okvir;
    boja(rgbOznaka ~= k) = 0;
    segmentiraneSlike{k} = boja;
end

% prikaži segmentirane slike
if pokaziRez == true
    for k = 1:brBoja
        figure;
        imshow(segmentiraneSlike{k});
        title(['Objekti grupe br. ', num2str(k)]);
    end
end

% spremi segmentirane slike
if spremi == true
    for k = 1:brBoja
        if primjeniBlur == true
            sufiks = ['blur_k_', num2str(brBoja), '_g_', num2str(k)];
        else
            sufiks = ['k_', num2str(brBoja), '_g_', num2str(k)];
        end
        spremiSliku(segmentiraneSlike{k}, 'okviri_segm_kmeans', imeOkvira, sufiks);
    end
end

end
