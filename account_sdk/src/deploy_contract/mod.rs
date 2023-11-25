pub(crate) mod declaration;
mod deployment;
mod pending;
pub use declaration::CustomAccountDeclaration;
pub use deployment::CustomAccountDeployment;
pub use deployment::DeployResult;
use lazy_static::lazy_static;
use starknet::core::types::FieldElement;
use starknet::macros::felt;
use starknet::signers::SigningKey;

lazy_static! {
    pub static ref UDC_ADDRESS: FieldElement =
        felt!("0x041a78e741e5af2fec34b695679bc6891742439f7afb8484ecd7766661ad02bf");
    pub static ref FEE_TOKEN_ADDRESS: FieldElement =
        felt!("0x049d36570d4e46f48e99674bd3fcc84644ddd6b96f7c741b1562b82f9e004dc7");
    pub static ref ERC20_CONTRACT_CLASS_HASH: FieldElement =
        felt!("0x02a8846878b6ad1f54f6ba46f5f40e11cee755c677f130b2c4b60566c9003f1f");
    pub static ref CHAIN_ID: FieldElement =
        felt!("0x00000000000000000000000000000000000000000000000000004b4154414e41");
    pub static ref PREFUNDED: (SigningKey, FieldElement) = (
        SigningKey::from_secret_scalar(
            FieldElement::from_hex_be(
                "0x1800000000300000180000000000030000000000003006001800006600"
            )
            .unwrap(),
        ),
        FieldElement::from_hex_be(
            "0x517ececd29116499f4a1b64b094da79ba08dfd54a3edaa316134c41f8160973",
        )
        .unwrap()
    );
}
