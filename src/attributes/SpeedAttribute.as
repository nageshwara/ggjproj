package attributes 
{
	/**
	 * ...
	 * @author Jason Hamilton
	 */
	public class SpeedAttribute extends Attribute
	{
		public static var SPEED_BOOST:Number = 1;
		
		public function SpeedAttribute() 
		{
			super();
		}
		
		override public function onAdd(character:Character):void
		{
			character.speed += SPEED_BOOST;
		}
		
		override public function onRemove(character:Character):void
		{
			character.speed -= SPEED_BOOST;
		}
	}

}