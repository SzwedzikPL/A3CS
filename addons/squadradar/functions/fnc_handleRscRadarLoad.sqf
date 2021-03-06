#include "script_component.hpp"
/*
 * Author: SzwedzikPL
 * Handles RscRadar onLoad event
 */

params ["_display"];

LOG("Loading RscRadar");

uiNamespace setVariable [QGVAR(rscRadar), _display];
private _ctrlRadar = _display displayCtrl IDC_RSCRADAR_RADAR;

// Start drawing radar starting with next frame
_ctrlRadar ctrlAddEventHandler ["draw", DFUNC(drawRadar)];

GVAR(enabled) = true;

LOG("RscRadar loaded");
