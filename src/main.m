% student: Edvin Moèibob
% tema:    Segmentacija laserske toèke na slici
% zadatak: na izdvojenim okvirima iz video sekvence, izolirati crvenu i zelenu toèku (reflektirani laser)

% oèisti cli i workspace te zatvori otvorene figure
clc
clear
close all

% vrijeme izvoðenja
tic

% potrebne varijable
dirZaOkvire = napraviDir('okviri');
dat = 'dobra_snimka.mp4';
vid = VideoReader(dat);
brOkvira = vid.NumberOfFrames;
prviOkvir = 480;
zadnjiOkvir = 490;
fprintf('Ukupno okvira: %d\n', brOkvira);

% spremi pojedine okvire iz video snimke
fprintf('Spremanje prvog okvira...\n');
izolirajOkvire(vid, dirZaOkvire, 1, 1);
fprintf('Spremanje okvira od br. %d do br. %d...\n', prviOkvir, zadnjiOkvir);
listaDatOkvira = izolirajOkvire(vid, dirZaOkvire, prviOkvir, zadnjiOkvir);

% k-means segmentacija
fprintf('Segmentacija prvog okvira - k-means grupiranje...\n');
segmKMeans(dirZaOkvire, '0001.png', true);

% lab segmentacija na temelju danih uzoraka
fprintf('Definiraj uzorke boja za sljedeæu tehniku segmentacije...\n');
[markeriBoja, brBoja] = defUzorkeBoja(dirZaOkvire, '0001.png', false);

% samo prvi okvir
fprintf('Segmentacija prvog okvira - L*a*b* modela boja i dani uzorci boja...\n');
segmLabUzorci(dirZaOkvire, '0001.png', markeriBoja, brBoja, true, false, true);

% odabrani okviri
fprintf('Segmentacija odabranih okvira - L*a*b* modela boja i dani uzorci boja...\n');
for i = 1:(zadnjiOkvir-prviOkvir+1)
    segmLabUzorci(dirZaOkvire, listaDatOkvira(i, :), markeriBoja, brBoja, true, false, true);
end

% ispiši vrijeme izvoðenja
toc