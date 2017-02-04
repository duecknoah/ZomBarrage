///scr_entityMoveTo(x, y, spd, entityToMove, stopJustBefore?);
// This is meant to work on entitys of type: obj_player and obj_civilian
// returns true when at position

var px = argument0; // the final x position
var py = argument1; // the final y position
var spd = argument2; // the speed to move the entity at
var entity = argument3; // the entity to move
var stopJustBefore = argument4; // stop just before the final position?

/// create the path and move to the point

// don't run movement code if movement prevented
if (global.preventEntityMovement) {
    exit;
}

px = (px div obj_navGrid.cell_width)* obj_navGrid.cell_width + (obj_navGrid.cell_width / 2);
py = (py div obj_navGrid.cell_height)* obj_navGrid.cell_height + (obj_navGrid.cell_height / 2);
spd = spd * global.timeScale;

if (global.navUpdateRateTimer == 0) {
    if (!path_exists(entity.path)) {
        entity.path = path_add();
    }    

    // End path and clear self from the path to not see self as a collision and setup new collisions
    path_end();
    mp_grid_clear_cell(global.grid, x div obj_navGrid.cell_width, y div obj_navGrid.cell_height);
    
    // Make a path to the point
    if (mp_grid_path(global.grid, entity.path, entity.x, entity.y, px, py, 1)) {
        // Since able to, Start the path and add a cell where self is going to be net navUpdate,
        // this would prevent other zombies from colliding into this one on next navUpdate.
        if (stopJustBefore) {
            path_delete_point(entity.path, path_get_number(entity.path) - 1);
        }
        path_start(entity.path, spd, 0, false);
        
        // Calc next path pos
        var _nextPoint = (1 / path_get_number(entity.path)) * (entity.path_position + 1);
        var _nextPointX = path_get_x(entity.path, _nextPoint);
        var _nextPointY = path_get_y(entity.path, _nextPoint);
        mp_grid_add_cell(global.grid, _nextPointX div obj_navGrid.cell_width, 
                                      _nextPointY div obj_navGrid.cell_height);
        entity.doBackupPathFinding = false;
    }
    else { 
        entity.doBackupPathFinding = true;
        path_end();
    }
}

if (entity.doBackupPathFinding) {
    // if can't find a path to player, just move towards player directly
    // move_towards_point(px, py, 1);
    
    if (stopJustBefore) {
        if (distance_to_point(px, py) < obj_navGrid.cell_width) {
            exit;
        }
    }
    
    // If heading diagonal, make speed slower
    if (entity.y != py && entity.x != px) {
        spd = (spd / 2) * global.timeScale;
    }
    
    if (entity.x < px) {
        if (!place_meeting(entity.x + spd, entity.y, obj_collision)) {
            entity.x += spd;
        }
    }
    else if (entity.x > px) {
        if (!place_meeting(entity.x - spd, entity.y, obj_collision)) {
            entity.x -= spd;
        }
    }
    if (entity.y < py) {
        if (!place_meeting(entity.x, entity.y + spd, obj_collision)) {
            entity.y += spd;
        }
    }
    else if (entity.y > py) {
        if (!place_meeting(entity.x, entity.y - spd, obj_collision)) {
            entity.y -= spd;
        }
    }
}