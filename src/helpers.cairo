use array::ArrayTrait;
use traits::PartialEq;
use traits::Into;
use clone::Clone;
use webauthn::types::PublicKeyCredentialDescriptor;
use webauthn::types::PublicKeyCredential;
use webauthn::types::CollectedClientData;
use webauthn::types::DomString;


// TODO: test
fn arrays_equal
<T, impl TPartialEqImpl: PartialEq<T>, impl TDrop: Drop<T>>
(a: @Array<T>, b: @Array<T>) -> bool{
    let la: usize = a.len();
    let lb: usize = b.len();
    assert(la == lb, 'different len');
    let mut i: usize = 0;
    loop {
        if i == la {
            break true;
        }
        if a.at(i) != b.at(i) {
            break false;
        }
        i += 1_usize;
    }
}

impl PartialEqArray<T, impl TEq: PartialEq<T>, impl TDrop: Drop<T>> of PartialEq<Array<T>> {
    fn eq(lhs: @Array<T>, rhs: @Array<T>) -> bool {
        arrays_equal(lhs, rhs)
    }
    fn ne(lhs: @Array<T>, rhs: @Array<T>) -> bool {
        !arrays_equal(lhs, rhs)
    }
}


trait ContainsTrait<A, T> {
    fn contain(self: @A, item: @T) -> bool;
}


impl ArrayTContainsImpl<T, impl Teq: PartialEq<T>> of ContainsTrait<Array<T>, T>{
    fn contain(self: @Array<T>, item: @T) -> bool{
        let la: usize = self.len();
        let mut i: usize = 0;
        loop {
            if i == la {
                break false;
            }
            if self.at(i) == item {
                break true;
            }
            i += 1_usize;
        }
    }
}

trait MapTrait<S, T> {
    fn map(self: Array<S>) -> Array<T>;
}

impl ImplIntoMap<
    S, 
    T, 
    impl IntoTS: Into<S, T>, 
    impl TDrop: Drop<T>, 
    impl SDrop: Drop<S>
> of MapTrait<S, T> {
    fn map(mut self: Array<S>) -> Array<T>{
        let mut target: Array<T> = ArrayTrait::new();
        loop {
            match self.pop_front() {
                Option::Some(i) => target.append(i.into()),
                Option::None => {
                    break;
                }
            };
        };
        target
    }
}

impl ImplPublicKeyCredentialDescriptorIntoArrayu8 
of Into<PublicKeyCredentialDescriptor, Array<u16>> {
    fn into(self: PublicKeyCredentialDescriptor) -> Array<u16>{
        self.id
    }
}

fn allow_credentials_contain_credential(
    options: @Array<PublicKeyCredentialDescriptor>,
    credential: @PublicKeyCredential,
) -> bool {
    let ids: Array<Array<u16>> = options.clone().map();
    ids.contain(credential.id)
}


#[derive(Drop, Clone)]
struct MyString{

}

trait UTF8Decoder{
    fn decode(data: Array<u8>) -> MyString;
}

trait JSONClientDataParser{
    fn parse(string: MyString) -> CollectedClientData;
}

trait OriginChecker {
    fn check(string: DomString) -> bool;
}
