/*
 * Author: PabstMirror
 * Handles the keypad entries from the "Mark" Application
 *
 * Arguments:
 * 0: String version of Keypad entry ["ok","del","1",...] <STRING>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * ["ok"] call ace_microdagr_fnc_appMarkKeypadEntry
 *
 * Public: No
 */
#include "\z\ace\addons\microdagr\functions\script_component.hpp"

private ["_display", "_editText", "_actualPos"];
PARAMS_1(_keypadButton);

disableSerialization;
_display = displayNull;
if (GVAR(currentShowMode) == DISPLAY_MODE_DIALOG) then {
    _display = (uiNamespace getVariable [QGVAR(DialogDisplay), displayNull]);
} else {
    _display = (uiNamespace getVariable [QGVAR(RscTitleDisplay), displayNull]);
};
if (isNull _display) exitWith {ERROR("No Display");};

//--- EDIT

_editText = ctrlText (_display displayCtrl IDC_MODEMARK_CORDSEDIT);

if (GVAR(currentApplicationPage) == APP_MODE_MARK) then {
    switch (_keypadButton) do {
        case ("ok"): {
            if ((count GVAR(newWaypointPosition)) == 0) then {
                _actualPos = [_editText, true] call EFUNC(common,getMapPosFromGrid);
                _actualPos set [2, (getTerrainHeightASL _actualPos)];
                GVAR(newWaypointPosition) = _actualPos;
                [APP_MODE_MARK] call FUNC(saveCurrentAndSetNewMode);
            } else {
                [_editText, GVAR(newWaypointPosition)] call FUNC(deviceAddWaypoint);
                [APP_MODE_WAYPOINTS] call FUNC(saveCurrentAndSetNewMode);
            };
        };
        case ("del"): {
            _editText = _editText select [0, (((count _editText) - 1) max 0)];
            (_display displayCtrl IDC_MODEMARK_CORDSEDIT) ctrlSetText _editText;
            ctrlSetFocus (_display displayCtrl IDC_MODEMARK_CORDSEDIT);
        };
        default {
            _editText = _editText + _keypadButton;
            (_display displayCtrl IDC_MODEMARK_CORDSEDIT) ctrlSetText _editText;
            ctrlSetFocus (_display displayCtrl IDC_MODEMARK_CORDSEDIT);
        };
    };
};

if (GVAR(currentApplicationPage) == APP_MODE_SETUP) then {
    if(GVAR(newGroupName)==0) exitWith {};
    switch (_keypadButton) do {
        case ("ok"): {
            GVAR(settingMarkerName) = _editText;
            GVAR(newGroupName) = 0;
            ACE_player setvariable [QGVAR(transmittingMarkerName), GVAR(settingMarkerName), true];
            [APP_MODE_SETUP] call FUNC(saveCurrentAndSetNewMode);
        };
        default {
            _editText = _editText + _keypadButton;
            (_display displayCtrl IDC_MODEMARK_CORDSEDIT) ctrlSetText _editText;
            ctrlSetFocus (_display displayCtrl IDC_MODEMARK_CORDSEDIT);
        };
    };
};

//--- !EDIT