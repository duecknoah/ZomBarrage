///scr_isInteractable(inst);
// Checks if the specified entity is currently interactable
// Returns
// 0 = not an interactable object
// 1 = interactable, but locked
// 2 = interactable, not locked
var _inst = argument0;

if (object_is_ancestor(_inst.object_index, obj_interactableP)) {
    if (_inst.isLocked) {
        return 1;
    }
    else {
        return 2;
    }
}
else {
    return 0;
}
