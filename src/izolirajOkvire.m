function [ listaDatOkvira ] = izolirajOkvire( video, dirZaOkvire, prviOkvir, zadnjiOkvir )
% izoliraj pojedinaène okvire kao PNG slike iz MATLAB video objekta

listaDatOkvira = [];

for i = prviOkvir:zadnjiOkvir
    trenutniOkvir = read(video, i);
    okvirIme = sprintf('%.4d.png', i);
    listaDatOkvira = [listaDatOkvira; okvirIme];
    okvirDat = fullfile(dirZaOkvire, okvirIme);
    imwrite(trenutniOkvir, okvirDat, 'png');
    fprintf('Spremljen okvir br. %4d\n', i);
end

end
