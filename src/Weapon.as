package  
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxGroup;
	import org.flixel.FlxU;
	import org.flixel.plugin.photonstorm.*;
	
	/**
	 * ...
	 * @author Doug Macdonald
	 */
	
	public class Weapon
	{
		private var weapon:FlxWeapon; 
		[Embed(source = '../data/bullet_pistol.png')] private var ImgBullet1:Class;
		
		public function Weapon(parent:FlxSprite, bulletGroup:FlxGroup, image:Number, speed:Number, fireRate:Number, maxBullets:Number ) 
		{
			weapon = new FlxWeapon("weapon", parent, "x", "y");
			var bulletType:Class;
			
			switch (image)
			{
				case 1:
				default:
					{
						bulletType = ImgBullet1;
					}
			}
			
			weapon.makeImageBullet(maxBullets, bulletType);
			weapon.setBulletSpeed(speed);
			weapon.setFireRate(fireRate);
			bulletGroup.add(weapon.group);
		}
		
		public function fireAngle(angle:Number, offsetX:Number=0, offsetY:Number=0): void
		{
			weapon.setBulletOffset(offsetX, offsetY);
			weapon.fireFromAngle(angle);
		}
		
		public function fireVector(vector:FlxPoint, offsetX:Number=0, offsetY:Number=0): void
		{
			fireAngle(FlxU.getAngle(vector, new FlxPoint(0, 0)) + 90, offsetX, offsetY);
		}
	}

}