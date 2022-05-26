::MSU.Class.SerializationSystem <- class extends ::MSU.Class.System
{
	Mods = null;
	FlagsToClear = null;

	constructor()
	{
		base.constructor(::MSU.SystemID.Serialization);
		this.Mods = [];
		this.FlagsToClear = [];
	}

	function registerMod( _mod )
	{
		base.registerMod(_mod);
		this.Mods.push(_mod);
		_mod.Serialization = ::MSU.Class.SerializationModAddon(_mod);
	}

	function flagSerialize( _mod, _id, _object, _flags = null, _clear = true )
	{
		if (_flags == null) _flags = ::World.Flags;
		local outEmulator = ::MSU.Class.SerializationEmulator(_mod, _id);
		::MSU.Utils.serialize(_object, outEmulator);
		outEmulator.storeInFlagContainer(_flags);
		if (_clear) this.FlagsToClear.push([outEmulator.getEmulatorString(), _flags]);
	}

	function flagDeserialize( _mod, _id, _flags = null, _clear = true )
	{
		if (_flags == null) _flags = ::World.Flags;
		local inEmulator = ::MSU.Class.DeserializationEmulator(_mod, _id);
		inEmulator.getFromFlagContainer(_flags);
		if (_clear) this.FlagsToClear.push([inEmulator.getEmulatorString(), _flags]);
		return ::MSU.Utils.deserialize(inEmulator);
	}

	function clearFlags()
	{
		foreach (flagPair in this.FlagsToClear)
		{
			if (flagPair[1].has(flagPair[0]))
			{
				for (local i = 0; i < flagPair[1].get(flagPair[0]); ++i)
				{
					flagPair[1].remove(flagPair[0] + "." + i);
				}
				flagPair[1].remove(flagPair[0]);
			}
		}
	}
}
