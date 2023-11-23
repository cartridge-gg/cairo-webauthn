use crate::suppliers::{
    katana::KatanaSupplier, katana_runner::KatanaRunner, AccountData, PrefoundedClientSupplier,
};

#[tokio::test]
async fn test_account_data_public_key() {
    let runner = KatanaRunner::load();
    let supplier = KatanaSupplier::from(&runner);
    let account = supplier.prefounded_account();
    assert_eq!(
        AccountData::new(account.account_address, account.private_key).public_key,
        account.public_key
    );
}
