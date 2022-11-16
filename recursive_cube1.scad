$fn = 50;
pl = 50; pw =4; ph = pl/8;
plank = [pl,pw,ph];
wn = 1;
corner_radius = 2;
corner_cylinder_height = 8;

s2 = sqrt(2 - 2 * sqrt(2) + 1);
echo ("s2: ", s2);
s3 = 1 - 1/sqrt(2);
echo ("s3: ", s3);

module face(r) {
    module plank() {        
        cube(plank);
    }
    intersection() {
        union() {
            plank();
            translate([pw,0,0])
                rotate([0,0,90])
                    plank();
            translate([pl,0,0])
                rotate([0,0,90])
                    plank();
            translate([0,pl-pw,0])
                plank();
            rotate([0,0,45])
                translate([0,-pw/2,0]) {
                plank();   
                translate([pl,-pl/2,ph*s2*0]) rotate([0,0,90]) plank();
                if (r > 0) {
                    translate([(1-s2)*pl,pw/2,0]) scale(s2) face(r-1);
                    translate([(1-s2)*pl,-s2*pl*0+pw/2,0]) scale(s2) rotate([0,0,270]) face(r-1);
                    //translate([pl,-pl*s3/2+pw/2,0]) scale(s3) rotate([0,0,0]) %face(r-1);
                    translate([pl-0.1,pw/2,0]) scale(s3) rotate([0,0,-45]) face(r-1);
                        //translate([(1-s2)*pl,-s2*pl,0]) rotate([0,0,0]) scale(s2) face(r-1);
                }
            }
        }
        translate([corner_radius,corner_radius,-corner_cylinder_height])
        minkowski() {
            cube([pl-2*corner_radius,pl-2*corner_radius,ph]);
            cylinder(r=corner_radius, h=corner_cylinder_height, center=true);
        }
    }
}


module rounded_cube(side,corner_radius) {
    minkowski() {
        cube(side-corner_radius);
        sphere(corner_radius);
    }
}

module waffle_face(n) {
    face(n);
    translate([pl,0,0])
        rotate([0,0,90])
            face(n);
    translate([pl,pl,0])
        rotate([0,0,180])
            face(n);
    translate([0,pl,0])
        rotate([0,0,270])
            face(n);
}




module waffle_cube(wn) {
    intersection() {
        
        translate([ph,ph,ph])
            rounded_cube(pl-ph,ph);

        union() {
            translate([0,0,ph])    
                scale([1,1,-1])
                    waffle_face(wn);
            
            translate([0,0,pl-ph])    
                waffle_face(wn);
                
            translate([0,ph,0])
                rotate([90,0,0])
                    waffle_face(wn);

            translate([0,pl-ph,pl])
                rotate([270,0,0])
                    waffle_face(wn);

            translate([pl-ph,0,pl])
                rotate([0,90,0])
                    waffle_face(wn);
                
            translate([ph,0,pl])
                rotate([0,90,0])
                    scale([1,1,-1])
                        waffle_face(wn);
        }    
        
    }
}

waffle_cube(wn);
