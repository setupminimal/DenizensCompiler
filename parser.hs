module DenizenParser where

import Text.ParserCombinators.Parsec

denizenFile = many script

script =
	do headA <- scriptHead
	   rest <- many clause
	   return [headA, rest]

scriptHead =
	do name <- phrase
	   string ":\n"
	   return [[[name]]]

clause =
	do head <- clauseHead
	   rest <- many commandLine
	   return [head, rest]

clauseHead =
	do tabs
	   name <- phrase
	   string "->\n"
	   return [name]

commandLine :: GenParser Char st [String]
commandLine =
	do tabs
	   result <- phrase
	   eol
	   return result

tabs = many (char '\t')

phrase = sepBy word (char ' ')

word = many (noneOf " \n\r\t-:")

eol = char '\n'

fullParse = parse denizenFile "(unknown)"
