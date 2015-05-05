function izolirajOkvire( video, dirZaOkvire, zadnjiOkvir )
% izoliraj pojedinaène okvire (kao PNG slike) iz MATLAB video objekta

for i = 1 : zadnjiOkvir
    
    trenutniOkvir = read(video, i);
    okvirIme = sprintf('%.4d.png', i);
    okvirDat = fullfile(dirZaOkvire, okvirIme);
    imwrite(trenutniOkvir, okvirDat, 'png');
    
    fprintf('Spremljen okvir br. %4d\n', i); % stanje
    
end

end
