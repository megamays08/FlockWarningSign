// --- Configuration & Settings ---
width = 140; 
height = 180; 
thickness = 3;
text_height = 1;
eps = 0.01; 
hole_diameter = 9; 

// --- Text Around Eye ---
// Above Eye Text
eye_text_top = "GOT YOUR LICENSE PLATE?";
// Below Eye Text
eye_text_bottom = "WE DO TOO!";
// Vertical Position of Eye
eye_unit_y = 98.5;

// --- Body Text ---
// Body Line 1
body_line_1 = "THIS IS ONE OF MANY";
// Body Line 2
body_line_2 = "AI-ENABLED CAMERAS";
// Body Line 3
body_line_3 = "TRACKING YOUR VEHICLE";
// Body Line 4
body_line_4 = "EVERYWHERE IT GOES.";
// Starting Height of Body Block
body_y_start = 65;
// Vertical Distance Between Lines
line_spacing = 8;  

// --- Underline Settings ---
// Line 1 Width
u1_width = 56;  
// Line 1 Horizontal Position
u1_x = 16;      
// Line 2 Width
u2_width = 56;  
// Line 2 Horizontal Position
u2_x = -18;     

difference() {
    // --- Main Sign Body ---
    union() {
        color("White")
        cube([width, height, thickness]);

        // --- 1. Upward Arrow ---
        color("Black")
        translate([width/2, height - 20, thickness - eps]) {
            linear_extrude(text_height + eps) {
                translate([-4, -15]) square([8, 15]); 
                polygon(points=[[-12, 0], [12, 0], [0, 12]]); 
            }
        }

        // --- 2. Header Text ---
        color("Black")
        translate([width/2, height - 48, thickness])
            linear_extrude(text_height)
            text("FLOCK CAMERA", size=10, font="Liberation Sans:style=Bold", halign="center", valign="baseline");

        // --- 3. The "Eye Unit" ---
        translate([width/2, eye_unit_y, 0]) {
            color("Black") {
                translate([0, 14, thickness])
                    linear_extrude(text_height)
                    text(eye_text_top, size=6, font="Liberation Sans:style=Bold", halign="center", valign="baseline");

                linear_extrude(thickness + text_height)
                difference() {
                    union() {
                        offset(r = 1, $fn=40) 
                        intersection() {
                            translate([0, -12]) circle(r=20, $fn=100);
                            translate([0, 12]) circle(r=20, $fn=100);
                        }
                        circle(r=6.5, $fn=80);
                    }
                    circle(r=3, $fn=60);
                }

                translate([0, -18, thickness])
                    linear_extrude(text_height)
                    text(eye_text_bottom, size=6, font="Liberation Sans:style=Bold", halign="center", valign="baseline");
            }
        }

        // --- 4. Body Text ---
        color("Black")
        translate([width/2, body_y_start, thickness]) 
            linear_extrude(text_height) {
                
                text(body_line_1, size=6, font="Liberation Sans:style=Bold", halign="center", valign="baseline");
                translate([u1_x, -1.5, 0]) square([u1_width, 0.8], center=true); 

                translate([0, -line_spacing, 0]) 
                    text(body_line_2, size=6, font="Liberation Sans:style=Bold", halign="center", valign="baseline");
                
                translate([0, -(line_spacing*2), 0]) 
                    text(body_line_3, size=6, font="Liberation Sans:style=Bold", halign="center", valign="baseline");
                
                translate([0, -(line_spacing*3), 0]) 
                    text(body_line_4, size=6, font="Liberation Sans:style=Bold", halign="center", valign="baseline");
                
                translate([u2_x, -(line_spacing*3) - 1.5, 0]) 
                    square([u2_width, 0.8], center=true);
            }

        // --- 5. Footer ---
        color("Black") {
            translate([width/2, 22, thickness])
                linear_extrude(text_height)
                text("LEARN MORE AT", size=7, font="Liberation Sans:style=Bold", halign="center", valign="baseline");

            translate([width/2, 10, thickness])
                linear_extrude(text_height)
                text("DEFLOCK.ORG", size=10, font="Liberation Sans:style=Bold", halign="center", valign="baseline");
        }
    }

    // --- 6. Mounting Hole (Top) ---
    translate([width/2, height - 28, -1])
        cylinder(d=hole_diameter, h=thickness + text_height + 5, $fn=60);
}