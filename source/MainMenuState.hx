package;
 
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.addons.display.FlxTiledSprite;
import flixel.effects.FlxFlicker;
import lime.app.Application;
 
#if desktop
import Discord.DiscordClient;
#end
 
class MainMenuState extends MusicBeatState
{
	var buttonBG:FlxSprite;
	var panel:FlxSprite;
	var bg:FlxSprite;
	var rightButtonBG:FlxSprite;
	var logoBl:FlxSprite;
	var mouseOverObject:Bool;
	var menuName:FlxText;
	var bto:FlxText;
 
	var storymodeButton:FlxButton;
	var storymodeSelectedButton:FlxSprite;
	var freeplayButton:FlxButton;
	var freeplaySelectedButton:FlxSprite;
	var optionsButton:FlxButton;
	var optionsSelectedButton:FlxSprite;
	public static var psychEngineVersion:String = '0.5.2'; //This is also used for Discord RPC
	public static var curSelected:Int = 0;
	var creditButton:FlxButton;
	var creditSelectedButton:FlxSprite;
 
	var exitButton:FlxButton;
	var exitSelectedButton:FlxSprite;

	var glButton:FlxButton;
	var glSelectedButton:FlxSprite;

	var bioButton:FlxButton;
	var bioSelectedButton:FlxSprite;

	var magenta:FlxSprite;
	var camFollow:FlxObject;
	var camFollowPos:FlxObject;
 
 
	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		#end
 
		FlxG.mouse.visible = true;
 
 
		WeekData.loadTheFirstEnabledMod();
 
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end
 
		persistentUpdate = persistentDraw = true;
		var bgTex = Paths.getSparrowAtlas('fondo');
 
		var daBG = new FlxSprite();
		daBG.frames = bgTex;
		daBG.animation.addByPrefix('idle', 'espacio');
		daBG.animation.play('idle', true);
		daBG.setGraphicSize(Std.int(daBG.width * 2));
		daBG.updateHitbox();
		daBG.screenCenter();
		daBG.antialiasing = ClientPrefs.globalAntialiasing;
		add(daBG);
 
		magenta = new FlxSprite(-80).loadGraphic(Paths.image('menuDesat'));
		magenta.setGraphicSize(Std.int(magenta.width * 1.175));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		magenta.antialiasing = ClientPrefs.globalAntialiasing;
		magenta.color = 0xFFfd719b;
		add(magenta);
 
		bg = new FlxSprite(100).loadGraphic(Paths.image('menu sf/cosmic'));
		bg.updateHitbox();
		
		
		add(bg);
		panel = new FlxSprite(-80).loadGraphic(Paths.image('menu sf/panel'));
		panel.updateHitbox();
		panel.screenCenter();
		panel.setGraphicSize(1300);
		add(panel);
		bto = new FlxText(0, 700, "For Seriousmobkiller");
		bto.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		bto.screenCenter(X);
		
 
 
		var scale:Float = 0.7;
		storymodeButton = new FlxButton(-40, 200, "");
		storymodeButton.frames = Paths.getSparrowAtlas('menu sf/play');
		storymodeButton.scale.x = scale;
		storymodeButton.scale.y = scale;
		storymodeButton.animation.addByPrefix('idle', "story_mode basic", 24);
		storymodeButton.animation.addByPrefix('selected', "story_mode white", 24);
		add(storymodeButton);
 
		storymodeSelectedButton = new FlxSprite(-40, 200, "");
		storymodeSelectedButton.frames = Paths.getSparrowAtlas('menu sf/play');
		storymodeSelectedButton.scale.x = scale;
		storymodeSelectedButton.scale.y = scale;
		storymodeSelectedButton.animation.addByPrefix('idle', "story_mode basic", 24);
		storymodeSelectedButton.animation.addByPrefix('selected', "story_mode white", 24);
		storymodeSelectedButton.animation.play('selected');
		storymodeSelectedButton.visible = false;
		add(storymodeSelectedButton);
 
		freeplayButton = new FlxButton(50, 300, "");
		freeplayButton.frames = Paths.getSparrowAtlas('menu sf/freeplay');
		freeplayButton.scale.x = 1.05;
		freeplayButton.scale.y = 1.05;
		freeplayButton.animation.addByPrefix('idle', "freepotato", 24);
		freeplayButton.animation.addByPrefix('selected', "freepotato", 24);
		add(freeplayButton);
 
		freeplaySelectedButton = new FlxSprite(50, 300, "");
		freeplaySelectedButton.frames = Paths.getSparrowAtlas('menu sf/freeplay');
		freeplaySelectedButton.scale.x = 1.05;
		freeplaySelectedButton.scale.y = 1.05;
		freeplaySelectedButton.animation.addByPrefix('idle', "freepotato", 24);
		freeplaySelectedButton.animation.addByPrefix('selected', "freepotato", 24);
		freeplaySelectedButton.animation.play('selected');
		freeplaySelectedButton.visible = false;
		add(freeplaySelectedButton);
 
