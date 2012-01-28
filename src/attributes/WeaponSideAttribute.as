package attributes 
{
	/**
	 * ...
	 * @author Doug Macdonald
	 */
	public class WeaponSideAttribute extends Attribute
	{
		public static var SIDE_BOOST:Number = 1;
		
		public function WeaponSideAttribute() 
		{
			super();
			attributeType = ATT_SIDE;
		}
		
		override public function get name():String
		{
			return "SIDE ATK UP";
		}
		
		override public function onAdd(character:Character):void
		{
			character.WEAPON_SIDE += SIDE_BOOST;
		}
		
		override public function onRemove(character:Character):void
		{
			character.WEAPON_SIDE -= SIDE_BOOST;
		}
	}

}