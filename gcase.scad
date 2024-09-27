


carrier_x = 78;
carrier_y = 134;
carrier_z = 16;
c_spacer = 5;
c_rib    = 5;
c_notch  = 8;
c_notchsize = 5;
wallsize = 7;
walloffset = wallsize - c_notchsize + (c_notchsize / 2);
box_x = carrier_x + (2 * wallsize);
box_y = carrier_y - 1;
box_z = (carrier_z * 8) + (c_spacer * 8) + (2 * wallsize);

module drive()
{
    translate([carrier_z,0,0]) rotate([0,-90,0]) cube([carrier_x,carrier_y,carrier_z]);
    translate([c_notch,carrier_z/2,carrier_x]) cylinder(r=c_notchsize/2,h=4);
}

module drive_array()
{
  ribcutout = carrier_x - (2 * c_rib);
  for (i = [0 : 1 : 7]){
      xpos = (c_spacer * i) + (carrier_z * i) + c_spacer;
      translate([xpos,0,0])  drive();
      translate([xpos-5,0,c_rib]) cube([c_rib,carrier_y,ribcutout]);
      }
 xpos = (c_spacer * 9) + (carrier_z * 8); 
 translate([xpos-5,0,c_rib]) cube([c_rib,carrier_y,ribcutout]);     
}


module gcase()
{
    difference(){
      translate([0,carrier_y,0]) rotate([0,-90,-180]) cube([box_x,box_y,box_z]);
      translate([walloffset,0,walloffset+c_notchsize/2]) drive_array();
      }
}

gcase();
//drive_array();