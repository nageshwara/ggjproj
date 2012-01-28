package attributes 
{
	/**
	 * ...
	 * @author Doug Macdonald
	 */
	public class WeaponPistolAttribute extends Attribute
	{
		public static var PISTOL_BOOST:Number = 1;
		
		public function WeaponPistolAttribute() 
		{
			super();
			attributeType = ATT_PISTOL;
		}
		
		override public function onAdd(character:Character):void
		{
			character.WEAPON_PISTOL += PISTOL_BOOST;
		}
		
		override public function onRemove(character:Character):void
		{
			character.WEAPON_PISTOL -= PISTOL_BOOST;
		}
	}

}