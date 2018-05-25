$fn =150;

cleanCut = 0.1;
partGap = 0.2;
buttonH = 7;
lobesH = 3;
lobeR = 10;
outerR = 14;
partSeparationDistance = 15;
shaftR = 3;
shaftH = 4.0;
lobeOrbitR = 8;
knobH = 3;
dialR = outerR + 3;
chamferFlare = 0.45;
//chamferFlare = 0;
chamferTaper = 0.5;
chamferH = 1.0;
knobVerticalDisplacement = 1.5;
//cutoutScale = 1.05;
partClearance = 0.3;
camClearance = 0.1;
numLobes = 6;
flexbarGap = 1;
//
flexbarXAdjustment = 1;
flexbarFollowHeight = -0.0; // How high above the lowest point on the teeth should the follower be.
fudgeFactor = 0.001;


productionPositions = true;
//productionPositions = false;

sideAngle = 360/numLobes;
//sphere(r=partClearance);
//completeButton(showTogether = true);
//completeButton(showTogether = true, numLobes = 6, lobeOrbitR = lobeOrbitR);

axleR = 4.5;
ratchetR = 6;

toothAngle = 30;
toothHeight = 1.5;


completeButton(showTogether = false, numLobes = 6, lobeOrbitR = lobeOrbitR);
//completeButton(showTogether = true, numLobes = 6, lobeOrbitR = lobeOrbitR);
//cylinder(r=axleR,h=lobesH,$fa=(360/numLobes));

//

totalKnobHeight = chamferH + shaftH + lobesH + knobH + partGap;


chamferInterference = shaftR + chamferFlare - (shaftR + partClearance);
echo ("Chamfer interference thickness:", chamferInterference);

//translate([70,0,0])
//ratchet();


module ratchet() {
     angleStep = toothAngle;
     for (t = [0:angleStep:360]) {
	  rotate([0,0,t])

     
	       linear_extrude(height = lobesH) {
	       polygon(points=[[0,0],[0,ratchetR],[sin(toothAngle)*(ratchetR+toothHeight)+cleanCut,cos(toothAngle)*(ratchetR+toothHeight)]]);
	  }
     }
}



module slipLock(flexbarL=10,flexbarW=2,flexbarH=2,flexbarGap=0,partClearance=0, axleR=0,h = 0, numSides = 0) {
   
    // %ratchet();
     angleStep = 360/numSides;
     flexbarR = (ratchetR+flexbarFollowHeight+toothHeight)*cos(sideAngle/2);
     for (angle = [0:angleStep:360]) {
	 
	       rotate([0,0,angle]) {
		    translate([flexbarXAdjustment,flexbarR,flexbarGap]) {
			 difference (){
			      cube([flexbarL,flexbarW,flexbarH-flexbarGap]);
			      /* rotate([65,0,0])
				   translate([-cleanCut/2,0,0])
				   cube([flexbarL+cleanCut,flexbarW*5,flexbarH-flexbarGap]);
				   */
			 }
		    }
	       }
     }
     difference() {
	  cylinder(r=outerR, h = flexbarH);
	  translate([0,0,-cleanCut/2])
	       cylinder(r=outerR * 0.8, h = flexbarH+cleanCut);
     }
   
}


module completeButton(showTogether=false, numLobes = 6, lobeOrbitR = 6) {

     
     buttonBase(partClearance=partClearance, outerR=outerR,baseH = buttonH, numLobes = numLobes, lobeOrbitR = lobeOrbitR);
  
     // translate([0,0,lobesH+partGap])
     //knob();

     if (showTogether) {
	  translate([0,0,knobVerticalDisplacement]) {
	       lobes(partClearance=0, numLobes = numLobes, lobeOrbitR = lobeOrbitR);
	       *lobes(partClearance=0, numLobes = numLobes, lobeOrbitR = lobeOrbitR);
	  }
     }
     else {
	  xOffset = 0;
	  zOffset = 0;
	  if (productionPositions) {
	        translate([2*outerR + partSeparationDistance,0,totalKnobHeight])
	       rotate([0,180,0])
		    lobes(partClearance=0, numLobes = numLobes, lobeOrbitR = lobeOrbitR);	     	       
	  }
	  else {
	          translate([2*outerR + partSeparationDistance,0,knobVerticalDisplacement])
//	       rotate([0,180,0])
	   		    lobes(partClearance=0, numLobes = numLobes, lobeOrbitR = lobeOrbitR);
	  }
//	  translate([xOffset,0,zOffset]) {
//	       rotate([0,180,0])

//	  }

     }
     //lobes(lobeR=lobeR,mainR=lobeOrbitR,h=lobesH+partGap);
  
}
//lobes(mainR=4);

