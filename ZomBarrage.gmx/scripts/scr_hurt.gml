///scr_hurt(id, amt);
// will hurt the specified entity (id) by <amt> damage
// returns the damage that was actually dealt, ex:
//  zombie health = 2
//  bullet damage = 5
// if bullet damage > zombie health
// then damage dealt = zombie health
// else damage dealt = bullet damage
// so the damage dealt here would be 2

_id = argument0;
amt = argument1;
dmgDealt = 0; // damage dealt

with (_id) {
    // Calculate actual damage dealt, see explanation above
    if (other.amt > hp) {
        other.dmgDealt = hp;
    }
    else {
        other.dmgDealt = other.amt;
    }
    hp -= other.dmgDealt;
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

scr_createBloodSpurtBurst(_id.x, _id.y, amt);

// Create gore based on object_index of the character
switch (_id.object_index) {
    case obj_zombie:
        scr_createZombieGoreBurst(_id.x, _id.y, ceil(clamp(amt / 4, 0, 58)));
    break;
    case obj_runnerZombie:
        scr_createRunnerZombieGoreBurst(_id.x, _id.y, ceil(clamp(amt / 4, 0, 58)));
    break;
    default: 
        scr_createZombieGoreBurst(_id.x, _id.y, ceil(clamp(amt / 4, 0, 58)));
}

return dmgDealt; // return the damage actually dealt