module RectPattern()
{
    r2 = HoleSize/2;

    maxHole = 0; 

    CopyMirror(){
        for(x2=[0:HoleSize+HoleSpacing:TrayRadius]){
            for(y2=[0:HoleSize+HoleSpacing:TrayRadius])
            {
                distance = sqrt(((0 - x2) * (0 - x2)) + ((0 - y2) * (0 - y2)));

                if (distance + r2 <= TrayRadius-LipWidth && distance + r2 > TextArea + HoleSize)
                {
                    translate([x2,y2,0])
                    {
                        cylinder(h=BaseThickness*3,d=HoleSize,center=true);
                    }
                }
            }
        }
    }
}

module CopyMirror()
{
    children();
    mirror([1,0,0]) children();
    mirror([0,1,0]) children();
    mirror([1,1,0]) children();
}