::MSU.HooksMod <- ::Hooks.register(::MSU.ID, ::MSU.Version, ::MSU.Name);
::MSU.HooksMod.require("vanilla" + " >= 1.5.0-13");
::MSU.HooksMod.conflictWith("mod_legends < 16.0.0");

::MSU.HooksMod.queue(function() {
	::include("msu/load.nut");
});

::MSU.HooksMod.queue(function() {
	foreach (func in ::MSU.QueueBucket.VeryLate)
	{
		func();
	}
	::MSU.QueueBucket.VeryLate.clear();
}, ::Hooks.QueueBucket.VeryLate);

::MSU.HooksMod.queue(function() {
	foreach (func in ::MSU.QueueBucket.AfterHooks)
	{
		func();
	}
	::MSU.QueueBucket.AfterHooks.clear();
}, ::Hooks.QueueBucket.AfterHooks);

::MSU.HooksMod.queue(function() {
	foreach (func in ::MSU.QueueBucket.FirstWorldInit)
	{
		func();
	}
	::MSU.QueueBucket.FirstWorldInit.clear();
	delete ::MSU.QueueBucket;
}, ::Hooks.QueueBucket.FirstWorldInit);

::MSU.QueueBucket.FirstWorldInit.push(function() {
	foreach (script in ::IO.enumerateFiles("scripts/ai/tactical/behaviors"))
	{
		try
		{
			::MSU.AI.BehaviorIDToScriptMap[::new(script).getID()] <- script;
		}
		catch (error)
		{
			::logError("Could not instantiate or get ID of behavior: " + script);
		}
	}
});
