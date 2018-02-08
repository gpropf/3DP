// Sierpinski Cube
// by Gregory Propf, Copyright 2015

xlist = [0,1,2,0,2,0,1,2,0,2,0,2,0,1,2,0,2,0,1,2];
ylist = [0,0,0,1,1,2,2,2,0,0,2,2,0,0,0,1,1,2,2,2];
zlist = [0,0,0,0,0,0,0,0,1,1,1,1,2,2,2,2,2,2,2,2];

// "Club" pattern
//xlist = [0,1,2,1,1,1,1];
//ylist = [1,1,1,0,2,1,1];
//zlist = [1,1,1,1,1,0,2];

//xlist = [0,1,2,0,1,2,0,2,0,0,0,0,0,0,0,0];
//ylist = [0,0,0,0,0,0,0,0,1,2,0,1,2,0,2,0];
//zlist = [0,0,0,2,2,2,1,1,0,0,0,2,2,2,1,1];

scube(25,4);

slop = 0.001;

module placeCube(x,y,z,length,depth) {
    
    translate([length*x,length*y,length*z])
	    scube(length,depth);
		 //echo ("x:",length*x);
}

module scube(length,depth) {
        scubeLength = length / 3;
	if (depth == 1) {
		cube(length+slop,$fn=1);
	}
	else {
        for (i = [0:len(xlist)-1]) {
            //echo (xlist[i]);
            placeCube(xlist[i],ylist[i],zlist[i],scubeLength,depth - 1);
        }
	}
}
