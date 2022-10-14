module Lid()
{
    translate([0,0,LidHeight]) 
    rotate([180,0,0]){
        translate([0,0,LidHeight-LidThickness]) 
        cylinder(h = LidThickness, d = TrayDiameter);

        rotate_extrude()
        translate([TrayRadius,0,0]) 
        {
            difference() {
                square([WallThickness,LidHeight]);
            
                translate([WallThickness/2-TabWidth/2-Tolerance,0,0]) 
                    square([TabWidth+Tolerance*2, TabHeight+Tolerance]);
            }
        }
    }
}