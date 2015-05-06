function [ podrucjaUzoraka, brBoja ] = definirajUzorkeBoja( dirZaOkvire, ime, pokaziUzorke )
% ruèno namještanje podruèja za uzorke boja u prvom okviru videa

dat = fullfile(dirZaOkvire, ime);

if exist(dat, 'file') == 2 % datoteka postoji
    
    koordinateUzoraka = [224 90;
                        230 90;
                        234 94;
                        233 99;
                        228 102;
                        223 97;
                        222 93]; % crvena
    koordinateUzoraka(:, :, 2) = [441 171;
                                 444 169;
                                 446 173;
                                 442 176;
                                 438 173;
                                 436 171;
                                 438 166]; % zelena
    koordinateUzoraka(:, :, 3) = [258 180;
                                 278 168;
                                 301 175;
                                 312 198;
                                 299 222;
                                 276 220;
                                 227 200]; % boja ravnala
    koordinateUzoraka(:, :, 4) = [492 26;
                                 512 10;
                                 560 10;
                                 592 27;
                                 615 56;
                                 616 85;
                                 506 42]; % boja zida
    brBoja = 4; % ove navedene gore                         
    okvir = imread(dat);
    podrucjaUzoraka = false([size(okvir, 1) size(okvir, 2) brBoja]);
    
    for i = 1:brBoja
        podrucjaUzoraka(:, :, i) = roipoly(okvir, koordinateUzoraka(:, 1, i), koordinateUzoraka(:, 2, i));
    end
    
    if pokaziUzorke == true
        for i = 1:brBoja
            figure;
            imshow(podrucjaUzoraka(:, :, i)), title(['Podrucje za uzorak br. ', num2str(i)]);
        end
    end
    
else
    
    podrucjaUzoraka = [];
    warning(['Datoteka ', dat, ' ne postoji. podrucjeUzoraka prazno.']);
    
end

end

