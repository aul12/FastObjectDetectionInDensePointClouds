$fn=100;


module axis() {
    rotate([90,0,0]) {
        color("black") {
            cylinder(2.1,d=0.7,center=true);
        }
    }
}

module arrow() {
    translate([1.5+3,0,0]) {
        rotate([0,90,0]) {
            cylinder(3,d=0.2,center=true);
        }
    }
    
    translate([1.5+5,0,0]) rotate([0,-90,0]) {
        rotate_extrude() {
            polygon([[0,0],[0,0.5],[0.3,0.5]]);
        }
    }
}

translate([-2.5,-1,0.25]) {
    color("grey") {
        cube([5,2,0.75], false);
    }
}
translate([-2,-1,1]) {
    color("lightblue",0.3) {
        cube([3,2,0.75], false);
    }
    translate([0,0,0.75]) {
        color("grey") {
            cube([3,2,0.1], false);
        }
    }
}

translate([1.8,0,0.35]) {
    axis();
}

translate([-1.8,0,0.35]) {
    axis();
}

color("red") {
    arrow();
}
color("green") translate([-1.8,-1,0]) rotate([0,0,90]) {
    arrow();
}
color("blue") translate([-1.8,0,0]) rotate([0,-90,0]) {
    arrow();
}

translate([5.2,0,0.7]) rotate([90,0,135]) {
    color("black") scale(0.1) {
        text("x");
    }
}
translate([-1.8,4.7-1,0.7]) rotate([90,0,135]) {
    color("black") scale(0.1) {
        text("y");
    }
}
translate([1.5-1.8,0,1.85+1.5+1.3]) rotate([90,0,135]) {
    color("black") scale(0.1) {
        text("z");
    }
}

echo($vpd);
echo($vpr);
echo($vpt);
$vpr=[70,0,135];