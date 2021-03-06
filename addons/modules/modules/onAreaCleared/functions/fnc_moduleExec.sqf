#include "script_component.hpp"
/*
 * Author: SzwedzikPL
 * onAreaCleared module exec function
 */

params ["_logic"];
TRACE_1("onAreaCleared_moduleExec",_logic);

if (isNull _logic) exitWith {};

private _condition = _logic getVariable [QGVAR(activationCond), {false}];

if !(_logic call _condition) exitWith {
  TRACE_1("onAreaCleared_moduleExec - abort, area not cleared yet",_logic);
};

if (is3DENPreview) then {
  [_logic, true] call EFUNC(debug,updateModuleStatus);
};

// Cleanup EH & PFH
(_logic getVariable QGVAR(activationEHs)) params ["_killedEH", "_actPFH"];
removeMissionEventHandler ["EntityKilled", _killedEH];
[_actPFH] call CBA_fnc_removePerFrameHandler;

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
  [_logic] call compile (_logic getVariable [QGVAR(scriptHandler), ""]);
};

// Delete module
deleteVehicle _logic;
