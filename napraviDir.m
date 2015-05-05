function [dirZaOkvire] = napraviDir( ime )
% kreiraj novi direktorij (ako ne postoji) i
% vrati njegovo ime u glavni program

dirZaOkvire = fullfile(ime);

if ~exist(dirZaOkvire)
   mkdir(dirZaOkvire) 
end

end
