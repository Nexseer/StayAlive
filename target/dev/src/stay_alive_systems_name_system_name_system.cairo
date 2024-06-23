#[starknet::contract]
mod name_system {
    use dojo::world;
    use dojo::world::IWorldDispatcher;
    use dojo::world::IWorldDispatcherTrait;
    use dojo::world::IWorldProvider;
    use dojo::world::IDojoResourceProvider;


    component!(
        path: dojo::components::upgradeable::upgradeable,
        storage: upgradeable,
        event: UpgradeableEvent
    );

    #[abi(embed_v0)]
    impl DojoResourceProviderImpl of IDojoResourceProvider<ContractState> {
        fn dojo_resource(self: @ContractState) -> felt252 {
            'name_system'
        }
    }

    #[abi(embed_v0)]
    impl WorldProviderImpl of IWorldProvider<ContractState> {
        fn world(self: @ContractState) -> IWorldDispatcher {
            self.world_dispatcher.read()
        }
    }

    #[abi(embed_v0)]
    impl UpgradableImpl =
        dojo::components::upgradeable::upgradeable::UpgradableImpl<ContractState>;

    use super::INameSystem;
    use starknet::{ContractAddress, get_caller_address};
    use stay_alive::models::name::Name;

    #[abi(embed_v0)]
    impl NameSystemImpl of INameSystem<ContractState> {
        fn set_name(ref self: ContractState, player_name: felt252) {
            let world = self.world_dispatcher.read();
            let address = get_caller_address();
            set!(world, Name { player: address, name: player_name });
        }
    }

    #[starknet::interface]
    trait IDojoInit<ContractState> {
        fn dojo_init(self: @ContractState);
    }

    #[abi(embed_v0)]
    impl IDojoInitImpl of IDojoInit<ContractState> {
        fn dojo_init(self: @ContractState) {
            assert(
                starknet::get_caller_address() == self.world().contract_address,
                'Only world can init'
            );
        }
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        UpgradeableEvent: dojo::components::upgradeable::upgradeable::Event,
    }

    #[storage]
    struct Storage {
        world_dispatcher: IWorldDispatcher,
        #[substorage(v0)]
        upgradeable: dojo::components::upgradeable::upgradeable::Storage,
    }
}

