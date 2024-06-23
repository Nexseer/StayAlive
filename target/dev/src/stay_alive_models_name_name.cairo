impl NameIntrospect<> of dojo::database::introspect::Introspect<Name<>> {
    #[inline(always)]
    fn size() -> Option<usize> {
        Option::Some(1)
    }

    fn layout() -> dojo::database::introspect::Layout {
        dojo::database::introspect::Layout::Struct(
            array![
                dojo::database::introspect::FieldLayout {
                    selector: 1528802474226268325865027367859591458315299653151958663884057507666229546336,
                    layout: dojo::database::introspect::Introspect::<felt252>::layout()
                }
            ]
                .span()
        )
    }

    #[inline(always)]
    fn ty() -> dojo::database::introspect::Ty {
        dojo::database::introspect::Ty::Struct(
            dojo::database::introspect::Struct {
                name: 'Name',
                attrs: array![].span(),
                children: array![
                    dojo::database::introspect::Member {
                        name: 'player',
                        attrs: array!['key'].span(),
                        ty: dojo::database::introspect::Introspect::<ContractAddress>::ty()
                    },
                    dojo::database::introspect::Member {
                        name: 'name',
                        attrs: array![].span(),
                        ty: dojo::database::introspect::Introspect::<felt252>::ty()
                    }
                ]
                    .span()
            }
        )
    }
}

impl NameModel of dojo::model::Model<Name> {
    fn entity(
        world: dojo::world::IWorldDispatcher,
        keys: Span<felt252>,
        layout: dojo::database::introspect::Layout
    ) -> Name {
        let values = dojo::world::IWorldDispatcherTrait::entity(
            world,
            856189493329990839519828887223040651913360042840125527820329955812485989839,
            keys,
            layout
        );

        // TODO: Generate method to deserialize from keys / values directly to avoid
        // serializing to intermediate array.
        let mut serialized = core::array::ArrayTrait::new();
        core::array::serialize_array_helper(keys, ref serialized);
        core::array::serialize_array_helper(values, ref serialized);
        let mut serialized = core::array::ArrayTrait::span(@serialized);

        let entity = core::serde::Serde::<Name>::deserialize(ref serialized);

        if core::option::OptionTrait::<Name>::is_none(@entity) {
            panic!(
                "Model `Name`: deserialization failed. Ensure the length of the keys tuple is matching the number of #[key] fields in the model struct."
            );
        }

        core::option::OptionTrait::<Name>::unwrap(entity)
    }

    #[inline(always)]
    fn name() -> ByteArray {
        "Name"
    }

    #[inline(always)]
    fn version() -> u8 {
        1
    }

    #[inline(always)]
    fn selector() -> felt252 {
        856189493329990839519828887223040651913360042840125527820329955812485989839
    }

    #[inline(always)]
    fn instance_selector(self: @Name) -> felt252 {
        Self::selector()
    }

    #[inline(always)]
    fn keys(self: @Name) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(self.player, ref serialized);
        core::array::ArrayTrait::span(@serialized)
    }

    #[inline(always)]
    fn values(self: @Name) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::array::ArrayTrait::append(ref serialized, *self.name);
        core::array::ArrayTrait::span(@serialized)
    }

    #[inline(always)]
    fn layout() -> dojo::database::introspect::Layout {
        dojo::database::introspect::Introspect::<Name>::layout()
    }

    #[inline(always)]
    fn instance_layout(self: @Name) -> dojo::database::introspect::Layout {
        Self::layout()
    }

    #[inline(always)]
    fn packed_size() -> Option<usize> {
        let layout = Self::layout();

        match layout {
            dojo::database::introspect::Layout::Fixed(layout) => {
                let mut span_layout = layout;
                Option::Some(dojo::packing::calculate_packed_size(ref span_layout))
            },
            dojo::database::introspect::Layout::Struct(_) => Option::None,
            dojo::database::introspect::Layout::Array(_) => Option::None,
            dojo::database::introspect::Layout::Tuple(_) => Option::None,
            dojo::database::introspect::Layout::Enum(_) => Option::None,
            dojo::database::introspect::Layout::ByteArray => Option::None,
        }
    }
}

#[starknet::interface]
trait Iname<T> {
    fn ensure_abi(self: @T, model: Name);
}

#[starknet::contract]
mod name {
    use super::Name;
    use super::Iname;

    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl DojoModelImpl of dojo::model::IModel<ContractState> {
        fn selector(self: @ContractState) -> felt252 {
            dojo::model::Model::<Name>::selector()
        }

        fn name(self: @ContractState) -> ByteArray {
            dojo::model::Model::<Name>::name()
        }

        fn version(self: @ContractState) -> u8 {
            dojo::model::Model::<Name>::version()
        }

        fn unpacked_size(self: @ContractState) -> Option<usize> {
            dojo::database::introspect::Introspect::<Name>::size()
        }

        fn packed_size(self: @ContractState) -> Option<usize> {
            dojo::model::Model::<Name>::packed_size()
        }

        fn layout(self: @ContractState) -> dojo::database::introspect::Layout {
            dojo::model::Model::<Name>::layout()
        }

        fn schema(self: @ContractState) -> dojo::database::introspect::Ty {
            dojo::database::introspect::Introspect::<Name>::ty()
        }
    }

    #[abi(embed_v0)]
    impl nameImpl of Iname<ContractState> {
        fn ensure_abi(self: @ContractState, model: Name) {}
    }
}
