function segmLabColorSpace( dirZaOkvire, ime )
% Color-Based Segmentation Using the L*a*b* Color Space
% https://www.mathworks.com/help/images/examples/color-based-segmentation-using-the-l-a-b-color-space.html

% Acquire Image

dat = fullfile(dirZaOkvire, ime);
okvir = imread(dat);

% Calculate Sample Colors in L*a*b* Color Space for Each Region

brBoja = 3; % crvena + zelena + sve ostalo

% ruèno postavljanje
koordinateUzoraka = [222 89; 230 90; 233 97; 223 96]; % crvena
koordinateUzoraka(:, :, 2) = [436 167; 445 171; 441 174; 436 169]; % zelena
koordinateUzoraka(:, :, 3) = [248 198; 283 211; 281 247; 254 237]; % neko podruèje bezveze za ostale boje

podrucjaUzoraka = false([size(okvir, 1) size(okvir, 2) brBoja]);

for i = 1:brBoja
    podrucjaUzoraka(:, :, i) = roipoly(okvir, koordinateUzoraka(:, 1, i), koordinateUzoraka(:, 2, i));
end

figure;
imshow(podrucjaUzoraka(:, :, 1)), title('Podruèje uzorka za crvenu boju');

cform = makecform('srgb2lab');
labOkvir = applycform(okvir, cform);

a = labOkvir(:, :, 2);
b = labOkvir(:, :, 3);
markeriBoja = zeros([brBoja, 2]);

for i = 1:brBoja
  markeriBoja(i, 1) = mean2(a(podrucjaUzoraka(:, :, i)));
  markeriBoja(i, 2) = mean2(b(podrucjaUzoraka(:, :, i)));
end

% Classify Each Pixel Using the Nearest Neighbor Rule

oznakeBoja = 0:brBoja-1;

a = double(a);
b = double(b);
udaljenost = zeros([size(a), brBoja]);

for i = 1:brBoja
  udaljenost(: ,:, i) = ( (a - markeriBoja(i,1)).^2 + (b - markeriBoja(i,2)).^2 ).^0.5;
end

[~, oznaka] = min(udaljenost, [], 3);
oznaka = oznakeBoja(oznaka);
clear udaljenost;

% Display Results of Nearest Neighbor Classification

rgbOznaka = repmat(oznaka, [1 1 3]);
segmentiraneSlike = zeros([size(okvir), brBoja], 'uint8');

for i = 1:brBoja
  boja = okvir;
  boja(rgbOznaka ~= oznakeBoja(i)) = 0;
  segmentiraneSlike(:, :, :, i) = boja;
end

figure;
imshow(segmentiraneSlike(:, :, :, 1)), title('Crveni objekti');
figure;
imshow(segmentiraneSlike(:, :, :, 2)), title('Zeleni objekti');

end
