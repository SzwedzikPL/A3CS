#include "script_component.hpp"
/*
 * Author: Kex for Zeus Enhanced project
 * Instantly loads the given magazine into the specified weapon
 */

params [
  ["_vehicle", objNull, [objNull]],
  ["_turretPath", [], [[]]],
  ["_muzzle", "", [""]],
  ["_magazine", "", [""]]
];

private _magazines = [];
private _ammoCounts = [];
{
  _x params ["_currentMagazine", "_currentTurretPath", "_currentAmmoCount"];
  if (_turretPath isEqualTo _currentTurretPath) then {
    _magazines pushBack _currentMagazine;
    _ammoCounts pushBack _currentAmmoCount;
  };
} forEach (magazinesAllTurrets _vehicle);

private _magIdx = _magazines findIf {_x == _magazine};
if (_magIdx != -1) then {
  // Remove weapon and magazines
  {
      _vehicle removeMagazineTurret [_x, _turretPath];
  } forEach _magazines;
  _vehicle removeWeaponTurret [_muzzle, _turretPath];

  // Add desired magazine first
  _vehicle addMagazineTurret [_magazine, _turretPath, _ammoCounts select _magIdx];
  _magazines deleteAt _magIdx;
  _ammoCounts deleteAt _magIdx;

  // Restore weapon and magazines
  _vehicle addWeaponTurret [_muzzle, _turretPath];
  {
    _vehicle addMagazineTurret [_x, _turretPath, _ammoCounts select _forEachIndex];
  } forEach _magazines;
};
