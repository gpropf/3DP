$fn = 70;
//$fa = 60;

slop = 0.025;

pin_height = 1.66;
width = 46.5;
hole_width = 2.4;
g_shaft_width = hole_width + 1;
step_max_depth = 5.25; 
step_min_depth = 3.75;

//dimple2step_min = 24.75;
dimple2step_min = 25.25;
dimple2step_max = 25.95;
dimple_depth_below_lip = 1.5;
dimple_ball_diameter = 3.0;
mouth_concavity_bottom2top = 21.44;
hole_center2side = 3.0;
hole_center2top = 4.23;
lip2wall = 31.7;
flap_center_offset = 6.45;
flap_thickness = 2.96;



top_rounding_radius = flap_thickness/4;
top_rounding_diameter = flap_thickness/2;
flap_radius = lip2wall-flap_center_offset;
g_clip_extension_length = 5;
g_clip_voffset =5;
g_gap = width/4;
g_spring_overlap_w_shaft = 34.5;
g_clip_holder_overhang = 2;

gap_start = (width-g_gap)/2;

// ============================
// Special Constants
// ============================
root2 = sqrt(2);

// ============================
// Begin code section
// ============================

rotate([0.0,0.0,0.0]) {
translate([13,0,g_clip_voffset])
spring_loop(g_gap*1.3,0.52);

g_shaft2cylinder_clearance = slop*20;
//translate([flap_thickness,(g_gap+g_spring_overlap_w_shaft)/2,-flap_thickness*0.6])
translate([flap_thickness,(g_gap+g_spring_overlap_w_shaft)/2,0])
rotate([90,0,0])
    translate([0,flap_thickness*0.0,0]){
intersection () {
     
spring(g_gap+g_spring_overlap_w_shaft,flap_thickness*1.4,1.3,10800);
   // 
// big cylinder
    
cylinder(r=flap_thickness,h=g_gap+g_spring_overlap_w_shaft);
     }
}
flap();
rotate([90,0,0])
translate([flap_thickness,0,-(gap_start+g_gap/2)])
clip(width,g_gap,4.5,
        
            flap_radius/2,hole_width/2,hole_width,
            0.5);
}


module spring(length,bolt_diameter,spring_wire_diameter=1,twist = 720) {
    
    scale([1,1,1])
linear_extrude(height = length, center = false, convexity = 10, twist=twist)
translate([bolt_diameter/2-spring_wire_diameter, 0, 0])
circle(r = spring_wire_diameter);
        
        //translate([flap_thickness,width/2,0]) 
    //translate([0,width/2,0]) 
    //rotate([90,0,0]) {
        //difference() {
 //       clip_slot(g_gap,hole_width/2);


}


module spring_loop(spring_width,squeze_factor=0.5,clip_extension_length=5) {
    //hull() {
    difference () {
        union() {
    translate([spring_width+g_clip_holder_overhang, 0, -g_clip_voffset+1])
            difference() {
      // Clip holder.'
                union() {
            minkowski() {
    cylinder(r=flap_thickness*0.88,h=g_clip_voffset-1-3);
                sphere(r=1);
            }
            translate([0,0,-1])
            cylinder(r=flap_thickness+0.65,h=(g_clip_voffset+flap_thickness-3)/2-0.8);
        }
            //%text("A",font="Liberation Sans",
           // valign=50);
        }
    /*        
    scale([1,squeze_factor,squeze_factor])
    difference() {
    rotate_extrude(convexity = 10)
translate([spring_width, 0, 0])
circle(r = hole_width/(2*squeze_factor));
        translate([-13-30+flap_thickness-hole_width/2, -g_gap*2, -5])
        
        cube([31,g_gap*4,10]);
        
    }
    */
}
    scale([1,0.35,0.2])
    translate([-35,0,0])

    sphere(r=30);
}/*
union() {
    translate([-13+flap_thickness,-g_gap/2,0])
    sphere(r=flap_thickness/1.5);
    translate([-13+flap_thickness,g_gap/2,0])
    sphere(r=flap_thickness/1.5);
    }
 */   
}


