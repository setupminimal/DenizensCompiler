import Text.ParserCombinators.Parsec

text = many script

script = scriptStart & scriptInnards

scriptStart = words & char ":"
scriptInnards = many clause

clause = clauseStart & clauseInnards

clauseStart = tabs *> words & (string " ->")
clauseInnards = many commandLine

commandLine = tabs *> endBy words (char "\n")

tabs = many (char "\t")
words = sepBy (many word) (many (char " "))
word = many (noneOf " \n:\t\r")
