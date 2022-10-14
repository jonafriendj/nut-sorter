/* [Object Type] */
//Model Part
ObjectType=1; // [1:Bottom Cup, 2:Sorting Plate Attached To Cup, 3:Sorting Plate, 4:Sorting Cup, 5:Lid]

/* [Printer] */
Tolerance = .2; //.1
 //NozzleSize = "Not Used Yet";
 //LayerHeight = "Not Used Yet";
 //FirstLayer = "Not Used Yet";

/* [Global Settings] */
WallThickness = 3.0; //.1
TrayDiameter = 75; //.1
TabWidth = 1.2; //.1
TabHeight = 1.6; //.1

 /* [Sorting plate] */
// Nut Size 
NutSize=2; // [1:M2.5, 2:M3, 3:M4, 4:M5, 5:M6, 6:M8, 7:Machine #10, 8:Machine #8, 9:Machine #6, 10:Machine #4, 11:Machine #3, 12:Machine #2, 13:Machine #1, 14:1/4 in., 15:5/16ths, 16:3/8ths, 17:7/16ths, 18:1/2 in., 19:9/16ths, 20:5/8ths , 21:3/4ths, 22:7/8ths]
// Hole Spacing
HoleSpacing = 2;
//Text Area
TextArea = 9.5; //.2
//Show Text Area
ShowTextArea = false;
//Text Size
TextSize = 5;
// Text height off plate
TextHeight = 1.0; //.1
// Hole Pattern
Pattern=1; // [1:Circle, 2:Grid]
// Custom Label
CustomLabel = "";

 /* [Sorting tray layer] */
TrayHeight = 15; //.1
LipWidth = 2; //.1

/* [Bottom Cup] */
BaseHeight = 15; //.1
BaseThickness = 1.6; //.1

/* [Lid] */
LidHeight = 5; //.1
LidThickness = 1.6; //.1

 module __Customizer_Limit__ () {}  // Hides any more variables from the customizer

// Machine 
Machine_10 = 10.287;
Machine_8 = 9.3853;
Machine_6 = 8.0391;
Machine_4 = 6.9215;
Machine_3 = 5.3594;
Machine_2 = 4.8895;
Machine_1 = 2.1717;

// Imperial
I_1_4th = 11.6205;
I_5_16ths = 13.4874;
I_3_8ths = 15.3035;
I_7_16ths = 18.0086;
I_Half_Inch = 20.7518;
I_9_16ths = 23.4696;
I_5_8ths = 26.1747;
I_3_4ths = 29.5021;
I_7_8ths = 34.8742;

// Metric
Metric_2_5 = 5.57;
Metric_3 = 5.8;
Metric_4 = 7;
Metric_5 = 8.435;
Metric_6 = 11.8;
Metric_8 = 14.695;

Sizes=[
    Metric_2_5, Metric_3, Metric_4, Metric_5, Metric_6, Metric_8, 
    Machine_10, Machine_8, Machine_6, Machine_4, Machine_3, Machine_2, Machine_1,
    I_1_4th, I_5_16ths, I_3_8ths, I_7_16ths, I_Half_Inch, I_9_16ths, I_5_8ths , I_3_4ths , I_7_8ths 
];

Labels=[
    "M2.5", "M3", "M4", "M5", "M6", "M8", 
    "#10","#8","#6", "#4", "#3", "#2", "#1",
    "1/4", "5/16", "3/8", "7/16", "1/2", "9/16", "5/8" , "3/4" ,"7/8" 
];

// Used for customizer menus
Patterns=["circular","rect"];

// Calculated variables
TrayRadius = TrayDiameter/2;
HoleSize = Sizes[NutSize-1];
Label = Labels[NutSize-1];
PatternChoice = Patterns[Pattern-1];

$fn = $preview ? 60 : 128;

if (ObjectType == 1) {
    rotate_extrude() {
        translate([TrayRadius,0,0])
        polygon([
        [0,0],
        [WallThickness-TabWidth*2-Tolerance,0],
        [WallThickness-TabWidth*2-Tolerance,TabHeight+Tolerance],
        [WallThickness-TabWidth+Tolerance,TabHeight+Tolerance],
        [WallThickness-TabWidth+Tolerance,0],
        [WallThickness,0],
        [WallThickness,BaseHeight],
        [WallThickness-TabWidth,BaseHeight],
        [WallThickness-TabWidth,BaseHeight+TabHeight],
        [WallThickness-TabWidth*2,BaseHeight+TabHeight],
        [WallThickness-TabWidth*2,BaseHeight],
        [0,BaseHeight]
        ]);
    }

    cylinder(h=WallThickness,d=TrayDiameter+WallThickness*2);
}
else if(ObjectType == 4) {
    SortCup();
}
else if(ObjectType == 5) {
    translate([0,0,LidHeight]) 
    rotate([180,0,0]) {
        translate([0,0,LidHeight-LidThickness]) cylinder(h = LidThickness, d = TrayDiameter);

        rotate_extrude()
        translate([TrayRadius,0,0]) {
            difference() square([WallThickness,LidHeight]);
            translate([WallThickness/2-TabWidth/2-Tolerance,0,0])   square([TabWidth+Tolerance*2, TabHeight+Tolerance]);
        }
    }
}
else { // Tray only or tray and lid

    color("yellow")
    translate([0,0,TextHeight]) 
        linear_extrude(BaseThickness)
            text(CustomLabel == "" ? Label : CustomLabel,size=TextSize,halign="center",valign="center");
        
    if (ShowTextArea) color("red") #cylinder(h = 10, r = TextArea,center=true);

    difference(){
        cylinder(h=BaseThickness,d=TrayDiameter-Tolerance);

        if (PatternChoice == "circular"){
            firstPosition = TrayRadius-HoleSize/2-LipWidth;

            for(xpos=[firstPosition:-(HoleSize+HoleSpacing):TextArea+HoleSize/2])
            {
                steps = ceil(2*PI*xpos/(HoleSize+HoleSpacing));
                for(step=[1:1:steps])
                    rotate([0,0,step*(360/steps)])  translate([xpos,0,-1]) cylinder(h=5,d=HoleSize);
            }
        }
        else {
            r2 = HoleSize/2;

            maxHole = 0; 

            CopyMirror(){
                for(x2=[0:HoleSize+HoleSpacing:TrayRadius])
                    for(y2=[0:HoleSize+HoleSpacing:TrayRadius]){
                        distance = sqrt(((0 - x2) * (0 - x2)) + ((0 - y2) * (0 - y2)));

                        if (distance + r2 <= TrayRadius-LipWidth && distance + r2 > TextArea + HoleSize)
                            translate([x2,y2,0]) cylinder(h=BaseThickness*3,d=HoleSize,center=true);
                    }
                }
            }
        }       
    
    if (ObjectType == 2)    translate([0,0,.001])   SortCup();
}


module CopyMirror(){
    children();
    mirror([1,0,0]) children();
    mirror([0,1,0]) children();
    mirror([1,1,0]) children();
}

module SortCup(){
    rotate_extrude()
    translate([TrayRadius,0,0]){
        translate([-LipWidth,0,0])  square([LipWidth,BaseThickness]);

        translate([WallThickness/2-TabWidth/2,TrayHeight,0])  square([TabWidth,TabHeight]);

        difference()
            square([WallThickness,TrayHeight]);
            translate([WallThickness/2-TabWidth/2-Tolerance,0,0]) square([TabWidth+Tolerance*2, TabHeight+Tolerance]);
    }
}
