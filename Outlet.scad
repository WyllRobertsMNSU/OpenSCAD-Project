/*Outlet settings*/
outletWidth = 40;
outletHeight = 40;
outletThickness = 3;
holeRadius = outletWidth / 13.333333333333;

module outlet(w, t, h) {
    difference() {
        cube([w, t, h], center=true);
        translate([-w/5, 0, h/5]) {
            cube([(h/6) / 2, t*2, h/3.5], center=true);
        }
        translate([w/5, 0, h/5]) {
            cube([(h/6) / 2, t*2, h/3.5], center=true);
        }
        translate([0, 0, -h/6]) {
            difference() {
                rotate([90, 0, 0]) {
                    cylinder(h=t*2, r=holeRadius, center=true, $fn=50);
                }
                translate([-holeRadius, -t, (-holeRadius *2) - 1]) {
                    cube([holeRadius * 2, t*2, holeRadius * 2]);
                }
            }   
        }   
        
    }
}

for(i = [0:4]) {
    translate([outletWidth * i, 0, 0])
        outlet(outletWidth, outletThickness, outletHeight);

}