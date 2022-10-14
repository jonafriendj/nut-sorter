module ProfilePolygon(height){
    rotate_extrude(){
        gapStart = [WallThickness-TabWidth*2-Tolerance,0];
        translate([TrayRadius,0,0])
        polygon([
        [0,0],
        gapStart,
        [WallThickness-TabWidth*2-Tolerance,TabHeight+Tolerance],
        [WallThickness-TabWidth+Tolerance,TabHeight+Tolerance],
        [WallThickness-TabWidth+Tolerance,0],
        [WallThickness,0],
        [WallThickness,height],
        [WallThickness-TabWidth,height],
        [WallThickness-TabWidth,height+TabHeight],
        [WallThickness-TabWidth*2,height+TabHeight],
        [WallThickness-TabWidth*2,height],
        [0,height]
        ]);
    }
}

module ProfileSquares(){
    rotate_extrude()
    translate([TrayDiameter,0,0]) 
    {
        translate([WallThickness/2-TabWidth/2,BaseHeight,0]) 
            square([TabWidth,TabHeight]);

        difference() {
            square([WallThickness,BaseHeight]);
        
            translate([WallThickness/2-TabWidth/2-Tolerance,0,0]) 
                square([TabWidth+Tolerance*2, TabHeight+Tolerance]);
        }
    }
}

module ProfileCylinder(){

    difference(){
        // Cup
        cylinder(h=BaseHeight,d=TrayDiameter);

            translate([0,0,WallThickness]) 
                cylinder(h=BaseHeight,d=TrayDiameter-WallThickness*2);
            translate([0,0,-.001]) 
                Ring(true);
    }

    // Pin
    translate([0,0,BaseHeight-.001]) Ring();

}

module Ring(addTolerance=false){
    pad = addTolerance ? Tolerance : 0;

    difference(){
            outer = TrayDiameter-WallThickness+TabWidth;
            cylinder(h=TabHeight+pad,d=outer+pad*2);
            cylinder(h=(TabHeight+pad)*3,d=outer-TabWidth*2-pad*2,center=true);
    }
}