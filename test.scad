$fn=40;
module radial_groove(height, depth, radius) {
    cylinder(h=height/2, r1=radius, r2=radius+depth);
    translate([0,0,height/2 - 0.01])
    cylinder(h=height/2, r1=radius+depth, r2=radius);
}

module vertical_groove(height, width, depth, radius) {
    translate([0, radius, 0])
    linear_extrude(height)
    polygon(points=[[-width/2,0], [0, depth], [width/2, 0], [width/2, -2], [-width/2, -2]]); 
}

 module radial_groove_angle(width, depth, angle, radius) {
     rotate_extrude(angle=angle)
     polygon(points=[[radius, -width/2], [depth+radius, 0], [radius, width/2], [radius-2, width/2], [radius-2, -width/2]]); 
 }


difference() {
cube(10);

    translate([0,0,5]) 
    radial_groove(2, 1, 5);
    
    translate([0,0,-0.01])
    cylinder(h=100, r=5);
    
    translate([0,0,1])
    rotate([0,0,-50])
    vertical_groove(10, 2, 1, 5);
    
    rotate([0,0,5])
    translate([0, 0, 4])
    radial_groove_angle(2, 1, 20, 5);
}



