module AddText(){
    union(){
        color("grey")
        children(0);
        color("yellow")
        translate([0,0,TextHeight]){
            linear_extrude(BaseThickness)
            if (CustomLabel == ""){
                text(Label,size=TextSize,halign="center",valign="center");
            }else{
                text(CustomLabel,size=TextSize,halign="center",valign="center");
            }
        }
    }
}