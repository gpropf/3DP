$fn =50;

cleanCut = 0.1;
partGap = 0;
buttonH = 7;
lobesH = 3;
lobeR = 10;
outerR = 20;
shaftR = 3;
shaftH = 3;
lobeOrbitR = 4;
knobH = 3;
chamferFlare = 0.5;
chamferH = 2;
knobVerticalDisplacement = 0;
//cutoutScale = 1.05;
cutoutGap = 0.5;

completeButton();

module completeButton() {
  
     buttonBase(outerR=outerR,baseH = buttonH);
  
     // translate([0,0,lobesH+partGap])
     //knob();
     translate([0,0,knobVerticalDisplacement])
     %lobes(lobeR=lobeR,mainR=lobeOrbitR,h=lobesH+partGap, cutoutGap = 0);
     //lobes(lobeR=lobeR,mainR=lobeOrbitR,h=lobesH+partGap);
  
}
//lobes(mainR=4);

module lobes(lobeR = lobeR, lobeOrbitR = 4, numLobes = 6, h=lobesH, cutoutGap = 0) {
     
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
	       for (t = [0:60:360]) {
		    rotate([0,0,t])
			 translate([0,mainR,-cutoutGap])
			 cylinder(r=lobeR+cutoutGap, h=lobesH+cleanCut+partGap + 2 * cutoutGap);
	       }
	       
	       // The very top section that you manipulate.
	       translate([0,0,lobesH+partGap-cutoutGap])            
		    cylinder(r = outerR+cutoutGap, h = knobH + 2 * cutoutGap);
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

module buttonBase(lobeR = lobeR, mainR = lobeOrbitR, outerR=15,lobesH=lobesH,baseH = 10) {
     difference() {
	  // translate([0,0,lobesH-baseH])
	  cylinder (r=outerR,h=chamferH+shaftH+lobesH);
	  translate([0,0,knobVerticalDisplacement])
	       //scale(cutoutScale)
	       lobes(lobeR=lobeR,mainR=lobeOrbitR,h=lobesH+partGap, cutoutGap = cutoutGap);
	  //      lobes(lobeR=lobeR,mainR=mainR);
     }
     //lobes(lobeR=lobeR,mainR=mainR,h=lobesH+partGap);
}
