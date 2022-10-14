module CirclePattern()
{

    firstPosition = TrayRadius-HoleSize/2-LipWidth;

    for(xpos=[firstPosition:-(HoleSize+HoleSpacing):TextArea+HoleSize/2])
    {
        steps = ceil(2*PI*xpos/(HoleSize+HoleSpacing));
        for(step=[1:1:steps])
        {
            rotate([0,0,step*(360/steps)])
            translate([xpos,0,-1])
            {
                cylinder(h=5,d=HoleSize);
            }
        }
    }
}
