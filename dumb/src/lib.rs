use hs_bindgen::*;

#[hs_bindgen]
#[allow(clippy::too_many_arguments, clippy::just_underscores_and_digits)]
pub fn sum10(_0: i32, _1: i32, _2: i32, _3: i32, _4: i32, _5: i32, _6: i32, _7: i32, _8: i32, _9: i32) -> i32 {
    _0 + _1 + _2 + _3 + _4 + _5 + _6 + _7 + _8 + _9
}
