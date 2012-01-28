package attributes 
{
	/**
	 * ...
	 * @author Doug Macdonald
	 */
	public class WeaponRearAttribute extends Attribute
	{
		public static var REAR_BOOST:Number = 1;
		
		public function WeaponRearAttribute() 
		{
			super();
			attributeType = ATT_REAR;
		}
		
		override public function get name():String
		{
			return "REAR ATK UP";
		}
		
		override public function onAdd(character:Character):void
		{
			character.WEAPON_REAR += REAR_BOOST;
		}
		
		override public function onRemove(character:Character):void
		{
			character.WEAPON_REAR -= REAR_BOOST;
		}
	}

}