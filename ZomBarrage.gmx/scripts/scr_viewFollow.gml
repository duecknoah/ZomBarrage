///scr_viewFollow(x, y, tweenAmount (between 0-1)); 
// view follows the specified object, use self to follow self

var xcoord = argument0;
var ycoord = argument1;
var tweenAmt = argument2;

if (xcoord - (view_wview[0] / 2) < 0) {
    xcoord = 0 + (view_wview[0] / 2);
}
if (xcoord + (view_wview[0] / 2) > room_width) {
    xcoord = room_width - (view_wview[0] / 2);
}
if (ycoord - (view_hview[0] / 2) < 0) {
    ycoord = 0 + (view_hview[0] / 2);
}
if (ycoord + (view_hview[0] / 2) > room_height) {
    ycoord = room_height - (view_hview[0] / 2);
}

view_xview[0] += ((xcoord - view_wview[0] / 2) - view_xview[0]) * tweenAmt;
view_yview[0] += ((ycoord - view_hview[0] / 2) - view_yview[0]) * tweenAmt;