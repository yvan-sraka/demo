use hs_bindgen::*;

#[hs_bindgen]
#[allow(clippy::too_many_arguments, clippy::just_underscores_and_digits, clippy::needless_return)]
pub extern "C" fn sum10(_0: u8, _1: u8, _2: u8, _3: u8, _4: u8, _5: u8, _6: u8, _7: u8, _8: u8, _9: u8) {
    println!("{}", _0);  
    println!("{}", _1);
    println!("{}", _2);
    println!("{}", _3);
    println!("{}", _4);
    println!("{}", _5);
    println!("{}", _6);
    println!("{}", _7);
    println!("{}", _8);
    println!("{}", _9);
}
