include <BottomCup.scad>;
include <nutSizes.scad>
include <FullTray.scad>;
include <Crop.scad>;
include <Lid.scad>;
include <SortCup.scad>;

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
NutSize=2; // [1:M2.5, 2:M3, 3:M4, 4:M5, 5:M6, 6:M8, 7:Machine #10, 8:Machine #8, 9:Machine #6, 10:Machine #4, 11:Machine #3, 12:1/4 in., 13:5/16ths, 14:3/8ths, 15:7/16ths, 16:1/2 in., 17:9/16ths, 18:5/8ths , 19:3/4ths, 20:7/8ths]
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

// Used for customizer menus
Patterns=["circular","rect"];

// Calculated variables
TrayRadius = TrayDiameter/2;
HoleSize = Sizes[NutSize-1];
Label = Labels[NutSize-1];
PatternChoice = Patterns[Pattern-1];

$fn = $preview ? 60 : 128;

if (ObjectType == 1)
{
    BottomCup();   
}
else if(ObjectType == 4)
{
    SortCup();
}
else if(ObjectType == 5)
{
    Lid();
}
else // Tray only or tray and lid
{
    FullTray(xPos = 0, yPos = 0, zPos = 0);
    if (ObjectType == 2)
    {
        translate([0,0,.001]) 
        SortCup();
    }
}
