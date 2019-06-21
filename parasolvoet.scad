h=15;
translate([-5,5,20]) rotate([0,180,0]) voet(h);

module voet(h){
difference(){
union(){
translate([0,0,0]) roundedCube([43,43,h],r=1);
translate([-5/2,-5/2,h]) roundedCube([48,48,5],r=1);
//translate([(-7/2)+(35/3),(-7/2)+(35/3),h+5]) #text("PAR");
}
translate([5/2,5/2,-2]) roundedCube([38,38,h+1],r=1);
}

}

module roundedCube(dim, r=1, x=false, y=false, z=true, xcorners=[true,true,true,true], ycorners=[true,true,true,true], zcorners=[true,true,true,true], $fn=128)
{
	difference()
	{
		cube(dim);

		if(z)
		{
			translate([0, 0, -0.1])
			{
				if(zcorners[0])
					translate([0, dim[1]-r]) { rotateAround([0, 0, 90], [r/2, r/2, 0]) { meniscus(h=dim[2], r=r, fn=$fn); } }
				if(zcorners[1])
					translate([dim[0]-r, dim[1]-r]) { meniscus(h=dim[2], r=r, fn=$fn); }
				if(zcorners[2])
					translate([dim[0]-r, 0]) { rotateAround([0, 0, -90], [r/2, r/2, 0]) { meniscus(h=dim[2], r=r, fn=$fn); } }
				if(zcorners[3])
					rotateAround([0, 0, -180], [r/2, r/2, 0]) { meniscus(h=dim[2], r=r, fn=$fn); }
			}
		}

		if(y)
		{
			translate([0, -0.1, 0])
			{
				if(ycorners[0])
					translate([0, 0, dim[2]-r]) { rotateAround([0, 180, 0], [r/2, 0, r/2]) { rotateAround([-90, 0, 0], [0, r/2, r/2]) { meniscus(h=dim[1], r=r); } } }
				if(ycorners[1])
					translate([dim[0]-r, 0, dim[2]-r]) { rotateAround([0, -90, 0], [r/2, 0, r/2]) { rotateAround([-90, 0, 0], [0, r/2, r/2]) { meniscus(h=dim[1], r=r); } } }
				if(ycorners[2])
					translate([dim[0]-r, 0]) { rotateAround([-90, 0, 0], [0, r/2, r/2]) { meniscus(h=dim[1], r=r); } }
				if(ycorners[3])
					rotateAround([0, 90, 0], [r/2, 0, r/2]) { rotateAround([-90, 0, 0], [0, r/2, r/2]) { meniscus(h=dim[1], r=r); } }
			}
		}

		if(x)
		{
			translate([-0.1, 0, 0])
			{
				if(xcorners[0])
					translate([0, dim[1]-r]) { rotateAround([0, 90, 0], [r/2, 0, r/2]) { meniscus(h=dim[1], r=r); } }
				if(xcorners[1])
					translate([0, dim[1]-r, dim[2]-r]) { rotateAround([90, 0, 0], [0, r/2, r/2]) { rotateAround([0, 90, 0], [r/2, 0, r/2]) { meniscus(h=dim[1], r=r); } } }
				if(xcorners[2])
					translate([0, 0, dim[2]-r]) { rotateAround([180, 0, 0], [0, r/2, r/2]) { rotateAround([0, 90, 0], [r/2, 0, r/2]) { meniscus(h=dim[1], r=r); } } }
				if(xcorners[3])
					rotateAround([-90, 0, 0], [0, r/2, r/2]) { rotateAround([0, 90, 0], [r/2, 0, r/2]) { meniscus(h=dim[1], r=r); } }
			}
		}
	}
}

module meniscus(h, r, fn=128)
{
	$fn=fn;

	difference()
	{
		cube([r+0.2, r+0.2, h+0.2]);
		translate([0, 0, -0.1]) { cylinder(h=h+0.4, r=r); }
	}
}

module rotateAround(a, v) { translate(v) { rotate(a) { translate(-v) { children(); } } } }
