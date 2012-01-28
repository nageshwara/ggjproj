package  
{
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxGroup;
	import org.flixel.FlxU;
	import org.flixel.FlxG;
	import org.flixel.plugin.photonstorm.*;
	import Character;
	
	/**
	 * ...
	 * @author Doug Macdonald
	 */
	
	public class Weapon extends FlxObject
	{
		private var weapon:FlxWeapon; 
		[Embed(source = '../data/bullet_pistol.png')] private var ImgBulletPistol:Class;
		[Embed(source = '../data/bullet_side.png')] private var ImgBulletSide:Class;
		[Embed(source = '../data/bullet_rear.png')] private var ImgBulletRear:Class;
		
		public var weaponType:Number
		public const T_PISTOL:Number = 1;
		public const T_SIDE:Number = 2;
		public const T_REAR:Number = 3;
		
		private var parent:Character;
		
		private var fireTimer:Number;
		private var fireDelay:Number;
		
		public function Weapon(parent:Character, bulletGroup:FlxGroup, type:Number, speed:Number, fireRate:Number, maxBullets:Number ) 
		{
			weapon = new FlxWeapon("weapon", parent, "x", "y");
			var bulletType:Class;
			switch (type)
			{
				case T_PISTOL:
				default:
					{
						bulletType = ImgBulletPistol;
					}
					break;
				case T_REAR:
					{
						bulletType = ImgBulletRear;
					}
					break;
				case T_SIDE:
					{
						bulletType = ImgBulletSide;
					}
					break;
			}
			weaponType = type;
			this.parent = parent;
			
			weapon.makeImageBullet(maxBullets, bulletType);
			weapon.setBulletSpeed(speed);
			fireDelay = fireRate / 100;
			fireTimer = 0;
			bulletGroup.add(weapon.group);
		}
		
		public function fireAngle(angle:Number, offsetX:Number=0, offsetY:Number=0): void
		{
			if (fireTimer == 0)
			{
				var originX:Number = parent.frameWidth / 2;
				var originY:Number = parent.frameHeight / 2;
				if (weaponType == T_REAR)
				{
					weapon.setBulletOffset( originX - offsetX, originY - offsetY);
					weapon.fireFromAngle(angle + 180);
					weapon.currentBullet.ATK = parent.ATK;
				}
				else if (weaponType == T_SIDE)
				{
					weapon.setBulletOffset(originX, originY);
					weapon.fireFromAngle(angle + 90);
					weapon.currentBullet.ATK = parent.ATK;
					weapon.fireFromAngle(angle + 270);
					weapon.currentBullet.ATK = parent.ATK;
				}
				else
				{
					weapon.setBulletOffset(originX + offsetX, originY + offsetY);
					weapon.fireFromAngle(angle);
					weapon.currentBullet.ATK = parent.ATK;
				}
				fireTimer = fireDelay;
			}
		}
		
		public function fireVector(vector:FlxPoint, offsetX:Number=0, offsetY:Number=0): void
		{
			fireAngle(FlxU.getAngle(vector, new FlxPoint(0, 0)) + 90, offsetX, offsetY);
		}
		
		public override function update(): void
		{
			if (fireTimer > 0)
			{
				fireTimer -= FlxG.elapsed;
			}
			if (fireTimer < 0)
			{
				fireTimer = 0;
			}
		}
	}

}