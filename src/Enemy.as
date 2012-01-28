package  
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxU;
	import org.flixel.FlxG;
	import attributes.*;
	/**
	 * ...
	 * @author Jason Hamilton
	 */
	public class Enemy extends Character
	{
		[Embed(source = '../data/shark_red.png')] private var ImgSprite:Class;
		[Embed(source = '../data/shark_boss.png')] private var BossImgSprite:Class;
		
		// SPRITE INFO
		public static const FRAME_WIDTH:int = 40;
		public static const FRAME_HEIGHT:int = 40;
		
		// DEFAULT STATS
		public static const DEFAULT_SPEED:Number = 50;
		public static const DEFAULT_MAX_SPEED:Number = DEFAULT_SPEED * 2;
		public static const INITIAL_HEALTH:int = 20;
		
		// BLINKING
		public var blinkTimer:Number;
		public static const BLINK_TIME:Number = 1;
		
		// ETC
		public var maxspeed:Number;
		
		public var isBoss:Boolean;
		
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
			
			if (isBoss)
			{
				loadGraphic(BossImgSprite, true, false, FRAME_WIDTH, FRAME_HEIGHT);
			}
			else
			{
				loadGraphic(ImgSprite, true, false, FRAME_WIDTH, FRAME_HEIGHT);
			}
			addAnimation("default", [0]);
			addAnimation("hurt", [0,1], 30);
			
			SPEED = DEFAULT_SPEED;
			maxspeed = DEFAULT_MAX_SPEED;
			MAX_HP = health = INITIAL_HEALTH;
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
				addAttribute(new AttackAttribute);
			}
			
			ATK = 20;
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
				player.transferAttributes(this);
				health = Player.INITIAL_HEALTH;
				revive();
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
		
		public function get direction():FlxPoint
		{
			return new FlxPoint(Math.cos(angle), Math.sin(angle));
		}
		
		// ===================================================================================
		// STATES -- Set currentState to one of these state functions to change the behavior.
		// ===================================================================================
		
		/**
		 * Do nothing.
		 */
		public function idleState(): void
		{
		}
		
		/**
		 * Dummy testing state. Spin left!
		 */
		public function spinLeftState():void
		{
			angle -= 1;
		}
		
		/**
		 * Dummy testing state. Spin right!
		 */
		public function spinRightState():void
		{
			angle += 1;
		}
		
		/**
		 * Follow the player
		 */
		public function followPlayerState():void
		{
			var direction:FlxPoint = VecUtil.subtract(player.position, position);
			var distance:Number = VecUtil.length(direction);
			
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
			for (var i:Number = 0; i < weapons.members.length-1; i++)
			{
				var weapon:Weapon = weapons.members[i];
				weapon.update();
				weapon.fireVector(direction, width/2 * direction.x, height/2 * direction.y);
			}
		}
	}

}