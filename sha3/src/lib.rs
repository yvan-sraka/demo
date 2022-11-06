//! This is just a trivial wrapper arround https://crates.io/crates/sha3 crate
//! that offers SHA-3 (Keccak) hash function:

use hs_bindgen::*;
use sha3::{Digest, Keccak256, Sha3_256};

#[hs_bindgen]
fn keccak_256(message: String) -> Vec<u8> {
    let mut hasher = Keccak256::new();
    hasher.update(message);
    hasher.finalize().to_vec()
}

#[hs_bindgen]
fn sha3_256(message: String) -> Vec<u8> {
    let mut hasher = Sha3_256::new();
    hasher.update(message);
    hasher.finalize().to_vec()
}
