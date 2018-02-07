$fn =50;

cleanCut = 0.1;
partGap = 0.2;
buttonH = 7;
lobesH = 3;
lobeR = 10;
outerR = 20;
shaftR = 3;
shaftH = 3;
lobeOrbitR = 4;
knobH = 3;
chamfer = 0.5;
chamferStartH = -0.5;
knobVerticalDisplacement = 0.6;

completeButton();

module completeButton() {
  
  buttonBase(outerR=outerR,baseH = buttonH);
  
  // translate([0,0,lobesH+partGap])
  //knob();
  translate([0,0,10])
  lobes(lobeR=lobeR,mainR=lobeOrbitR,h=lobesH+partGap);
  
}
//lobes(mainR=4);

module lobes(lobeR = lobeR, lobeOrbitR = 4, numLobes = 6, h=lobesH) {
  //hull() {
   cylinder(r = shaftR, h = shaftH+cleanCut);
  translate([0,0,shaftH])  
  for (t = [0:60:360]) {
    
    rotate([0,0,t])
      translate([0,mainR,0])
      cylinder(r=lobeR, h=lobesH+cleanCut+partGap);
  }
  translate([0,0,shaftH+cleanCut+lobesH])
  cylinder(r = outerR, h = knobH);
  translate([0,0,chamferStartH])
    //scale([1,1,0.3])
    cylinder(r1=shaftR, r2 = shaftR + chamfer, h = 2);
   
  //}
}
/*
module knob(outerR = outerR, knobH = 3)
{
  //scale(2)
  lobes(lobeR=lobeR,mainR=lobeOrbitR,h=lobesH+partGap);
}

*/

module buttonBase(lobeR = lobeR, mainR = lobeOrbitR, outerR=15,lobesH=lobesH,baseH = 10) {
  difference() {
    // translate([0,0,lobesH-baseH])
      cylinder (r=outerR,h=baseH);
    translate([0,0,knobVerticalDisplacement])
      scale(1.05)
      lobes(lobeR=lobeR,mainR=lobeOrbitR,h=lobesH+partGap);
    //      lobes(lobeR=lobeR,mainR=mainR);
  }
  //lobes(lobeR=lobeR,mainR=mainR,h=lobesH+partGap);
}
