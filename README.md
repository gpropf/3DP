# 3DP
My 3D Printing code and data

*This is the stuff I make publicly available on github.*

* Sierpinski.scad: The  [OpenSCAD](http://www.openscad.org/) file for a Sierpinsky cube, also known as the Menger Sponge. By setting the "depth" parameter you can control how many levels of recursion to generate. By changing the "xlist", "ylist", and "zlist" vectors you control which cubes are created and which are not. Basically, the 3 lists together tell the program where to place each cube. There are three possible positions on each axis, 0,1, and 2. I wrote this when I was fairly new to OpenSCAD. I would probably do things differently now. Using a slice through 3 lists to make a position vector is awkward to say the least. I'd like to improve this script a bit and make it a bit more elegant and flexible. The results from printing this were quite nice. Using `scube(20,4)` gives you a nice 20mm cube with the smallest holes still being clear at "fine" resolution (0.2mm). I should have a picture on my website soon.

* twosideddie.scad: I was watching a video by Tadashi https://www.youtube.com/watch?v=zzKGnuvX6IQ&t=21s where he was talking about dice. I got to thinking about how people have made dice with more or less than the usual 6 sides and how to make a "two sided die" that wasn't just a coin. I also wanted a simple shape to test my printer with. I ended up with this odd sort of egg shape. I printed it and polished it a bit with Goof-off (basically a mixture of xylene and acetone). It seems to do the job. Granted a simple squashed sphere would probably work too.

* ninja_flap.scad: The flap on our Ninja model QB1004 broke last year. It was quite annoying to use the thing after that as we had to stuff a rag or something in there to keep things from splashing out. We could have just ordered a new part but I decided to use my micrometer and 3D printing skills to create a replacement part. This one works *really well* except that the little spring mechanism I created to allow it to slide into place doesn't function. Printing machinery in place is always a gamble.

