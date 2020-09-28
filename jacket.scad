use <./openscad_modules/modules/RoundedRectangle.scad>
use <./openscad_modules/modules/DiamondColumns.scad>
use <./openscad_modules/modules/Pipe.scad>



x_inner = 44;
y_inner = 25;
z_inner = 120;
t = 1.5;
RESOLUTION = 100;


difference() {
    RoundedRectangle(x=x_inner+t*2, y=z_inner+t*2+10, thickness=y_inner+t*2, r=10, $fn=RESOLUTION);
    translate([t, t, t])
        RoundedRectangle(x=x_inner, y=z_inner+10, thickness=y_inner, r=10, $fn=RESOLUTION);
    
    translate([0, z_inner+t, 0])
        cube([x_inner+t*2, y_inner+t*2, y_inner+t*2]);
    
    
    // graves
    translate([0, 100, y_inner/2+t])
        rotate([0, 90, 0]) 
            hull() {
                cylinder(r=6, h=z_inner*2, $fn=RESOLUTION);
                translate([0, 30, 0])
                    cylinder(r=6, h=z_inner*2, $fn=RESOLUTION);
            }
            
    // mount hole
    translate([0, z_inner/2+t-20/3, 0]) {
        cube([5+t, 20, 4]);
        translate([x_inner-5+t, 0, 0])
            cube([5+t, 20, 4]);
    }
    
    // design
    translate([0, 0, y_inner+t*2-0.5])
        surface();
    mirror([0, 0, 1])
        translate([0, 0, -0.5])
            surface();
}

module surface() {
    difference() {
        translate([2, 8, 0])
            DiamondColumns(num_x=4, num_y=18, h=3, r_hole_max=2.5);
        translate([x_inner/2+t, z_inner/2+t, 0])
            Pipe(r_outer=18, r_inner=12, h=t, $fn=RESOLUTION);
    }
}