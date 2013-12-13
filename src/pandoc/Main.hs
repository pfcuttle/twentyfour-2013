module Main where

import Text.Blaze.Html
import Text.Blaze.Html.Renderer.Pretty
import Text.Pandoc


textToConvert :: String
textToConvert = unlines
    [ "Hello, world!\n"
    , "    this is a Markdown code block\n"
    , "[This is a link](http://www.latermuse.com/)\n"
    ]


pandocParsed :: Pandoc
pandocParsed = readMarkdown def textToConvert


pandocConverted :: String
pandocConverted = writeLaTeX def pandocParsed


convertedToHtml :: Html
convertedToHtml = writeHtml def pandocParsed


convertedToOpenDocument :: String
convertedToOpenDocument = writeOpenDocument opts pandocParsed
  where
    opts = def
        { writerWrapText = True
        , writerColumns = 80
        }


main :: IO ()
main = do
    print pandocParsed

    mapM_ putStrLn
        [ pandocConverted
        , renderHtml convertedToHtml
        , convertedToOpenDocument
        ]
