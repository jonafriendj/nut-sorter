include <Profile.scad>

module SortCup(){
    rotate_extrude()
    translate([TrayRadius,0,0]) 
    {
        translate([-LipWidth,0,0]) 
        square([LipWidth,BaseThickness]);

        translate([WallThickness/2-TabWidth/2,TrayHeight,0]) 
            square([TabWidth,TabHeight]);

        difference() {
            square([WallThickness,TrayHeight]);
        
            translate([WallThickness/2-TabWidth/2-Tolerance,0,0]) 
                square([TabWidth+Tolerance*2, TabHeight+Tolerance]);
        }
    }
}