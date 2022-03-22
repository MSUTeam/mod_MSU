::MSU.isNull <- function( _object )
{
	if (_object == null)
	{
		return true;
	}
	if (typeof _object == "instance" && _object instanceof this.WeakTableRef)
	{
		return _object.isNull();
	}
	return false;
}

::MSU.isIn <- function( _member, _object )
{
	switch (typeof _object)
	{
		case "instance":
			if (_object instanceof ::WeakTableRef)
			{
				if (_object.isNull())
				{
					::printError("The table inside the WeakTableRef instance is null");
					throw ::MSU.Exception.KeyNotFound(_member);
				}
				return _member in _object.get();
			}
		case "table":
			return _member in _object;
			break;

		case "array":
			return _object.find(_member) != null;
			break;

		default:
			throw ::MSU.Exception.InvalidType(_object);
	}
}

::MSU.isKindOf <- function( _object, _className )
{
	local obj = _object;
	if (typeof obj == "instance")
	{
		if (obj instanceof ::WeakTableRef)
		{
			if (obj.isNull())
			{
				::printError("The table inside the WeakTableRef instance is null");
				throw ::MSU.Exception.KeyNotFound(_className);
			}
			obj = obj.get();
		}
		else throw ::MSU.Exception.InvalidType(_object);
	}

	return ::isKindOf(obj, _className);
}
