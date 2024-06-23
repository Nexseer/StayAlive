#[dojo::interface]
trait INameSystem {
    fn set_name(ref world: IWorldDispatcher, player_name: felt252);
}

#[dojo::contract]
mod name_system {
    use super::INameSystem;
    use starknet::{ContractAddress, get_caller_address};
    use stay_alive::models::name::Name;

    #[abi(embed_v0)]
    impl NameSystemImpl of INameSystem<ContractState> {
        fn set_name(ref world: IWorldDispatcher, player_name: felt252) {
            let address = get_caller_address();
            set!(world, Name { player: address, name: player_name });
        }
    }
}