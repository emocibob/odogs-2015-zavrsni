function spremiSliku( okvir, imeDir, imeDat, sufiksIme )
% spremi sliku, po potrebi napravi novi direktorij za sliku

dirSegmOkviri = fullfile(imeDir);
if ~exist(dirSegmOkviri, 'dir')
   mkdir(dirSegmOkviri) 
end

% makni '.png' iz imena
imeDat = imeDat(1, 1:length(imeDat)-4);

% spremi segmentiranu sliku sa pripadnim sufiksom
imeDat = [imeDat, '_', sufiksIme, '.png'];
dat = fullfile(dirSegmOkviri, imeDat);
imwrite(okvir, dat, 'png');

end

