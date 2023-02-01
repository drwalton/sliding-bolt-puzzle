/*
 * V1 of Sliding Bolt Puzzle Box
 * Puzzle box that uses a sliding bolt.
 * Use the render_* variables to control which parts of the box are rendered to STL.
 * I recommend printing the outer box as two separate sides and glueing together.
 * When printed with the flat side down no supports should be required.
 * The inner part of the box can be printed vertically in one piece.
 * For the bolt I used a short length of 3mm diameter copper rod, cut to length and filed
 * to smooth out the ends.
 * If using a different diameter please change post_diameter accordingly.
 * Change angles array to control where the cutouts are placed in the outer box.
 */

inner_box_diameter = 15;
inner_box_wall_thickness = 2;
inner_box_base_height = 5;

post_offset_from_top = 5;

outer_box_diameter = 29;
outer_box_top_thickness = 5;
box_tolerance = 0.5;

post_diameter = 3;
post_tolerance = 0.5;

maze_track_depth = 3;
maze_track_width = post_diameter+post_tolerance;

num_tracks = 10;

maze_height = (num_tracks * 2 + 1) * maze_track_width + post_offset_from_top;

eps = 0.01;
big = 100;

$fn=40;

render_all = false;
render_side_0 = true;
render_side_1 = false;
render_inner = true;

hole_angles = [
45, 
-45, -135,
-225, -60,
30, 150,
240, 30,
-60, -240,
-150, 135,
45, -135,
-225, -30,
60, -150,
-60
];
hole_heights = [0, 
1, 1,
2, 2,
3, 3,
4, 4,
5, 5,
6, 6,
7, 7,
8, 8, 
9, 9,
10
];

blocker_angles = [];
blocker_heights = [];

// The inner box

translate([40, 0, 0])
difference() {
    union() {
        cylinder(h=inner_box_base_height, d=outer_box_diameter, $fn=6);
        
        translate([0, 0, inner_box_base_height])
        difference() {
            cylinder(maze_height, d=inner_box_diameter);
            cylinder(maze_height + eps, d=inner_box_diameter - 2*inner_box_wall_thickness);
            
            
            translate([0, big/2, maze_height - post_offset_from_top])
            rotate([90, 0, 0])
            cylinder(h=big, d=post_diameter+post_tolerance);
            
            
            translate([-big/2, 0, maze_height - post_offset_from_top -2*maze_track_width])
            rotate([0, 90, 0])
            cylinder(h=big, d=post_diameter+post_tolerance);
        }
    }
    if(!render_inner && !render_all) {
        translate([-big/2, -big/2, -eps])
        cube([big, big, big]);
    }
}


// The outer box
difference() {
    difference() {
        union() {
            difference() {
                // Outer hexagonal prism
                cylinder(h=maze_height + outer_box_top_thickness, d=outer_box_diameter, $fn=6);
                
                // Rings 
                for(i = [0:num_tracks]) {
                    translate([0,0,(1 + 2*i)*maze_track_width])
                    cylinder(h=maze_track_width, d=inner_box_diameter + box_tolerance + 2*maze_track_depth);
                }
            }
            
            translate([0,0,(maze_height+maze_track_width)/2])
            cube([inner_box_diameter+2*maze_track_depth+box_tolerance, 2, maze_height+maze_track_width/2], center=true);
            
            translate([0,0,(maze_height+maze_track_width)/2 + maze_track_width])
            rotate([0,0,90])
            cube([inner_box_diameter+2*maze_track_depth+box_tolerance, 2, maze_height+maze_track_width/2 - 2*maze_track_width], center=true);
        }       
        
        for(i = [0:len(hole_heights)-1]) {
            rotate([0,0,hole_angles[i]])
            translate([0,maze_track_depth/2,hole_heights[i]*maze_track_width*2 + maze_track_width/2-eps])
            cube([maze_track_width+post_tolerance, inner_box_diameter+maze_track_depth+box_tolerance/2, maze_track_width+3*eps], center=true);
        }
        
        translate([0,0,-eps])
            cylinder(h=maze_height + maze_track_width, d=inner_box_diameter + box_tolerance);
        
    }
    if(render_all) {
        
    }else if(render_side_0) {
        translate([-big/2, 0, -eps])
        cube([big, big, big]);
    }
    else if(render_side_1) {
        translate([-big/2, -big, -eps])
        cube([big, big, big]);
    } else {
        translate([-big/2, -big/2, -eps])
        cube([big, big, big]);
    }
}
