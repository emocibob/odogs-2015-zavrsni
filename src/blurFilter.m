function [ noviOkvir ] = blurFilter( okvir, radius, prikazi )
% zamuti sliku

filter = fspecial('disk', radius); % cirkularni filter za raèunanje prosjeka
noviOkvir = imfilter(okvir, filter, 'replicate');

if prikazi == true
    figure;
    imshow(noviOkvir);
end

end

