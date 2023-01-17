/*
 * V0 of Sliding Bolt Puzzle Box
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

outer_box_diameter = 27;
outer_box_top_thickness = 5;
box_tolerance = 0.5;

post_diameter = 3;
post_tolerance = 0.5;

maze_track_depth = 3;
maze_track_width = post_diameter+post_tolerance;

num_tracks = 10;

maze_height = num_tracks * 2 * maze_track_width + post_offset_from_top;

eps = 0.01;
big = 100;

$fn=40;

render_all = true;
render_side_0 = false;
render_side_1 = false;
render_inner = false;

angles = [0, 110, 200, 45, 60, 130, 150, -10, -20, 160, 110];

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
                cylinder(h=maze_height + outer_box_top_thickness, d=outer_box_diameter, $fn=6);
                
                
                
                for(i = [0:num_tracks]) {
                    translate([0,0,(1 + 2*i)*maze_track_width])
                    cylinder(h=maze_track_width, d=inner_box_diameter + box_tolerance + 2*maze_track_depth);
                }
            }
            
            translate([0,0,(maze_height+maze_track_width)/2])
            cube([inner_box_diameter+2*maze_track_depth+box_tolerance, 2, maze_height+maze_track_width/2], center=true);
        }

        translate([0,0,-eps])
            cylinder(h=maze_height, d=inner_box_diameter + box_tolerance);
        
        
        
        for(i = [0:num_tracks]) {
            rotate([0,0,angles[i]])
            translate([0,maze_track_depth/2,i*maze_track_width*2 + maze_track_width/2-eps])
            cube([maze_track_width+post_tolerance, inner_box_diameter+maze_track_depth+box_tolerance/2, maze_track_width+3*eps], center=true);
        }
        /*
        translate([0,maze_track_width/2,maze_track_depth/2-eps])
        cube([2, inner_box_diameter+maze_track_width+box_tolerance, maze_track_depth+2*eps], center=true);
        
        rotate([0,0,110])
        translate([0,maze_track_width/2,maze_track_width*2 + maze_track_depth/2-eps])
        cube([2, inner_box_diameter+maze_track_width+box_tolerance, maze_track_depth+2*eps], center=true);
        
        rotate([0,0,200])
        translate([0,maze_track_width/2,2*maze_track_width*2 + maze_track_depth/2-eps])
        cube([2, inner_box_diameter+maze_track_width+box_tolerance, maze_track_depth+2*eps], center=true);
        
        rotate([0,0,45])
        translate([0,maze_track_width/2,3*maze_track_width*2 + maze_track_depth/2-eps])
        cube([2, inner_box_diameter+maze_track_width+box_tolerance, maze_track_depth+2*eps], center=true);
        
        rotate([0,0,75])
        translate([0,maze_track_width/2,4*maze_track_width*2 + maze_track_depth/2-eps])
        cube([2, inner_box_diameter+maze_track_width+box_tolerance, maze_track_depth+2*eps], center=true);
        */
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
