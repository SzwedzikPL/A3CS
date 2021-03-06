class GVAR(objects3DENComp): GVAR(base) {
    scope = 2;
    author = "SzwedzikPL";
    displayName = CSTRING(objects3DENComp_displayName);
    icon = QPATHTOF(modules\objects3DENComp\data\icon.paa);
    category = QGVAR(3DENComp);
    function = QFUNC(objects3DENComp_module);
    isTriggerActivated = 0;
    GVAR(validator) = QFUNC(objects3DENComp_validate);

    class Attributes: AttributesBase {
        class GVAR(moduleShortDescription): GVAR(moduleShortDescription) {};
        class GVAR(moduleWarnings): GVAR(moduleWarnings) {};

        class GVAR(baseSettingsSubCategory): GVAR(moduleSubCategory) {
            displayName = CSTRING(objects3DENComp_Attributes_baseSettingsSubCategory);
            property = QGVAR(baseSettingsSubCategory);
        };

        class GVAR(data): GVAR(dynamicHiddenEdit) {
            displayName = "data";
            tooltip = "data";
            property = QGVAR(data);
            defaultValue = "'[]'";
            ATTRIBUTE_LOCAL;
        };

        class GVAR(dataSaved): GVAR(dynamicHiddenCheckbox) {
            displayName = "dataSaved";
            tooltip = "dataSaved";
            property = QGVAR(dataSaved);
            defaultValue = "false";
            ATTRIBUTE_LOCAL;
        };

        class GVAR(mode): GVAR(dynamicToolbox3DENCompMode) {
            displayName = CSTRING(objects3DENComp_Attributes_mode);
            tooltip = CSTRING(objects3DENComp_Attributes_mode_tooltip);
            property = QGVAR(mode);
            typeName = "NUMBER";
            defaultValue = "0";
            ATTRIBUTE_LOCAL;
        };

        class GVAR(dataStats): GVAR(dynamicEditMulti5) {
            displayName = CSTRING(objects3DENComp_Attributes_dataStats);
            tooltip = CSTRING(objects3DENComp_Attributes_dataStats_tooltip);
            property = QGVAR(dataStats);
            defaultValue = "''";
            GVAR(disabled) = 1;
            GVAR(conditionActive) = QUOTE((_this getVariable QQGVAR(dataSaved)) isEqualTo true);
            ATTRIBUTE_IGNORED;
        };

        class GVAR(addObjectPostInit): GVAR(dynamicCheckbox) {
            displayName = CSTRING(objects3DENComp_Attributes_addObjectPostInit);
            tooltip = CSTRING(objects3DENComp_Attributes_addObjectPostInit_tooltip);
            property = QGVAR(addObjectPostInit);
        };

        class GVAR(objectPostInit): GVAR(dynamicEditCodeMulti5) {
            displayName = CSTRING(objects3DENComp_Attributes_objectPostInit);
            tooltip = CSTRING(objects3DENComp_Attributes_objectPostInit_tooltip);
            GVAR(description) = CSTRING(objects3DENComp_Attributes_objectPostInit_desc);
            property = QGVAR(objectPostInit);
            defaultValue = "''";
            typeName = "STRING";
            GVAR(conditionActive) = QUOTE((_this getVariable QQGVAR(addObjectPostInit)) isEqualTo true);
        };

        class GVAR(moduleDescription): GVAR(moduleDescription) {};
    };

    class GVAR(moduleDescription): GVAR(moduleDescription) {
        shortDescription = CSTRING(objects3DENComp_shortDescription);
        canSyncWith[] = {"<anyObject>"};
        syncRequired = 1;
    };
};
