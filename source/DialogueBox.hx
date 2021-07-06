package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;
	var paththing:String = 'stitch/stitch_port';


	public var finishThing:Void->Void;

	var portraitLeft:FlxSprite;
	var portraitRight:FlxSprite;
	var portraitB:FlxSprite;
	var portraitS:FlxSprite;
	var portraitG:FlxSprite;
	var portraitA:FlxSprite;

	var handSelect:FlxSprite;
	var bgFade:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				FlxG.sound.playMusic(Paths.music('music/Lunchbox', 'week6'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'thorns':
				FlxG.sound.playMusic(Paths.music('music/LunchboxScary', 'week6'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'guns':
				FlxG.sound.playMusic(Paths.music('Inst', 'dadbattle'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'worship':
				FlxG.sound.playMusic(Paths.music('Inst', 'dadbattle'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'tord':
				FlxG.sound.playMusic(Paths.music('Inst', 'dadbattle'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'ugh':
				FlxG.sound.playMusic(Paths.music('Inst', 'dadbattle'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
		}

		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

		new FlxTimer().start(0.83, function(tmr:FlxTimer)
		{
			bgFade.alpha += (1 / 5) * 0.7;
			if (bgFade.alpha > 0.7)
				bgFade.alpha = 0.7;
		}, 5);

		box = new FlxSprite(-20, 45);
		
		var hasDialog = false;
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
			case 'guns':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('stitch/TEXTBOX', 'shared');
				box.animation.addByPrefix('normalOpen', 'TEXTBOX ENTER', 24, false);
				box.animation.addByIndices('normal', 'TEXTBOX ENTER', [7], "", 24);
				box.width = 200;
				box.height = 200;
				box.x = -500;
				box.y = 400;
			case 'worship':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('stitch/TEXTBOX', 'shared');
				box.animation.addByPrefix('normalOpen', 'TEXTBOX ENTER', 24, false);
				box.animation.addByIndices('normal', 'TEXTBOX ENTER', [7], "", 24);
				box.width = 200;
				box.height = 200;
				box.x = -500;
				box.y = 400;
			case 'tord':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('stitch/TEXTBOX', 'shared');
				box.animation.addByPrefix('normalOpen', 'TEXTBOX ENTER', 24, false);
				box.animation.addByIndices('normal', 'TEXTBOX ENTER', [7], "", 24);
				box.width = 200;
				box.height = 200;
				box.x = -500;
				box.y = 400;
			case 'ugh':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('stitch/TEXTBOX', 'shared');
				box.animation.addByPrefix('normalOpen', 'TEXTBOX ENTER', 24, false);
				box.animation.addByIndices('normal', 'TEXTBOX ENTER', [7], "", 24);
				box.width = 200;
				box.height = 200;
				box.x = -500;
				box.y = 400;
			case 'roses':
				hasDialog = true;
				FlxG.sound.play(Paths.sound('ANGRY_TEXT_BOX'));

				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-senpaiMad');
				box.animation.addByPrefix('normalOpen', 'SENPAI ANGRY IMPACT SPEECH', 24, false);
				box.animation.addByIndices('normal', 'SENPAI ANGRY IMPACT SPEECH', [4], "", 24);

			case 'thorns':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-evil');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);

				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);
		}

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;
		
		portraitLeft = new FlxSprite(276.95, 149.9);
		portraitLeft.frames = Paths.getSparrowAtlas(paththing);
		portraitLeft.animation.addByPrefix('enter', 'portrait', 24, false);
		//portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;

		portraitS = new FlxSprite(0, 0);
		portraitS.frames = Paths.getSparrowAtlas('stitch/stitch_port');
		portraitS.animation.addByPrefix('enterStitch', 'STITCH TALK', 24, false);
		portraitS.updateHitbox();
		portraitS.scrollFactor.set();
		add(portraitS);
		portraitS.visible = false;

		portraitA = new FlxSprite(0, -50);
		portraitA.frames = Paths.getSparrowAtlas('stitch/amminus_port');
		portraitA.animation.addByPrefix('enterAmminus', 'AMMINUS TALK', 24, false);
		portraitA.updateHitbox();
		portraitA.scrollFactor.set();
		add(portraitA);
		portraitA.visible = false;

		portraitB = new FlxSprite(750, 300);
		portraitB.frames = Paths.getSparrowAtlas('stitch/bf_port');
		portraitB.animation.addByPrefix('enterPotatoSalad', 'BF TALK', 24, false);
		portraitB.animation.addByPrefix('missPotatoSalad', 'BF STUMPED', 24, false);
		portraitB.animation.addByPrefix('coolMicThing', 'BF ENTER', 24, false);
		portraitB.updateHitbox();
		portraitB.scrollFactor.set();
		add(portraitB);
		portraitB.visible = false;

		portraitG = new FlxSprite(450, 120);
		portraitG.frames = Paths.getSparrowAtlas('stitch/gf_port');
		portraitG.animation.addByPrefix('enterGirlfriend', 'GF TALK', 24, false);
		portraitG.animation.addByPrefix('missGirlfriend', 'GF STUMPED', 24, false);
		portraitG.updateHitbox();
		portraitG.scrollFactor.set();
		add(portraitG);
		portraitG.visible = false;
		
		box.animation.play('normalOpen');
		box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
		box.updateHitbox();
		add(box);

		box.screenCenter(X);
		portraitLeft.screenCenter(X);

		handSelect = new FlxSprite(FlxG.width * 0.9, FlxG.height * 0.9).loadGraphic(Paths.image('hand_textbox', 'shared'));
		add(handSelect);


		if (!talkingRight)
		{
			// box.flipX = true;
		}

		dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
		dropText.font = 'Pixel Arial 11 Bold';
		dropText.color = 0xFFD89494;
		add(dropText);

		swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
		swagDialogue.font = 'Pixel Arial 11 Bold';
		swagDialogue.color = 0xFF3F2021;
		swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		add(swagDialogue);

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI
		if (PlayState.SONG.song.toLowerCase() == 'roses')
			portraitLeft.visible = false;
		if (PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft.color = FlxColor.BLACK;
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		}

		dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if (FlxG.keys.justPressed.ANY  && dialogueStarted == true)
		{
			remove(dialogue);
				
			FlxG.sound.play(Paths.sound('clickText'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns')
						FlxG.sound.music.fadeOut(2.2, 0);

					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						bgFade.alpha -= 1 / 5 * 0.7;
						portraitLeft.visible = false;
						portraitG.visible = false;
						portraitA.visible = false;
						portraitB.visible = false;
						portraitS.visible = false;
						swagDialogue.alpha -= 1 / 5;
						dropText.alpha = swagDialogue.alpha;
					}, 5);

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}
		
		super.update(elapsed);
	}

	var isEnding:Bool = false;

	function startDialogue():Void
	{
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);

		switch (curCharacter)
		{
			case 'stitch':
				portraitS.visible = false;
				if (!portraitS.visible)
				{
					portraitS.visible = true;
					portraitA.visible = false;
					portraitS.animation.play('enterStitch');
				}
			case 'amminus':
				portraitA.visible = false;
				if (!portraitA.visible)
				{
					portraitA.visible = true;
					portraitS.visible = false;
					portraitA.animation.play('enterAmminus');
				}
			case 'cool':
				portraitB.visible = false;
				if (!portraitB.visible)
				{
					portraitB.visible = true;
					portraitB.animation.play('coolMicThing');
				}
			case 'bf':
				portraitB.visible = false;
				if (!portraitB.visible)
				{
					portraitB.visible = true;
					portraitB.animation.play('enterPotatoSalad');
				}
			case 'bfMiss':
				portraitB.visible = false;
				if (!portraitB.visible)
				{
					portraitB.visible = true;
					portraitB.animation.play('missPotatoSalad');
				}
			case 'gf':
				portraitG.visible = false;
				if (!portraitG.visible)
				{
					portraitG.visible = true;
					portraitG.animation.play('enterGirlfriend');
				}
			case 'gfMiss':
				portraitG.visible = false;
				if (!portraitG.visible)
				{
					portraitG.visible = true;
					portraitG.animation.play('missGirlfriend');
				}
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
	}
}
