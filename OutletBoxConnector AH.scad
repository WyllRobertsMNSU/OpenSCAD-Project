
columnsOfOutlets = 1; // [1:100]
rowsOfOutlets = 1;    // [1:100]
clearance = 1;        // [1:3]

/*[Frame Settings]*/
frameWidth = 4;        // [2:10]
frameThickness = 3;    // [1:8]
cornerRadius = 3;      // [0:8]

/*[Rod Settings]*/
rodRadius = 1.7;
rodHeight = 3;         // Height of rod center above the frame
supportRadius = 1.2;   // Thickness of the attachment bars
supportSpacing = 38;   // Approximate maximum spacing between supports

/*[Hidden]*/
$fn = 48;
plugWidth = 38;
plugHeight = 38;
innerWidth = plugWidth * columnsOfOutlets;
innerHeight = plugHeight * rowsOfOutlets;
outerWidth = innerWidth + 2 * frameWidth;
outerHeight = innerHeight + 2 * frameWidth;
corner = min(cornerRadius, frameWidth, outerWidth/2, outerHeight/2);
rodLength = outerWidth;
supportCount = max(2, ceil(rodLength / supportSpacing) + 1);

// Rounded rectangle profile, extruded to form a low frame.
module roundedRect2D(w, h, r) {
    if (r <= 0)
        square([w, h], center=true);
    else
        offset(r=r)
            square([w - 2*r, h - 2*r], center=true);
}

module OutletFrame() {
    difference() {
        linear_extrude(height=frameThickness, center=true)
            roundedRect2D(outerWidth, outerHeight, corner);
        linear_extrude(height=frameThickness + 0.2, center=true)
            roundedRect2D(innerWidth, innerHeight, max(0, corner - frameWidth));
    }
}


module HingeRod() {
    translate([0, outerHeight/2-2, rodHeight + frameThickness/2])
        rotate([0, 90, 0])
            cylinder(h=rodLength, r=rodRadius, center=true);
}

module AttachmentBars() {
    for (i = [0 : supportCount - 1]) {
        x = -rodLength/2 + i * rodLength/(supportCount - 1);
        hull() {
            translate([x, outerHeight/2 - frameWidth/2, frameThickness/2 - 0.2])
                cylinder(h=0.8, r=supportRadius, center=true);
            translate([x, outerHeight/2 - rodRadius, rodHeight + frameThickness/2])
                rotate([90, 0, 0])
                    cylinder(h=0.8, r=supportRadius, center=true);
        }
    }
}

rotate([90,90,0]) {
union() {
    OutletFrame();
    HingeRod();
    AttachmentBars();
} }
