::MSU.Class.MetaDataEmulator <- class
{
	Version = null;
	Data = null;
	constructor()
	{
		this.Data = {};
		this.Version = ::Const.Serialization.Version;
	}

	function setVersion( _version )
	{
		this.Version = _version;
	}

	function getVersion()
	{
		return this.Version;
	}

	function __setValue( _key, _value )
	{
		this.Data[_key] <- _value;
	}

	function __getValue( _key )
	{
		return this.Data[_key];
	}

	function setInt( _key, _value)
	{
		::MSU.requireInt(_value);
		this.__setValue(_key, _value);
	}

	function getInt( _key )
	{
		return this.__getValue(_key);
	}

	function setString( _key, _value )
	{
		::MSU.requireString(_value);
		this.__setValue(_key, _value);
	}

	function getString( _key )
	{
		return this.__getValue(_key);
	}

	function setFloat( _key, _value )
	{
		::MSU.requireFloat(_value);
		this.__setValue(_key, _value);
	}

	function getFloat( _key )
	{
		return this.__getValue(_key);
	}

	function hasData( _key )
	{
		return _key in this.Data;
	}

	function getName()
	{
		return "";
	}

	function getModificationDate()
	{
		return "";
	}

	function getCreationDate()
	{
		return "";
	}

	function getFileName()
	{
		return "";
	}
}