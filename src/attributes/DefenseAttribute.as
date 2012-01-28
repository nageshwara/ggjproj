package attributes 
{
	/**
	 * ...
	 * @author Doug Macdonald
	 */
	public class DefenseAttribute extends Attribute
	{
		public static var DEFENSE_BOOST:Number = 10;
		
		public function DefenseAttribute() 
		{
			super();
			attributeType = ATT_DEF;
		}
		
		override public function onAdd(character:Character):void
		{
			character.DEF += DEFENSE_BOOST;
		}
		
		override public function onRemove(character:Character):void
		{
			character.DEF -= DEFENSE_BOOST;
		}
	}

}