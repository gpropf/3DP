$fn=50;
/*
Turn $fn up to 150 for high res image (and 
print?). It takes FOREVER to render though.
*/


//die2sides(20,0.95);
rotate([0,90,0])
translate ([0.5*radius,0,0])
  die2sidesMinkowski(20,0.95,3);


module die2sides(radius,clipFactor) {
    intersection() {
        rotate([0,90,0]) cylinder(r=radius*clipFactor,h=radius*2,center=true);
    translate ([-0.15*radius,0,0])
    intersection() {
       // rotate([0,0,90])
        
translate ([0.3*radius,0,0]) sphere (r=radius);
        translate ([0,0,0]) sphere (r=radius);
    }
  }
}

 

module die2sidesMinkowski(radius,clipRadius,minkowskiRadius) {
    // Printed this one 11-15-2017 using slic3r
    // args were: 20,0.95,3
    translate ([-0.15*radius,0,0])
      minkowski() {
        intersection() {
        translate ([0.3*radius,0,0]) sphere (r=radius);
        translate ([0,0,0]) sphere (r=radius);
      }
      rotate([0,90,0]) cylinder(r=minkowskiRadius,h=1,center=true);
    }
}