function [ markeriBoja, brBoja ] = defUzorkeBoja( dirZaOkvire, ime, pokaziUzorke )
% postavljanje podruèja uzorke boja i raèunanje prosjeènih boja za te uzorke

dat = fullfile(dirZaOkvire, ime);

if exist(dat, 'file') == 2
    
    % ruèno postavljene podruèja uzoraka za prvi okvir
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
    brBoja = 4;                        
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
    
    % izraèunaj prosjeènu boju u L*a*b* modelu za svaki dani uzorak
    cform = makecform('srgb2lab');
    labOkvir = applycform(okvir, cform);
    a = labOkvir(:, :, 2);
    b = labOkvir(:, :, 3);
    markeriBoja = zeros([brBoja, 2]);
    for i = 1:brBoja
      markeriBoja(i, 1) = mean2(a(podrucjaUzoraka(:, :, i)));
      markeriBoja(i, 2) = mean2(b(podrucjaUzoraka(:, :, i)));
    end
    
else
    
    podrucjaUzoraka = [];
    warning(['Datoteka ', dat, ' ne postoji. podrucjeUzoraka prazno.']);
    
end

end

