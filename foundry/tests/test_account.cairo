
use webauthn_foundry::Account;
use webauthn_foundry::Account::{TRANSACTION_VERSION, QUERY_VERSION};

use webauthn_foundry::interface::AccountABIDispatcher;
use webauthn_foundry::interface::AccountABIDispatcherTrait;
use openzeppelin::token::erc20::interface::IERC20Dispatcher;
use openzeppelin::token::erc20::interface::IERC20DispatcherTrait;

use openzeppelin::utils::serde::SerializedAppend;
use openzeppelin::utils::selectors;

use snforge_std::{ 
    declare, 
    ContractClassTrait, 
    TxInfoMock, 
    TxInfoMockTrait,
    start_spoof
};

use starknet::ContractAddress;
use starknet::contract_address_const;
use starknet::account::Call;
use starknet::testing;
use starknet::testing::set_signature;

use debug::PrintTrait;

const PUBLIC_KEY: felt252 = 0x333333;
const NEW_PUBKEY: felt252 = 0x789789;
const SALT: felt252 = 123;

#[derive(Drop)]
struct SignedTransactionData {
    private_key: felt252,
    public_key: felt252,
    transaction_hash: felt252,
    r: felt252,
    s: felt252
}

fn STATE() -> Account::ContractState {
    Account::contract_state_for_testing()
}
fn CLASS_HASH() -> felt252 {
    Account::TEST_CLASS_HASH
}
fn ACCOUNT_ADDRESS() -> ContractAddress {
    contract_address_const::<0x111111>()
}
fn SIGNED_TX_DATA() -> SignedTransactionData {
    SignedTransactionData {
        private_key: 1234,
        public_key: 883045738439352841478194533192765345509759306772397516907181243450667673002,
        transaction_hash: 2717105892474786771566982177444710571376803476229898722748888396642649184538,
        r: 3068558690657879390136740086327753007413919701043650133111397282816679110801,
        s: 3355728545224320878895493649495491771252432631648740019139167265522817576501
    }
}

#[derive(Drop)]
struct ERC20ConstructorArguments{
    name: felt252,
    symbol: felt252,
    initial_supply: u256,
    recipient: ContractAddress
}

#[generate_trait]
impl ERC20ConstructorArgumentsImpl of ERC20ConstructorArgumentsTrait {
    fn new(recipient: ContractAddress, initial_supply: u256) -> ERC20ConstructorArguments {
        ERC20ConstructorArguments{
            name: 0_felt252,
            symbol: 0_felt252,
            initial_supply: initial_supply,
            recipient: recipient
        }
    }
    fn to_calldata(self: ERC20ConstructorArguments) -> Array<felt252>{
        let mut calldata = array![];
        calldata.append_serde(self.name);
        calldata.append_serde(self.symbol);
        calldata.append_serde(self.initial_supply);
        calldata.append_serde(self.recipient);
        calldata
    }
}

#[derive(Drop)]
struct TransferCall{
    erc20: ContractAddress,
    recipient: ContractAddress,
    amount: u256,
}


#[generate_trait]
impl TransferCallImpl of TransferCallTrait {
    fn to_call(self: TransferCall) -> Call {
        let mut calldata = array![];
        calldata.append_serde(self.recipient);
        calldata.append_serde(self.amount);
        Call {
            to: self.erc20, 
            selector: selectors::transfer, 
            calldata: calldata
        }
    }
}

#[test]
fn test_account() {
    let data = SIGNED_TX_DATA();

    let account_address = declare('Account')
        .deploy(@array![data.public_key])
        .unwrap();
    
    // Account associated with the account_address will have 1000 tokens assigned.
    let constructor_args = ERC20ConstructorArgumentsImpl::new(account_address, 1000);
    
    let erc20_address = declare('ERC20')
        .deploy(@constructor_args.to_calldata())
        .unwrap();
    let account = AccountABIDispatcher { 
        contract_address: account_address 
    };
    let erc20 = IERC20Dispatcher { 
        contract_address: erc20_address 
    };
    
    // Mock the transaction version
    let mut tx_info = TxInfoMockTrait::default();
    tx_info.version = Option::Some(TRANSACTION_VERSION);
    start_spoof(account_address, tx_info);

    assert(
        erc20.balance_of(account_address) == 1000, 
        'Initial balance should be equal'
    );

    let recipient = contract_address_const::<0x123>();
    let call = TransferCall {
        erc20: erc20_address,
        recipient: recipient,
        amount: 200
    }.to_call();
    let ret = account.__execute__(array![call]);

    // Verify that the transfer of tokens was succesful
    assert(erc20.balance_of(account_address) == 800, 'Should have remained');
    assert(erc20.balance_of(recipient) == 200, 'Should have transferred');
}