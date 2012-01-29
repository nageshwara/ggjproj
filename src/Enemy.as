package  
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxU;
	import org.flixel.FlxG;
	import attributes.Attribute;
	import attributes.AttackAttribute;
	import attributes.DefenseAttribute;
	import attributes.RegenAttribute;
	import attributes.SpeedAttribute;
	import attributes.WeaponPistolAttribute;
	import attributes.WeaponRearAttribute;
	import attributes.WeaponSideAttribute;
	import org.flixel.plugin.photonstorm.FlxSpecialFX;
	import org.flixel.plugin.photonstorm.FX.BlurFX;
	
	/**
	 * ...
	 * @author Jason Hamilton
	 */
	public class Enemy extends Character
	{
		[Embed(source = '../data/shark_red.png')] private var RedSprite:Class;
		[Embed(source = '../data/shark_orange.png')] private var OrangeSprite:Class;
		[Embed(source = '../data/shark_yellow.png')] private var YellowSprite:Class;
		[Embed(source = '../data/shark_green.png')] private var GreenSprite:Class;
		[Embed(source = '../data/shark_purple.png')] private var PurpleSprite:Class;
		[Embed(source = '../data/shark_brown.png')] private var BrownSprite:Class;
		[Embed(source = '../data/shark_pink.png')] private var PinkSprite:Class;
		[Embed(source = '../data/shark_boss.png')] private var BossImgSprite:Class;
		
		// SPRITE INFO
		public static const FRAME_WIDTH:int = 40;
		public static const FRAME_HEIGHT:int = 40;
		
		// DEFAULT STATS
		public static const DEFAULT_SPEED:Number = 50;
		public static const DEFAULT_MAX_SPEED:Number = DEFAULT_SPEED * 2;
		public static const INITIAL_HEALTH:int = 20;
		public static const INITIAL_BOSS_HEALTH:int = 100;
		
		public static const FOLLOW_DISTANCE:Number = FRAME_WIDTH * 5;
		
		// BLINKING
		public var blinkTimer:Number;
		public static const BLINK_TIME:Number = 1;
		
		// ETC
		public var maxspeed:Number;
		
		public var isBoss:Boolean;
		private var shadow:BossShadow;
		
		// Current state
		private var currentState:Function;
		
		/**
		 * Constructor
		 * 
		 * @param	X
		 * @param	Y
		 */
		public function Enemy(X:Number, Y:Number, bulletGroup:FlxGroup, boss:Boolean = false): void
		{
			isBoss = boss;
			super(X, Y);
			
			angle = Math.random() * 360;
			
			loadGraphic(BossImgSprite, true, false, FRAME_WIDTH, FRAME_HEIGHT);

			if (isBoss)
			{
				MAX_HP = health = INITIAL_BOSS_HEALTH;
				shadow = new BossShadow(x, y, this);
				FlxG.state.add(shadow);
			}
			else
			{
				MAX_HP = health = INITIAL_HEALTH;
			}
			
			addAnimation("default", [0]);
			addAnimation("hurt", [0,1], 30);
			
			SPEED = DEFAULT_SPEED;
			maxspeed = DEFAULT_MAX_SPEED;
			
			DEF = 1.25;
			WEAPON_PISTOL = 1;
			WEAPON_SIDE = 0;
			WEAPON_REAR = 0;
			
			this.bulletGroup = bulletGroup;
			
			if (isBoss)
			{
				changeState("followPlayer");
			}
			else
			{
				switch (Math.floor(FlxG.random() * 3))
				{
					default:
						changeState("idle");
						break;
					case 0:
						changeState("spinLeft");
						break;
					case 1:
						changeState("spinRight");
						break;
					case 2:
						changeState("followPlayer");
						break;
				}
			}
			changeState("followPlayer");
			
			ATK = 20;
		}
		
		override public function addAttribute(attribute:Attribute):void
		{
			if (!isBoss)
			{
				if (attribute is AttackAttribute)
				{
					loadGraphic(RedSprite, true, false, FRAME_WIDTH, FRAME_HEIGHT);
				}
				else if (attribute is DefenseAttribute)
				{
					loadGraphic(PurpleSprite, true, false, FRAME_WIDTH, FRAME_HEIGHT);
				}
				else if (attribute is RegenAttribute)
				{
					loadGraphic(OrangeSprite, true, false, FRAME_WIDTH, FRAME_HEIGHT);
				}
				else if (attribute is SpeedAttribute)
				{
					loadGraphic(GreenSprite, true, false, FRAME_WIDTH, FRAME_HEIGHT);
				}
				else if (attribute is WeaponPistolAttribute)
				{
					loadGraphic(YellowSprite, true, false, FRAME_WIDTH, FRAME_HEIGHT);
				}
				else if (attribute is WeaponRearAttribute)
				{
					loadGraphic(BrownSprite, true, false, FRAME_WIDTH, FRAME_HEIGHT);
				}
				else if (attribute is WeaponSideAttribute)
				{
					loadGraphic(PinkSprite, true, false, FRAME_WIDTH, FRAME_HEIGHT);
				}
			}
			super.addAttribute(attribute);
		}
		
		public override function hurt(damage:Number): void
		{
			super.hurt(damage / DEF);
			blinkTimer = BLINK_TIME;
		}
		
		public override function kill():void
		{
			if (isBoss)
			{
				clearAttributes();
				player.transferAttributes(this);
				health = Player.INITIAL_HEALTH;
				revive();
				if (shadow)
				{
					shadow.kill();
				}
				PlayState.win();
			}
			else
			{
				dropItem();
				super.kill();
			}
		}
		
		/**
		 * Change the current state.
		 * Using callbacks for now, until the AI needs something more complex.
		 * 
		 * @param	stateName
		 */
		public function changeState(stateName:String):void
		{
			currentState = this[stateName + "State"];
		}
		
		/**
		 * Call the current state update function.
		 */
		override public function update(): void
		{
			if (blinkTimer > 0)
			{
				blinkTimer = Math.max(blinkTimer - FlxG.elapsed, 0);
				play("hurt");
			}
			else
			{
				play("default");
			}
			currentState();
			super.update();
		}
		
		private function faceVelocity():void
		{
			angle = FlxU.getAngle(velocity, new FlxPoint(0, 0)) + 90;
		}
		
		private function faceDirection(direction:FlxPoint):void
		{
			angle = FlxU.getAngle(direction, new FlxPoint(0, 0)) + 90;
		}
		
		private function get player():Player
		{
			return PlayState.getPlayer();
		}
		
		public function get currentDirection():FlxPoint
		{
			var radians:Number = angle / (180 / Math.PI);
			return new FlxPoint(Math.cos(radians), Math.sin(radians));
		}
		
		// ===================================================================================
		// STATES -- Set currentState to one of these state functions to change the behavior.
		// ===================================================================================
		
		/**
		 * Do nothing.
		 */
		public function idleState(): void
		{
			velocity = VecUtil.scale(currentDirection, SPEED);
			faceVelocity();
			fireWeapons();
			
			var direction:FlxPoint = VecUtil.subtract(player.position, position);
			var distance:Number = VecUtil.length(direction);
			
			if (distance <= FOLLOW_DISTANCE)
			{
				changeState("followPlayer");
			}
		}
		
		/**
		 * Dummy testing state. Spin left!
		 */
		public function spinLeftState():void
		{
			angle -= FlxG.elapsed;
		}
		
		/**
		 * Dummy testing state. Spin right!
		 */
		public function spinRightState():void
		{
			angle += FlxG.elapsed;
		}
		
		/**
		 * Follow the player
		 */
		public function followPlayerState():void
		{
			var direction:FlxPoint = VecUtil.subtract(player.position, position);
			var distance:Number = VecUtil.length(direction);
			
			if (distance > FOLLOW_DISTANCE)
			{
				velocity.x = 0;
				velocity.y = 0;
				changeState("idle");
				return;
			}
			
			// Normalize the direction
			direction = VecUtil.scale(direction, 1 / distance);
			
			if (distance > FRAME_HEIGHT)
			{
				velocity = VecUtil.scale(direction, SPEED);
				faceVelocity();
			}
			else
			{
				velocity.x = 0;
				velocity.y = 0;
				faceDirection(direction);
			}
			
			fireWeapons();
		}
		
		public function fireWeapons():void
		{
			var direction:FlxPoint = VecUtil.subtract(player.position, position);
			var distance:Number = VecUtil.length(direction);
			
			if (isBoss || distance < FOLLOW_DISTANCE * 1.5)
			{
				for (var i:Number = 0; i < weapons.length; i++)
				{
					var weapon:Weapon = weapons.members[i];
					weapon.update();
					weapon.fireAngle(angle, 0, 0);
				}
			}
		}
	}
}