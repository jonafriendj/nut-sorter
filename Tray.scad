module Tray(){
    profile(TrayHeight);
    difference(){
        cylinder(h=BaseThickness,d=TrayDiameter+.001);
        translate([0,0,-1])
        cylinder(h=WallThickness+2,d=TrayDiameter-LipWidth);
    }
}
