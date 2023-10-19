::MSU.Class.StringSerializationData <- class extends ::MSU.Class.BasicSerializationData
{
	static __Type = ::MSU.Utils.SerializationDataType.String;

	constructor( _data )
	{
		::MSU.requireString(_data);
		base.constructor( _data);
	}
}
