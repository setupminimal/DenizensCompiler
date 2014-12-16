import Text.Parsec
import Control.Applicative hiding (many, optional, (<|>))

text =
	do
		result <- many script
		eof
		return result

script = 
	do
		head <- scriptStart
		rest <- scriptInnards
		return (head, rest)

scriptStart =
	do
		result <- multipleWords
		char ':'
		return result

scriptInnards = many clause

clause = 
	do
		head <- clauseStart
		rest <- clauseInnards
		return (head, rest)

clauseStart =
	tabs *> (do
				result <- multipleWords
				(string " ->")
				return result)
clauseInnards = many commandLine

commandLine = tabs *> endBy multipleWords (char '\n')

tabs = many (char '\t')
multipleWords = sepBy (many word) (many (char ' '))
word :: Text.Parsec.ParsecT a b c [Char]
word = many (noneOf " \n:\t\r")
