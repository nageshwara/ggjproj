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
			updateWeapon(character);
		}
		
		override public function onRemove(character:Character):void
		{
			character.WEAPON_REAR -= REAR_BOOST;
			updateWeapon(character);
		}
		
				
		public function updateWeapon(character:Character)
		{
			var newRear:Weapon;
			if (character.wpnRear)
			{
				character.weapons.remove(character.wpnRear, true)
				character.wpnRear = 0;
			}
			if (Character.WEAPON_REAR > 0)
			{
				var newRear:Weapon = new Weapon(this, character.bulletGroup, 3, 100 + 25 * WEAPON_REAR, 100 + 25 * WEAPON_REAR, 50);
				character.weapons.add(newRear);
				character.wpnRear = newRear;	
			}
		}
	}

}