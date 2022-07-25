function randPoint = randBox(center,a,b)

if length(center)>2
    randPoint = zeros(3,1);
    randPoint(1) = a(1) + (b(1)-a(1)).*rand;
    randPoint(2) = a(2) + (b(2)-a(2)).*rand;
    randPoint(3) = a(3) + (b(3)-a(3)).*rand;
else
    randPoint = zeros(2,1);
    randPoint(1) = a(1) + (b(1)-a(1)).*rand;
    randPoint(2) = a(2) + (b(2)-a(2)).*rand;
end




end