		optionsButton = new FlxButton(50, 580, "");
		optionsButton.frames = Paths.getSparrowAtlas('menu sf/settings');
		optionsButton.scale.x = 1.05;
		optionsButton.scale.y = 1.05;
		optionsButton.animation.addByPrefix('idle', "settings", 24);
		optionsButton.animation.addByPrefix('selected', "settings", 24);
		add(optionsButton);
 
		optionsSelectedButton = new FlxSprite(50, 580, "");
		optionsSelectedButton.frames = Paths.getSparrowAtlas('menu sf/settings');
		optionsSelectedButton.scale.x = 1.05;
		optionsSelectedButton.scale.y = 1.05;
		optionsSelectedButton.animation.addByPrefix('idle', "settings", 24);
		optionsSelectedButton.animation.addByPrefix('selected', "settings", 24);
		optionsSelectedButton.animation.play('selected');
		optionsSelectedButton.visible = false;
		add(optionsSelectedButton);
 
		creditButton = new FlxButton(50, 525, "");
		creditButton.frames = Paths.getSparrowAtlas('menu sf/credits');
		creditButton.scale.x = 1.05;
		creditButton.scale.y = 1.05;
		creditButton.animation.addByPrefix('idle', "credits", 24);
		creditButton.animation.addByPrefix('selected', "credits", 24);
		add(creditButton);
 
		creditSelectedButton = new FlxSprite(50, 525, "");
		creditSelectedButton.frames = Paths.getSparrowAtlas('menu sf/credits');
		creditSelectedButton.scale.x = 1.05;
		creditSelectedButton.scale.y = 1.05;
		creditSelectedButton.animation.addByPrefix('idle', "credits", 24);
		creditSelectedButton.animation.addByPrefix('selected', "credits", 24);
		creditSelectedButton.animation.play('selected');
		creditSelectedButton.visible = false;
		add(creditSelectedButton);

		exitButton = new FlxButton(50, 635, "");
		exitButton.frames = Paths.getSparrowAtlas('menu sf/exit');
	    exitButton.scale.x = 1.07;
		exitButton.scale.y = 1.07;
		exitButton.animation.addByPrefix('idle', "exit", 24);
		exitButton.animation.addByPrefix('selected', "exit", 24);
		add(exitButton);
 
		exitSelectedButton = new FlxSprite(50, 635, "");
		exitSelectedButton.frames = Paths.getSparrowAtlas('menu sf/exit');
		exitSelectedButton.scale.x = 1.07;
		exitSelectedButton.scale.y = 1.07;
		exitSelectedButton.animation.addByPrefix('idle', "exit", 24);
		exitSelectedButton.animation.addByPrefix('selected', "exit", 24);
		exitSelectedButton.animation.play('selected');
		exitSelectedButton.visible = false;
		add(exitSelectedButton);

		glButton = new FlxButton(50, 470, "");
		glButton.frames = Paths.getSparrowAtlas('menu sf/gallery');
	    glButton.scale.x = 1.07;
		glButton.scale.y = 1.07;
		glButton.animation.addByPrefix('idle', "gallery", 24);
		glButton.animation.addByPrefix('selected', "gallery", 24);
		add(glButton);
 
		glSelectedButton = new FlxSprite(50, 470, "");
		glSelectedButton.frames = Paths.getSparrowAtlas('menu sf/gallery');
		glSelectedButton.scale.x = 1.07;
		glSelectedButton.scale.y = 1.07;
		glSelectedButton.animation.addByPrefix('idle', "gallery", 24);
		glSelectedButton.animation.addByPrefix('selected', "gallery", 24);
		glSelectedButton.animation.play('selected');
		glSelectedButton.visible = false;
		add(glSelectedButton);

		
		bioButton = new FlxButton(-36, 360, "");
		bioButton.frames = Paths.getSparrowAtlas('menu sf/bio');
	    bioButton.scale.x = 0.7;
		bioButton.scale.y = 0.7;
		bioButton.animation.addByPrefix('idle', "bio", 24);
		bioButton.animation.addByPrefix('selected', "bio", 24);
		add(bioButton);
 
		bioSelectedButton = new FlxSprite(-36, 360, "");
		bioSelectedButton.frames = Paths.getSparrowAtlas('menu sf/bio');
		bioSelectedButton.scale.x = 0.7;
		bioSelectedButton.scale.y = 0.7;
		bioSelectedButton.animation.addByPrefix('idle', "bio", 24);
		bioSelectedButton.animation.addByPrefix('selected', "bio", 24);
		bioSelectedButton.animation.play('selected');
		bioSelectedButton.visible = false;
		add(bioSelectedButton);

