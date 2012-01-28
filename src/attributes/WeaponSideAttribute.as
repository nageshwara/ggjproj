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
			updateWeapon(character);
		}
		
		override public function onRemove(character:Character):void
		{
			character.WEAPON_SIDE -= SIDE_BOOST;
			updateWeapon(character);
		}
						
		public function updateWeapon()
		{
			var newSide:Weapon;
			if (character.wpnSide)
			{
				character.weapons.remove(character.wpnSide, true);
				character.wpnSide = 0;
			}
			if (Character.WEAPON_REAR > 0)
			{
				var newSide:Weapon = new Weapon(this, character.bulletGroup, 2, 100 + 25 * WEAPON_SIDE, 100 + 25 * WEAPON_SIDE, 50);
				character.weapons.add(newSide);
				character.wpnSide = newSide;	
			}
		}
	}

}