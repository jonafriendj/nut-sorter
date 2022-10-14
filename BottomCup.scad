include <Profile.scad>

module BottomCup()
{
    ProfilePolygon(BaseHeight);
    cylinder(h=WallThickness,d=TrayDiameter+WallThickness*2);
}
