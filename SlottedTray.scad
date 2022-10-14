include <RectPattern.scad>
include <CirclePattern.scad>

module SlottedTray()
{
    
    if (ShowTextArea)
    {
        color("red")
        #cylinder(h = 10, r = TextArea,center=true);
    }

    difference(){
        cylinder(h=BaseThickness,d=TrayDiameter-Tolerance);

        if (PatternChoice == "circular")
        {
            CirclePattern();
        }
        else
        {
            RectPattern();
        }
    }       
}