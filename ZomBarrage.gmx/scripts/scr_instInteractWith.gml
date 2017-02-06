///scr_instPutInVehicle(inst, vehicle);
// interacts with the specified instance
var _inst = argument0; // the instance
var _interactInst = argument1; // the instance to interact with

_inst.interactEntity = _interactInst; // make inst interact with the interact instance
_interactInst.interactEntity = _inst; // make the interact instance interact with the instance
