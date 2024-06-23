use starknet::ContractAddress;

#[derive(Copy, Drop, Serde)]
#[dojo::model]
struct Name {
    #[key]
    player: ContractAddress,
    name: felt252,
}