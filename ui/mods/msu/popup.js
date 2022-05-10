var MSUPopup = function ()
{
	this.mSQHandle = null
	this.mContainer = null;
	this.mID = "MSUPopup";

	this.mHeaderContainer = null;
	this.mTextContainer = null;
	this.mFooterContainer = null;
	this.mTextArray = [];
	this.mForceQuit = false;
}

MSUPopup.prototype.onConnection = function (_handle)
{
	this.register($('.root-screen'));
	this.mSQHandle = _handle;
}

MSUPopup.prototype.createDIV = function (_parentDiv)
{
	var self = this;
	this.mContainer = $('<div class="msu-popup ui-control dialog display-none opacity-none"/>');
	_parentDiv.append(this.mContainer);

	this.mHeaderContainer = $('<div class="header"/>');
	this.mContainer.append(this.mHeaderContainer);

	var title = '<div class="title title-font-very-big font-bold font-bottom-shadow font-color-title">Mod Error</div>'
	this.mHeaderContainer.append(title);

	this.mTextContainer = $('<div class="text-container"/>');
	this.mContainer.append(this.mTextContainer);
	this.mTextListContainer = this.mTextContainer.createList(2);
	this.mTextContainer.append(this.mTextListContainer);
	this.mTextScrollContainer = this.mTextListContainer.findListScrollContainer();

	this.mFooterContainer = $('<div class="footer"/>')
	this.mContainer.append(this.mFooterContainer);

	this.mFooterContainer.createTextButton("Ok", jQuery.proxy(function()
	{
		if (this.mForceQuit)
		{
			this.quitGame();
		}
		else
		{
			this.hide();
		}

	}, this), "ok-button", 1);
}

MSUPopup.prototype.create = function(_parentDiv)
{
	this.createDIV(_parentDiv);
};

MSUPopup.prototype.destroy = function ()
{
	this.destroyDIV();
}

MSUPopup.prototype.show = function ()
{
	var self = this;

	// MSUUIScreen.show
	var moveTo = { opacity: 1, right: '10.0rem' };
	var offset = -this.mContainer.width();
	if (self.mContainer.hasClass('is-center') === true)
	{
		moveTo = { opacity: 1, left: '0', right: '0' };
		offset = -(this.mContainer.parent().width() + this.mContainer.width());
		this.mContainer.css({ 'left': '0' });
	}

	this.mContainer.css({ 'right': offset });
	this.mContainer.velocity("finish", true).velocity(moveTo,
	{
		duration: Constants.SCREEN_SLIDE_IN_OUT_DELAY,
		easing: 'swing',
		begin: function ()
		{
			$(this).removeClass('display-none').addClass('display-block');
		},
		complete: function ()
		{
		}
	});
}

MSUPopup.prototype.isVisible = function ()
{
	return this.mContainer.hasClass('display-block');
}

MSUPopup.prototype.setForceQuit = function ( _forceQuit)
{
	this.mForceQuit = _forceQuit;
	if (this.mForceQuit)
	{
		this.mFooterContainer.find(".ok-button:first").html("Quit Game");
	}
	else
	{
		this.mFooterContainer.find(".ok-button:first").html("Ok");
	}
}

MSUPopup.prototype.addLine = function (_text)
{
	this.mTextArray.push(_text);
	this.mTextScrollContainer.html(this.mTextScrollContainer.html() + "<br>" + _text);
}

MSUPopup.prototype.addLines = function (_textArray)
{
	for (var i = 0; i < _textArray.length; i++)
	{
		this.addLine(_textArray[i]);
	}
}

MSUPopup.prototype.clearText = function ()
{
	this.mTextArray = [];
	this.mTextScrollContainer.html("");
}

MSUPopup.prototype.hide = function (_clearText)
{
	if(_clearText) this.clearText()
	var self = this;

	//MSUUIScreen.hide
	this.mContainer.velocity("finish", true).velocity({ opacity: 0 },
	{
		duration: Constants.SCREEN_FADE_IN_OUT_DELAY,
		easing: 'swing',
		begin: function()
		{
		},
		complete: function()
		{
			$(this).css({ opacity: 0 });
			$(this).removeClass('display-block').addClass('display-none');
		}
	});
}

MSUPopup.prototype.register = function (_parentDiv)
{
	console.log('MSUPopup::REGISTER');
	this.create(_parentDiv);
}

MSUPopup.prototype.unregister = function ()
{
	console.log('MSUPopup::UNREGISTER');
	this.destroy();
}

MSUPopup.prototype.quitGame = function ()
{
	SQ.call(this.mSQHandle, "quitGame");
	this.hide();
}

registerScreen("MSUPopup", new MSUPopup());
