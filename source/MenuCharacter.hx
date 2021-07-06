package;

import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;

class CharacterSetting
{
	public var x(default, null):Int;
	public var y(default, null):Int;
	public var scale(default, null):Float;
	public var flipped(default, null):Bool;

	public function new(x:Int = 0, y:Int = 0, scale:Float = 1.0, flipped:Bool = false)
	{
		this.x = x;
		this.y = y;
		this.scale = scale;
		this.flipped = flipped;
	}
}

class MenuCharacter extends FlxSprite
{
	private static var settings:Map<String, CharacterSetting> = [
		'bf' => new CharacterSetting(0, -40, 1.0, true),
		'gf' => new CharacterSetting(-10, 50, 1.5, true),
		'dad' => new CharacterSetting(-15, 130),
		'spooky' => new CharacterSetting(20, 30),
		'pico' => new CharacterSetting(0, 0, 1.0, true),
		'mom' => new CharacterSetting(-30, 140, 0.85),
		'parents-christmas' => new CharacterSetting(100, 130, 1.8),
		'senpai' => new CharacterSetting(-40, -45, 1.4),
		'stitch' => new CharacterSetting(-40, 50, 1.4)
	];

	private var flipped:Bool = false;

	public function new(x:Int, y:Int, scale:Float, flipped:Bool)
	{
		super(x, y);
		this.flipped = flipped;

		antialiasing = true;

		frames = Paths.getSparrowAtlas('campaign_menu_UI_characters');

		animation.addByPrefix('bf', "BF idle dance white instance 1", 24);
		animation.addByPrefix('bfConfirm', 'BF HEY!! instance 1', 24, false);
		animation.addByPrefix('gf', "GF Dancing Beat WHITE instance 1", 24);
		animation.addByPrefix('dad', "Dad idle dance BLACK LINE instance 1", 24);
		animation.addByPrefix('spooky', "spooky dance idle BLACK LINES instance 1", 24);
		animation.addByPrefix('pico', "Pico Idle Dance instance 1", 24);
		animation.addByPrefix('mom', "Mom Idle BLACK LINES instance 1", 24);
		animation.addByPrefix('parents-christmas', "Parent Christmas Idle instance 1", 24);
		animation.addByPrefix('senpai', "SENPAI idle Black Lines instance 1", 24);
		animation.addByPrefix('stitch', "STITCH black lines instance 1", 24);

		setGraphicSize(Std.int(width * scale));
		updateHitbox();
	}

	public function setCharacter(character:String):Void
	{
		if (character == '')
		{
			visible = false;
			return;
		}
		else
		{
			visible = true;
		}

		animation.play(character);

		var setting:CharacterSetting = settings[character];
		offset.set(setting.x, setting.y);
		setGraphicSize(Std.int(width * setting.scale));
		flipX = setting.flipped != flipped;
	}
}
