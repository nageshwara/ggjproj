package  
{
	import org.flixel.FlxText;
	/**
	 * ...
	 * @author Jason Hamilton
	 */
	public class DropText extends FlxText
	{
		public function DropText(x:int, y:int, text:String) 
		{
			super(x, y, 200, text);
			alignment = "center";
			x -= 100;
		}
		
		override public function update():void
		{
			super.update();
			scale.x += 0.0125;
			scale.y += 0.0125;
			alpha = Math.max(0, alpha - 0.0125);
			
			if (alpha <= 0)
			{
				kill();
			}
		}
	}
}