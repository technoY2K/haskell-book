module Thirteen.Hangman where

import           Control.Monad (forever)
import           Data.Char     (toLower)
import           Data.List     (intersperse)
import           Data.Maybe    (isJust)
import           System.Exit   (exitSuccess)
import           System.Random (randomRIO)

type WordList = [String]

minWordLength :: Int
minWordLength = 5

maxWordLength :: Int
maxWordLength = 9

allWords :: IO WordList
allWords = do
    dict <- readFile "data/dict.txt"
    pure (lines dict)

gameWords :: IO WordList
gameWords = do
    -- a <- allWords
    -- pure (filter gameLength a)

    filter gameLength <$> allWords
    where
        gameLength w =
            let l = length (w :: String)
            in l >= minWordLength && l < maxWordLength

randomWord :: WordList -> IO String
randomWord wl = do
    randomIndex <- randomRIO (0, length wl - 1)
    pure $ wl !! randomIndex

randomWord' :: IO String
randomWord' = gameWords >>= randomWord

data Puzzle =
    Puzzle String [Maybe Char] [Char]

instance Show Puzzle where
    show (Puzzle _ discoverd guessed) = intersperse ' ' $ fmap renderPuzzleChar discoverd ++ " Guessed so far: " ++ guessed

renderPuzzleChar :: Maybe Char -> Char
renderPuzzleChar = undefined
