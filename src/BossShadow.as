package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author 
	 */
	public class BossShadow extends FlxSprite
	{
		[Embed(source = '../data/shark_boss.png')] private var BossImgSprite:Class;
		private var boss:FlxSprite;
		
		public function BossShadow(x:Number, y:Number, boss:FlxSprite) 
		{
			this.boss = boss;
			loadGraphic(BossImgSprite, false, false, 40, 40);
			
			color = 0x000000;
			alpha = 0.32;
			scale.x = 15;
			scale.y = 15;
		}
		
		public override function update(): void
		{
			x = boss.x;
			y = boss.y;
			angle = boss.angle;
		}
	}

}