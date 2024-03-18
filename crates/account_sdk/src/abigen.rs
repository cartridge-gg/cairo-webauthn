pub mod account {
    use cainome::rs::abigen;

    abigen!(
        CartridgeAccount,
        include_str!("../compiled/account.contract_class.json"),
        type_aliases {
            webauthn_session::session_component::Event as SessionComponentEvent;
            webauthn_auth::component::webauthn_component::Event as WebauthnComponentEvent;
        }
    );
}

pub mod erc20 {
    use cainome::rs::abigen;
    abigen!(
        Erc20Contract,
        include_str!("../compiled/erc20.contract_class.json"),
        type_aliases {
            openzeppelin::token::erc20::erc20::ERC20Component::Event as ERC20ComponentEvent;
            openzeppelin::access::ownable::ownable::OwnableComponent::Event as OwnableComponentEvent;
        }
    );
}
