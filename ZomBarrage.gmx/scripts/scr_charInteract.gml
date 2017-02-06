///scr_charInteract(inst, interactInst);
// makes character interact with the specified instance (ex. chair, vehicle)
var _char = argument0; // the instance
var _interactInst = argument1; // the instance to interact with

// If character is already interacting with some instance 
// or if the interact instance is locked, prevent
// interacting with another one.
if (_char.interactEntity != noone || _interactInst.isLocked) {
    return false;
}

// Make sure that the entity we want this character to
// interact with is not currently being interacted by another
// entity
if (_interactInst.interactEntity == noone) {
    _char.interactEntity = _interactInst; // make character interact with the interact instance
    _interactInst.interactEntity = _char; // make the interact instance interact with the character
    // saves the position where the character was before interacting with this object, 
    // used for getting off at this position in the end
    _interactInst.xPreviousInteractEntity = _char.x;
    _interactInst.yPreviousInteractEntity = _char.y;
    _char.x = _interactInst.x;
    _char.y = _interactInst.y;
}
