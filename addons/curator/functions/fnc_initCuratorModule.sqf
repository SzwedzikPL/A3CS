#include "script_component.hpp"
/*
 * Author: SzwedzikPL
 * Handles curator module init on server
 */

params ["_curator"];
TRACE_1("initCuratorModule",_curator);

#ifdef DEBUG_MODE_FULL
private _editable3DENObjects = missionNamespace getVariable [QGVAR(editable3DENObjects), []];
LOG_2("Initing curator module %1 (editable3DENObjects count: %2)",str _curator,str (count _editable3DENObjects));
#endif

_curator addCuratorEditableObjects [allUnits, true];
_curator addCuratorEditableObjects [vehicles, true];
_curator addCuratorEditableObjects [playableUnits, true];
_curator addCuratorEditableObjects [switchableUnits, true];
_curator addCuratorEditableObjects [allPlayers, true];
_curator addCuratorEditableObjects [
  missionNamespace getVariable [QGVAR(editable3DENObjects), []],
  true
];
