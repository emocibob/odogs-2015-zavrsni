function segmLabUzorci( dirZaOkvire, imeOkvira, markeriBoja, brBoja, primjeniBlur, pokaziRez )
% segmentacija boja pomoæu L*a*b* modela boja i danih uzoraka boja

% uèitaj sliku i po potrebi je zamuti
dat = fullfile(dirZaOkvire, imeOkvira);
okvir = imread(dat);
if primjeniBlur == true
    okvir = blurFilter(okvir, 4, false);
end

% pretvori sliku u L*a*b* modela boja
cform = makecform('srgb2lab');
labOkvir = applycform(okvir, cform);
a = labOkvir(:, :, 2);
b = labOkvir(:, :, 3);

% oznaèi svaki piksel okvira koristeæi pravilo najbližeg susjeda za dane boje
oznakeBoja = 0:brBoja-1;
a = double(a);
b = double(b);
udaljenost = zeros([size(a), brBoja]);
for i = 1:brBoja
  udaljenost(:, :, i) = ( (a - markeriBoja(i,1)).^2 + (b - markeriBoja(i,2)).^2 ).^0.5;
end
[~, oznaka] = min(udaljenost, [], 3);
oznaka = oznakeBoja(oznaka);

% prikaži rezultate segmentacije
rgbOznaka = repmat(oznaka, [1 1 3]);
segmentiraneSlike = zeros([size(okvir), brBoja], 'uint8');
for i = 1:brBoja
  boja = okvir;
  boja(rgbOznaka ~= oznakeBoja(i)) = 0;
  segmentiraneSlike(:, :, :, i) = boja;
end
if pokaziRez == true
    figure;
    imshow(segmentiraneSlike(:, :, :, 1)), title('Crveni objekti');
    figure;
    imshow(segmentiraneSlike(:, :, :, 2)), title('Zeleni objekti');
end

end
