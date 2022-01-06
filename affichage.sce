n = size(liaison,1);
m = size(ij,1);
ma = 0;
somme = 0;

plot2d(0,0)

//Affichage des membrures
for inc = 1:m
    i = ij(inc,1);
    j = ij(inc,2);
    l = sqrt((x(j,1)-x(i,1))^2 + (x(j,2)-x(i,2))^2);
    somme = somme + l;
    
    coor_x = [x(i,1), x(j,1)]
    coor_y = [x(i,2), x(j,2)]
    
    ma=max(x(i,1), x(j,1),x(i,2), x(j,2),ma)
    
    plot(coor_x, coor_y);
    xstring((x(i,1)+ x(j,1))/2,(x(i,2)+ x(j,2))/2,string(inc),0,1)
end


dim_app = somme /(m * 20)
plot2d(ma+dim_app,ma+dim_app)

//Affichage des appuis fixes
for inc = 1 : n
    if liaison(inc) == 1 then
        xfrect(x(inc,1)-dim_app, x(inc,2)+dim_app, 2*dim_app, 2*dim_app)
        gce().background = color("red");
    end
        xstring(x(inc,1)-2*dim_app,x(inc,2)+dim_app,string(inc))
end

g = gca();
g.axes_visible="off"


clear n, clear m, clear dim_app, clear somme, clear ma
