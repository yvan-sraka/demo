module Main where

import Foreign (Ptr, peekArray, Storable, free)
import Foreign.C.String (withCString)
import Foreign.C.Types (CUChar)
import Foreign.Marshal (peekArray, free)
import Foreign.Ptr (Ptr)
import Numeric (showHex)
import Sha3 (keccak_256, sha3_256)

-- FIXME: use https://hackage.haskell.org/package/bytestring
type Hash = [CUChar]

-- FIXME: use https://hackage.haskell.org/package/base/docs/Text-Printf.html
fmtHash :: Hash -> String
fmtHash = foldr (\ x -> (++) (showHex x ":")) ""

-- FIXME: double check that without this, memory is leaked ... 
peekArrayAndFree :: Storable a => Int -> Ptr a -> IO [a]
peekArrayAndFree size ptr = do
    vals <- peekArray size ptr
    free ptr
    return vals

sha3 :: String -> IO Hash
sha3 s = peekArrayAndFree 32 =<< withCString s sha3_256

keccak :: String -> IO Hash
keccak s = peekArrayAndFree 32 =<< withCString s keccak_256

main :: IO ()
main = do
    hash <- sha3 "Hello, Rust 🦀!"
    putStrLn $ fmtHash hash