		super.create();
	}
 
	override function update(elapsed:Float)
	{
	
		if (FlxG.mouse.overlaps(storymodeButton))
			{
				storymodeButton.animation.play('selected');
				storymodeButton.centerOffsets();
			}
 
			else
				{
					storymodeButton.animation.play('idle');
					storymodeButton.centerOffsets();
				}
 
				if (FlxG.mouse.overlaps(freeplayButton))
					{
						freeplayButton.animation.play('selected');
						freeplayButton.centerOffsets();
					}
 
					else
						{
							freeplayButton.animation.play('idle');
							freeplayButton.centerOffsets();
						}
 
 
								if (FlxG.mouse.overlaps(optionsButton))
									{
										optionsButton.animation.play('selected');
										optionsButton.centerOffsets();
									}
 
									else
										{
											optionsButton.animation.play('idle');
											optionsButton.centerOffsets();
										}
				if (FlxG.mouse.overlaps(creditButton))
												{
													creditButton.animation.play('selected');
													creditButton.centerOffsets();
												}
 
												else
													{
														creditButton.animation.play('idle');
														creditButton.centerOffsets();
													}
											if (FlxG.mouse.overlaps(exitButton))
												{
													exitButton.animation.play('selected');
													exitButton.centerOffsets();
												}
 
												else
													{
														exitButton.animation.play('idle');
														exitButton.centerOffsets();
													}
													if (FlxG.mouse.overlaps(glButton))
												{
													glButton.animation.play('selected');
													glButton.centerOffsets();
												}
 
												else
													{
														glButton.animation.play('idle');
														glButton.centerOffsets();
													}
 
	 if (storymodeButton.justPressed)
		{
			storymodeButton.visible = false;
			storymodeSelectedButton.centerOffsets();
			FlxG.sound.play(Paths.sound('confirmMenu'));
			FlxFlicker.flicker(storymodeSelectedButton, 1, 0.06, false, false, function(flick:FlxFlicker)
				{
 
 
							storymodeSelectedButton.visible = true;
							MusicBeatState.switchState(new StoryMenuState());
 
 
				});
				
 
 
		}
 
		if (freeplayButton.justPressed)
			{
				freeplayButton.visible = false;
				freeplaySelectedButton.centerOffsets();
				FlxG.sound.play(Paths.sound('confirmMenu'));
				FlxFlicker.flicker(freeplaySelectedButton, 1, 0.06, false, false, function(flick:FlxFlicker)
					{
 
 
								freeplaySelectedButton.visible = true;
								MusicBeatState.switchState(new FreeplayState());
 
 
					});
					
 
							FlxG.mouse.visible = false;
 
			}
 
 
		if (optionsButton.justPressed)
		{
			optionsButton.visible = false;
			optionsSelectedButton.centerOffsets();
				FlxG.sound.play(Paths.sound('confirmMenu'));
				FlxFlicker.flicker(optionsSelectedButton, 1, 0.06, false, false, function(flick:FlxFlicker)
					{
 
 
						optionsSelectedButton.visible = true;
						LoadingState.loadAndSwitchState(new options.OptionsState());
 
 
					});
				
				FlxG.mouse.visible = false;
		}
 
		if (creditButton.justPressed)
		{
			creditButton.visible = false;
			creditSelectedButton.centerOffsets();
			FlxG.sound.play(Paths.sound('confirmMenu'));
			FlxFlicker.flicker(creditSelectedButton, 1, 0.06, false, false, function(flick:FlxFlicker)
				{
 
 
							creditSelectedButton.visible = true;
							MusicBeatState.switchState(new CreditsState());
 
 
				});
				
				FlxG.mouse.visible = false;
 
 
 
		}
			


			if (exitButton.justPressed)
		{
			exitButton.visible = false;
			exitSelectedButton.centerOffsets();
			FlxG.sound.play(Paths.sound('confirmMenu'));
			FlxFlicker.flicker(exitSelectedButton, 1, 0.06, false, false, function(flick:FlxFlicker)
				{
 
 
							exitSelectedButton.visible = true;
							Sys.exit(0);
 
 
				});
				
 
			FlxG.mouse.visible = false;
 
		}
		if (glButton.justPressed)
		{
			glButton.visible = false;
			glSelectedButton.centerOffsets();
			FlxG.sound.play(Paths.sound('confirmMenu'));
			FlxFlicker.flicker(glSelectedButton, 1, 0.06, false, false, function(flick:FlxFlicker)
				{
 
 
							glSelectedButton.visible = true;
							MusicBeatState.switchState(new GalleryState());
 
 
				});
				
 
			FlxG.mouse.visible = false;
 
		}
 
		super.update(elapsed);
	}
}