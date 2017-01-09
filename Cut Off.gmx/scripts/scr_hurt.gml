///scr_hurt(id, amt);
// will hurt the specified entity (id) by <amt> damage

_id = argument0;
amt = argument1;

var bloodInst;
var goreInst;

bloodInst = instance_create(x, y, obj_bloodSpurt);
goreInst = instance_create(x, y, obj_zombieGore);

with (_id) {
    hp -= other.amt;
    isHurt = true;
    // If a zombie, change current sprite to a one with gore (not include first one with no gore).
    if (object_index == obj_zombie) {
        // Chance of getting sprite change.
        var permGoreSpriteChance = round(random(0));
        if (!isCrawler) {
            if (permGoreSpriteChance == 0) {
                if (image_index == 0) {
                    image_index = round(random_range(1, 7));
                }
            }
        }
        // Have a chance of the zombie turning into a crawler
        var crawlerChance = round(random(5));
        if (hp <= 5 && crawlerChance == 0) {
            isCrawler = true;
        }
    }
}

with (bloodInst) {
    partAmt = other.amt;
}

with (goreInst) {
    partAmt = ceil(clamp(other.amt / 10, 0, 8));
}