function [dirZaOkvire] = napraviDir( ime )
% kreiraj novi direktorij (ako ne postoji) i vrati njegovo ime u glavni program

dirZaOkvire = fullfile(ime);

if ~exist(dirZaOkvire, 'dir')
   mkdir(dirZaOkvire) 
end

end
