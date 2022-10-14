module Crop()
{
    if ($preview)
    {
        intersection()
        {
            translate([-200,-50,-100]) cube(200,false);
            children();
        }
    }
    else
    {
        children();
    }
}
