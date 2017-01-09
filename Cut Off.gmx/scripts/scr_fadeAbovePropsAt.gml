///scr_fadeAbovePropsAt(x, y);
// this fades props at the specified location to see whats behind it.
// use in a step event of a player or as a way to reveal
// something behind a wall

var _x = argument0;
var _y = argument1;
var fadeOnlyWhenCoordsAbove = argument2; // fade only when _y coordinate is above the props y, this disregards if coords are colliding with the prop

/// Fade out if player is behind this
var props = scr_getPropsAt(_x, _y);
var propAmt = ds_list_size(props);

// Loop through props applying alpha changes when behind it
for (var i = 0; i < propAmt; i ++) {
    with (props[| i]) {
        if (_y > y && _y < y + (sprite_get_height(sprite_index) * image_yscale)
        && _x > x && _x < x + (sprite_get_width(sprite_index) * image_xscale)) {
            // fade out and make this transparent
            image_alpha = 0.25;
        }
        else {
            image_alpha = 1;
        }
    }
}

ds_list_destroy(props);