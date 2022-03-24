::MSU.Math <- {
	function pi()
	{
		return 3.14159;
	}

	// returns log2 of _num, floored (as an int)
	function log2int( _num )
	{
		local count = 0;
		while (_num > 1) 
		{
			_num = _num >> 1;
			count++;
		}
		return count;
	}

	// Returns the normalized value of the normal distribution at _x
	function normalDistNorm( _x, _mean, _stdev )
	{
		return exp(-0.5 * pow((_x - _mean)/_stdev.tofloat(), 2));
	}

	// Returns the value of the normal distribution at _x
	function normalDist( _x, _mean, _stdev )
	{
		return exp(-0.5 * pow((_x - _mean)/(_stdev * 1.0), 2)) / (_stdev * sqrt(2 * 3.14));			
	}
};
