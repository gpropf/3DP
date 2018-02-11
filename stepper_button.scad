$fn =150;

cleanCut = 0.1;
partGap = 0.2;
buttonH = 7;
lobesH = 3;
lobeR = 10;
outerR = 15;
partSeparationDistance = 10;
shaftR = 3;
shaftH = 2.0;
lobeOrbitR = 2;
knobH = 3;
dialR = outerR + 3;
chamferFlare = 0.45;
chamferH = 3.0;
knobVerticalDisplacement = 1.5;
//cutoutScale = 1.05;
cutoutGap = 0.3;
numLobes = 4;
//sphere(r=cutoutGap);
//completeButton(showTogether = true);
completeButton(showTogether = false, numLobes = 6, lobeOrbitR = lobeOrbitR);
//completeButton(showTogether = true, numLobes = 6, lobeOrbitR = lobeOrbitR);

totalKnobHeight = chamferH + shaftH + lobesH + knobH + partGap;

chamferInterference = shaftR + chamferFlare - (shaftR + cutoutGap);
echo ("Chamfer interference thickness:", chamferInterference);


module completeButton(showTogether=false, numLobes = 6, lobeOrbitR = 6) {

     
     buttonBase(cutoutGap=cutoutGap, outerR=outerR,baseH = buttonH, numLobes = numLobes, lobeOrbitR = lobeOrbitR);
  
     // translate([0,0,lobesH+partGap])
     //knob();

     if (showTogether) {
	  translate([0,0,knobVerticalDisplacement]) {
	       lobes(cutoutGap=0, numLobes = numLobes, lobeOrbitR = lobeOrbitR);
	       *lobes(cutoutGap=0, numLobes = numLobes, lobeOrbitR = lobeOrbitR);
	  }
     }
     else {
	  translate([2*outerR + partSeparationDistance,0,totalKnobHeight]) {
	       rotate([0,180,0])
	       	       lobes(cutoutGap=0, numLobes = numLobes, lobeOrbitR = lobeOrbitR);
	  }
     }
     //lobes(lobeR=lobeR,mainR=lobeOrbitR,h=lobesH+partGap);
  
}
//lobes(mainR=4);

module lobes2(cutoutGap = 0, numLobes = 6, lobeOrbitR = 4) {
     angleStep = 360 / numLobes;
     // Chamfer
     for (t = [0:angleStep:360]) {
	  rotate([0,0,t])
	       translate([0,lobeOrbitR,-cutoutGap])
	       cylinder(r=lobeR+cutoutGap, h=lobesH+cleanCut+partGap + 2 * cutoutGap);
     }
}

module lobes(cutoutGap = 0, numLobes = 6, lobeOrbitR = 4) {
     angleStep = 360 / numLobes;
     // Chamfer
     translate([0,0,-cutoutGap])
     cylinder(r1=shaftR+cutoutGap, r2 = shaftR + chamferFlare+cutoutGap, h = chamferH + cleanCut + 2*cutoutGap);

     // Shaft
     translate([0,0,chamferH]) {
	  translate([0,0,-cutoutGap])
	  cylinder(r = shaftR+cutoutGap, h = shaftH + cleanCut + 2 * cutoutGap);

	  
	  translate([0,0,shaftH]) {            
	       // This is the multi-lobed section that
	       // provides the stepping feature.
	       lobes2(cutoutGap = cutoutGap, numLobes = numLobes, lobeOrbitR = lobeOrbitR);
	       
	       // The very top section that you manipulate.
	       translate([0,0,lobesH+partGap-cutoutGap])            
		    cylinder(r = dialR+cutoutGap, h = knobH + 2 * cutoutGap);
	  }
        
     } 
     //}
}
/*
  module knob(outerR = outerR, knobH = 3)
  {
  //scale(2)
  lobes(lobeR=lobeR,mainR=lobeOrbitR,h=lobesH+partGap);
  }

*/

module buttonBase(cutoutGap = 0, numLobes = 6, lobeOrbitR = 4, outerR=15, lobesH = lobesH, baseH = 10) {
     baseH =  chamferH+shaftH+lobesH+knobVerticalDisplacement;
     difference() {
	  
	  // translate([0,0,lobesH-baseH])
	  cylinder (r=outerR,h=baseH);
	  translate([0,0,knobVerticalDisplacement])
	       //scale(cutoutScale)
	       lobes(cutoutGap = cutoutGap, numLobes = numLobes, lobeOrbitR = lobeOrbitR);
	  //      lobes(lobeR=lobeR,mainR=mainR);
     }
     difference() {
	  lobes2(lobeOrbitR = outerR - 3 * (lobeR / 4),h=baseH/2, numLobes = 8 );
	  cylinder (r=outerR/2,h=baseH);
     }
}
