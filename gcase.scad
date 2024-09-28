


carrier_x = 78;
carrier_y = 134;
carrier_z = 16;
c_spacer = 4;
c_rib    = 5;
c_notch  = 13;  // Position of snaplock hole - ypos
c_sq     = 8;   // Size of reverse prevent rectangle
c_notchsize = 5;
wallsize = 7;
walloffset = wallsize - c_notchsize + (c_notchsize / 2);

module drive_body()
{
    translate([carrier_z,0,0]) rotate([0,-90,0]) cube([carrier_x,carrier_y,carrier_z]);
    translate([carrier_z/2,c_notch,carrier_x]) cylinder(r=c_notchsize/2,h=4);
}
module drive()
{
    difference(){
      drive_body();
      translate([carrier_z-3,carrier_y-c_sq,0]) cube([3,c_sq,c_spacer]);
      }
}

module drive_box(numdrives)
{
  box_x = carrier_x + (2 * wallsize);
  box_y = carrier_y - .1;
  box_z = (carrier_z * numdrives) + (c_spacer * numdrives) + (2 * wallsize);
  cube([box_x,box_y,box_z]);
}

module drive_array(numdrives)
{
  dmax = numdrives - 1;
  smax = numdrives + 1;
  
  ribcutout = carrier_x - (2 * c_rib);
  for (i = [0 : 1 : dmax]){
      xpos = (c_spacer * i) + (carrier_z * i) + c_spacer;
      translate([xpos,0,0])  drive();
      translate([xpos-5,0,c_rib]) cube([c_rib,carrier_y,ribcutout]);
      }
 xpos = (c_spacer * smax) + (carrier_z * numdrives); 
 translate([xpos-5,0,c_rib]) cube([c_rib,carrier_y,ribcutout]);     
}


module gcase(numdrives)
{
    difference(){
      translate([0,carrier_y,0]) rotate([0,-90,-180]) drive_box(numdrives);
      translate([walloffset,0,walloffset+c_notchsize/2]) drive_array(numdrives);
      }
}

gcase(1);
//drive();