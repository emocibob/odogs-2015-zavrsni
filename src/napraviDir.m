function [dirZaOkvire] = napraviDir( ime )
% kreiraj novi direktorij (ako ve� ne postoji) i vrati njegovo

dirZaOkvire = fullfile(ime);
if ~exist(dirZaOkvire, 'dir')
   mkdir(dirZaOkvire) 
end

end
