::mods_addHook("root_state.onInit", function(r) // executed once per game session
{
	this.logInfo("runs")
    ::MSU.System.ModSettings.importPersistentSettings();
    ::MSU.System.Keybinds.importPersistentSettings();
});
