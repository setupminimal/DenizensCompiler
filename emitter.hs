import Data.List
import DenizenParser

concatinate strings = foldr (++) "" strings
space phrase = delete ' ' $ foldl spacer "" phrase
spacer a b = a ++ " " ++ b

multyplyArray acc _ 0 = acc
multiplyArray acc array number = multiplyArray (acc ++ array) array $ number - 1

fullEmit (Right a) = text_emitter a
fullEmit (Left _) = "Parse Error."

text_emitter text = concatinate $ map script_emitter text

script_emitter script =
    (script_head_emitter (script !! 0 !! 0 !! 0 !! 0)) ++ 
    (concatinate $ map (clause_emitter 1) $ script !! 1)

script_head_emitter head = (space head) ++ ":\n"

clause_emitter tabs clause =
    (multiplyArray [] "\t" tabs) ++ (space (clause !! 0 !! 0)) ++ ":\n" ++
    (concatinate (map (line_emitter (tabs + 1)) $ clause !! 1))

line_emitter tabs phrase =
    (multiplyArray [] "\t" tabs) ++ (space phrase) ++ "\n"

example a = fullParse "arthur (king):\n\tspace (wibbly) ->\n\t\tnarrate I love you.\n"
