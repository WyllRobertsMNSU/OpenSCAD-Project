

//Number of columns of outlets, mm
columnsOfOutlets = 1; // [1:100]

//Number of rows of outlets, mm
rowsOfOutlets = 1; //[1:100]

//Clearance of the clips to the box, mm
clearance = 1; //[1:3]

/*[Hidden]*/
$fn = 360;
plugDimensions = [38, 38, 1.5];
module HingeClip() {
    difference() {
        difference() {
            cylinder(h = 10, r = 2 + clearance, center = true);
            cylinder(h = 11, r = 1.5 + clearance, center = true);
        }
        translate([0, 2, 0])
            cube([3 + clearance, 4 + clearance, 11], center = true);
    }
}

module CoverTop() {

    difference() {
        // Outer Layer
        difference() {
            cylinder(
                h = plugDimensions[1] * rowsOfOutlets,
                r = plugDimensions[0] * columnsOfOutlets / 2,
                center = true
            );

            translate([
                0,
                plugDimensions[1] * columnsOfOutlets / 2,
                0
            ])
            cube([
                plugDimensions[1] * columnsOfOutlets,
                plugDimensions[1] * columnsOfOutlets,
                2 * rowsOfOutlets * plugDimensions[0] / 2 + .2
            ], center = true);
        }

        // Inner Space
        cylinder(
            h = plugDimensions[1] * rowsOfOutlets - 5,
            r = plugDimensions[0] * columnsOfOutlets / 2 - 5,
            center = true
        );
    }
}

module Cover() {

    difference() {
        CoverTop();

        translate([
            plugDimensions[0] * columnsOfOutlets / 2 + 1.5,
            0,
            0
        ])
        cylinder(
            h = plugDimensions[0] * rowsOfOutlets + 1,
            r = 2 + clearance,
            center = true
        );
    }

    // Create one more hinge clip than the number of rows
    clipCount = rowsOfOutlets + 1;

    for (i = [0 : clipCount - 1]) {

        z =
            (plugDimensions[1] * rowsOfOutlets / 2 - 5)
            - i * (
                (plugDimensions[1] * rowsOfOutlets - 10)
                / (clipCount - 1)
            );

        translate([
            plugDimensions[0] * columnsOfOutlets / 2 + 1.5,
            0,z])
        HingeClip();
    }
}

Cover();