pub mod account {
    use cainome::rs::abigen;

    abigen!(
        CartridgeAccount,
        "./abi/account.abi.json",
        type_aliases {
            openzeppelin::introspection::src5::SRC5::Event as SRC5Event;
        }
    );
}

pub mod erc20 {
    use cainome::rs::abigen;

    abigen!(Erc20Contract, "./abi/erc20.abi.json");
}