module lobes2(partClearance = 0, numLobes = 6, lobeOrbitR = 4, lobeR = 0) {
     angleStep = 360 / numLobes;
     // Chamfer
     for (t = [0:angleStep:360]) {
	  rotate([0,0,t])
	       translate([0,lobeOrbitR,-partClearance])
	       cylinder(r=lobeR+partClearance, h=lobesH+cleanCut+partGap + 2 * partClearance);
     }
}


module stepperCam(lobesH = 0, axleR = 0)
{

      ratchet();
/*     linear_extrude(height=lobesH+partGap, scale=[1,1], slices=20, twist=0)
	  polygon([ for (a = [sideAngle/2 : sideAngle : 359]) [ axleR * sin(a), axleR * cos(a) ] ]);
	  */
}

module lobes(partClearance = 0, numLobes = 6, lobeOrbitR = 4) {
     angleStep = 360 / numLobes;
     // Chamfer
     translate([0,0,-partClearance])
     cylinder(r1=shaftR+partClearance-chamferTaper, r2 = shaftR + chamferFlare+partClearance, h = chamferH + cleanCut + 2*partClearance);

     // Shaft
     translate([0,0,chamferH]) {
	  translate([0,0,-partClearance])
	  cylinder(r = shaftR+partClearance, h = shaftH + cleanCut + 2 * partClearance);

	  
	  translate([0,0,shaftH]) {            
	       // This is the multi-lobed section that
	       // provides the stepping feature.
//	       lobes2(partClearance = partClearance, numLobes = numLobes, lobeOrbitR = lobeOrbitR);
	      stepperCam(lobesH = lobesH, axleR = axleR);
	      
	       // The very top section that you manipulate.
	       translate([0,0,lobesH+partGap-partClearance])
		    lobes2(partClearance = 0, numLobes = 4, lobeOrbitR = 8, lobeR = lobeR);
//		    cylinder(r = dialR+partClearance, h = knobH + 2 * partClearance);
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

module buttonBase(partClearance = 0, numLobes = 6, lobeOrbitR = 4, outerR=15, lobesH = lobesH, baseH = 10) {
     baseH =  chamferH+shaftH+knobVerticalDisplacement-0.0;
     difference() {
	  
	  // translate([0,0,lobesH-baseH])
	  cylinder (r=outerR,h=baseH);
	  union() {

	       translate([0,0,knobVerticalDisplacement+fudgeFactor])
		    //scale(cutoutScale)
		    lobes(partClearance = partClearance, numLobes = numLobes, lobeOrbitR = lobeOrbitR);
	       translate([0,0,baseH-chamferH*1.2])
		    /* This is a little "sink" for the shaft to allow me to properly
		    // align the teeth and ratchet followers before squeezing
		    // everything together. It's to prevent the followers from being
		    // crushed during that process.
		    */
		    //scale(cutoutScale)
		    cylinder (r=shaftR+chamferFlare*2+partClearance,h=chamferH*2+cleanCut);
	
	  }
	  //      lobes(lobeR=lobeR,mainR=mainR);
     }
     translate([0,0,baseH]) {
	  slipLock(flexbarL=9,flexbarW=1.5,flexbarH=lobesH,flexbarGap=flexbarGap,partClearance=0,axleR=axleR+camClearance,h=lobesH,numSides=3);
	  //stepperCam(lobesH = lobesH, axleR = axleR);
     }
     difference() {
	  lobes2(lobeOrbitR = lobeOrbitR,h=baseH/2, numLobes = 4 ,lobeR = lobeR);
	  cylinder (r=outerR/2,h=baseH);
     }
}
