use stay_alive::models::player::CharacterType;

#[dojo::interface]
trait IPlayerSystem {
    fn new_role(ref world: IWorldDispatcher, character_type: CharacterType);
}

#[dojo::contract]
mod player_system {
    use super::IPlayerSystem;
    use stay_alive::models::player::{Player, PlayerTrait, CharacterType};

    #[abi(embed_v0)]
    impl PlayerSystemImpl of IPlayerSystem<ContractState> {
        fn new_role(ref world: IWorldDispatcher, character_type: CharacterType) {
            set!(world, (PlayerTrait::select_type(character_type)));
        }
    }
}