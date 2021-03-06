#include "script_component.hpp"
/*
 * Author: SzwedzikPL
 * onEntitiesInArea module exec function
 */

params ["_logic"];
TRACE_1("onEntitiesInArea_moduleExec",_logic);

if (isNull _logic) exitWith {};

if (is3DENPreview) then {
  [_logic, true] call EFUNC(debug,updateModuleStatus);
};

// Change task state
_logic call FUNC(handlerModuleChangeTaskState);

// Play sound
[_logic, false] call FUNC(modulePlaySound);

// Set logic flag value
[_logic, false] call FUNC(moduleSetLogicFlagValue);

// Show message
[_logic, false] call FUNC(moduleShowMessage);

// Show marker
[_logic, false] call FUNC(moduleShowMarker);

// Delete marker
[_logic, false] call FUNC(moduleDeleteMarker);

// Call script handler
if (_logic getVariable [QGVAR(addScriptHandler), false]) then {
  [
    _logic,
    _logic getVariable [QGVAR(handlerObjects), []]
  ] call compile (_logic getVariable [QGVAR(scriptHandler), ""]);
};

// Delete module
deleteVehicle _logic;
