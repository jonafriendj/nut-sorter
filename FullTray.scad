include <SlottedTray.scad>
include <AddText.scad>

module FullTray(xPos,yPos,zPos)
{
    translate([xPos,yPos,zPos])
    {
        AddText()
        SlottedTray();
    }
}