import Test.DocTest

main :: IO ()
main = doctest ["src/doctest/Square.hs", "src/doctest/Printer.hs"]
