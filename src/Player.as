package  
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxU;
	import org.flixel.FlxG;
	import org.flixel.plugin.photonstorm.FlxBar;
	import org.flixel.plugin.photonstorm.FlxWeapon;
	
	import Weapon;
	import attributes.*;
	
	/**
	 * ...
	 * @author Doug Macdonald
	 */
	public class Player extends Character
	{
		[Embed(source = '../data/shark_blue.png')] private var ImgSprite:Class;
		[Embed(source = '../data/bullet_pistol.png')] private var ImgBulletPistol:Class;
		
		public static const FRAME_WIDTH:int = 40;
		public static const FRAME_HEIGHT:int = 40;
		
		public static const INITIAL_SPEED:Number = 150;
		public static const INITIAL_HEALTH:int = 100;
		
		private var maxspeed:Number;
		
		private var direction:Number;
		
		private var invulnerableTimer:Number;
		private var invulnerableTime:Number;
		
		public var EAST:Number = 0;
		public var SOUTHEAST:Number = 45;
		public var SOUTH:Number = 90;
		public var SOUTHWEST:Number = 135;
		public var WEST:Number = 180;
		public var NORTHWEST:Number = 225;
		public var NORTH:Number = 270;
		public var NORTHEAST:Number = 315;
		
		public function Player(X:Number, Y:Number, bulletGroup:FlxGroup): void
		{
			super(X, Y);
			loadGraphic(ImgSprite, true, false, FRAME_WIDTH, FRAME_HEIGHT);
			addAnimation("default", [0]);
			addAnimation("hurt", [0,1], 30);
			
			maxVelocity = new FlxPoint(maxspeed, maxspeed);
			drag.x = drag.y = 100
			
			SPEED = INITIAL_SPEED;
			MAX_HP = health = INITIAL_HEALTH;
			DEF = 1.25;
			ATK = 10;
			WEAPON_PISTOL = 1;
			WEAPON_SIDE = 0;
			WEAPON_REAR = 0;
			REGEN = 0;

			this.bulletGroup = bulletGroup;
			
			invulnerableTimer = 0;
			invulnerableTime = 3;
		}
		
		public override function hurt(damage:Number): void
		{
			if (!invulnerableTimer)
			{
				invulnerableTimer = invulnerableTime;
				super.hurt(damage / DEF);
			}
		}
		
		public override function kill(): void
		{
			//PlayState.lose();
			//revive();
		}
		
		override public function update(): void
		{
			maxspeed = SPEED * 2;
			
			move();
			shoot();
			
			if (invulnerableTimer > 0)
			{
				invulnerableTimer -= FlxG.elapsed;
			}
			if (invulnerableTimer < 0)
			{
				invulnerableTimer = 0;
			}
			if (invulnerableTimer > 0)
			{
				play("hurt");
			}
			else
			{
				play("default");
			}
			
			super.update();
		}
		
		public function move(): void
		{
			var direction:FlxPoint = new FlxPoint(0, 0);
			if (FlxG.keys.W)
			{
				--direction.y;
			}
			if (FlxG.keys.S)
			{
				++direction.y;
			}
			if (FlxG.keys.A)
			{
				--direction.x;
			}
			if (FlxG.keys.D)
			{
				++direction.x;
			}
			
			// Debug keys
			if (FlxG.keys.NINE)
			{
				health = Math.min(health += 10, 100);
			}
			if (FlxG.keys.EIGHT)
			{
				health = Math.max(health -= 10, 0);
			}
			if (FlxG.keys.SEVEN)
			{
				addAttribute(new attributes.WeaponPistolAttribute);
			}
			
			acceleration = new FlxPoint(SPEED * direction.x, SPEED * direction.y);
			
			if (direction.x || direction.y)
			{
				angle = FlxU.getAngle(velocity, new FlxPoint(0, 0)) + 90;
			}
		}
		
		public function shoot(): void
		{
			var direction:FlxPoint = new FlxPoint(0, 0);
			if (FlxG.keys.UP)
			{
				--direction.y;
			}
			if (FlxG.keys.DOWN)
			{
				++direction.y;
			}
			if (FlxG.keys.LEFT)
			{
				--direction.x;
			}
			if (FlxG.keys.RIGHT)
			{
				++direction.x;
			}
			
			if (direction.x || direction.y)
			{
				for (var i:Number = 0; i < weapons.length; i++)
				{
					var weapon:Weapon = weapons.members[i];
					weapon.update();
					weapon.fireVector(direction, width/2 * direction.x, height/2 * direction.y);
				}
			}
		}

	}

}