% tema:    Segmentacija laserske to�ke na slici
% zadatak: na izdvojenim okvirima iz video sekvence, izolirati crvenu i zelenu to�ku (reflektirani laser)

clc % o�isti komandnu liniju
clear % o�isti workspace
close all % zatvori 'figure' prozore

tic; % po�ni mjeriti vrijeme izvo�enja

dirZaOkvire = napraviDir('okviri');

dat = 'dobra_snimka.mp4';
vid = VideoReader(dat);
brOkvira = vid.NumberOfFrames;
prviOkvir = 480;
zadnjiOkvir = 490;

fprintf('Ukupno okvira: %d\n', brOkvira);

fprintf('Spremanje prvog okvira...\n');
izolirajOkvire(vid, dirZaOkvire, 1, 1);

fprintf('Spremanje okvira od br. %d do br. %d...\n', prviOkvir, zadnjiOkvir);
listaDatOkvira = izolirajOkvire(vid, dirZaOkvire, prviOkvir, zadnjiOkvir);

% TODO dodati blur filter u nadi da �e se dobiti bolji rezultati (manji �um) sa drugim algoritmom
% testiranje
I = imread(fullfile(dirZaOkvire, '0490.png'));
imshow(I);
blurTests = blurFilter(I, 5, true);

% algoritam daje lo�e rezultate
fprintf('Testna segmentacija prvog okvira (Color-Based Segmentation Using K-Means Clustering)...\n');
segmKMeans(dirZaOkvire, '0001.png');

[podrucjaUzoraka, brBoja] = definirajUzorkeBoja(dirZaOkvire, '0001.png', false);

fprintf('Color-Based Segmentation Using the L*a*b* Color Space...\n');

% samo prvi okvir
segmLabColorSpace(dirZaOkvire, '0001.png', podrucjaUzoraka, brBoja, true);

for i = 1:(zadnjiOkvir-prviOkvir+1)
    segmLabColorSpace(dirZaOkvire, listaDatOkvira(i, :), podrucjaUzoraka, brBoja, true);
end

toc; % ispi�i vrijeme izvo�enja