% tema:    Segmentacija laserske toèke na slici
% zadatak: na izdvojenim okvirima iz video sekvence, izolirati crvenu i
%          zelenu toèku (reflektirani laser)

clc % oèisti konadnu liniju
clear % oèisti workspace
close all % zatvori 'figures' prozore

dirZaOkvire = napraviDir('okviri'); % dir za izolirane okvire videa

dat = 'dobra_snimka.mp4';
vid = VideoReader(dat);
brOkvira = vid.NumberOfFrames;
zadnjiOkvir = 10;

fprintf('Ukupno okvira u videu: %d\n', brOkvira);
fprintf('Spremanje prvih %d okvira...\n', zadnjiOkvir);

izolirajOkvire(vid, dirZaOkvire, zadnjiOkvir);

% testiranja sa prvim okvirom

fprintf('Testna segmentacija prvog okvira (Color-Based Segmentation Using K-Means Clustering)...\n');
segmKMeans(dirZaOkvire, '0001.png');

% TODO maknuti generalne izraèune (uvijek isti za svaki okvir) iz funkcije
fprintf('Testna segmentacija prvog okvira (Color-Based Segmentation Using the L*a*b* Color Space)...\n');
segmLabColorSpace(dirZaOkvire, '0001.png');