//translate([0,0,flap_thickness])
//rotate([180,0,0])


/*
rotate([90,0,0])
translate([flap_thickness,0,-(gap_start+g_gap/2)])
clip(width,g_gap,4.5,
        
            flap_radius/2,g_shaft_width/2,hole_width,
            0.5);




*/


module clip(width,gap,extension,
            spring_radius,shaft_radius, hole_width,
            scale_factor) {
           translate([0,0,width+pin_height-hole_width/2])
             sphere(r=hole_width/2);   
         // cut the gap in the shaft       
            difference() {
                union(){
             translate([0,0,1])
    cylinder(r=shaft_radius,h=width-2);    
                translate([0,0,-pin_height+hole_width/2])
                    {
                    sphere(r=hole_width/2);
                    cylinder(r=hole_width/2,h=width+pin_height*2-hole_width);
                    }
                }
         translate([0,0,gap_start])
       cylinder(r=shaft_radius,h=gap);
            }
            
            /*
            // elbows
            translate([0,0,gap_start]) {
                
            sphere(r=shaft_radius);
                    rotate([-90,0,0]) 
cylinder(r=shaft_radius,h=extension); 
                
            
            
            // elbows
                translate([0,0,gap]) {
                             rotate([-90,0,0]) 
            cylinder(r=shaft_radius,h=extension);
                    sphere(r=shaft_radius);
   
   
                    
                }
            }
            */
            
            }
        
           

//translate([flap_center_offset,0,0])
              
    module clip_slot(gap,shaft_radius,relief=0) {
        cube([shaft_radius*8,gap+relief
    ,shaft_radius*2+relief]);
        
        
    }
                    
module flap() {
    
    
    module dimple_ball(ball_diameter,ball_depth) {
        hull() {
 cylinder(r=ball_diameter/8,h=ball_depth);
     translate([0,0,0])
        rotate([0,-45,0])
        cylinder(r=ball_diameter/3,h=ball_depth*root2+ball_diameter/3);
            rotate([0,-35,0])
            cylinder(r=ball_diameter/4,h=ball_depth*root2+ball_diameter/4);
       
     sphere(r=ball_diameter/2);
        }
         rotate([0,15,0])
        cylinder(r=ball_diameter/4,h=ball_depth*root2);
     
 }    
    
    
    difference() {
        union() {
      translate([flap_center_offset,0,0])
    intersection() {
        
            cylinder(r=flap_radius,
            h=flap_thickness);
        translate([0,-flap_radius,-slop])
       cube([lip2wall,flap_radius*2,flap_thickness+2*slop]);
    }
    translate([flap_thickness,width/2,0]) 
    //translate([0,width/2,0]) 
    rotate([90,0,0]) {
        //difference() {
 //       clip_slot(g_gap,hole_width/2);

// big cylinder
 cylinder(r=flap_thickness,h=width);
          //  cylinder(r=hole_width/2,h=width);
        //}
    }
    //}
    
    
    
    
    translate([flap_center_offset/2,-width/2,0])
cube([flap_center_offset/2,width,flap_thickness]);
    
      translate([dimple2step_min,0,-dimple_depth_below_lip])
   dimple_ball(dimple_ball_diameter,dimple_depth_below_lip); 
    
   
    
}
union() {
shaft2cylinder_clearance = slop*10;
slot_width = g_shaft_width+shaft2cylinder_clearance*2;
// inner shaft hole
translate([flap_thickness/2-shaft2cylinder_clearance*2,
-(width
-shaft2cylinder_clearance*30)/2,0])

// flap slot for the clip riser arms
cube([slot_width,width
-shaft2cylinder_clearance*30,g_gap]);
translate([flap_thickness,width/2+slop,0]) 
    //translate([0,width/2,0]) 
    rotate([90,0,0]) {
    cylinder(r=g_shaft_width/2+20*slop,h=width+2*slop);
       
    }
}

}
   

    
}
