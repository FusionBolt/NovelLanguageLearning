module Main where  
import System.Environment  
import Text.ParserCombinators.Parsec hiding (spaces)
import Control.Monad
import Numeric

symbol :: Parser Char
symbol = oneOf "!$%&|*+-/:<=>?@^_~"

spaces :: Parser ()
spaces = skipMany1 space

data LispVal = Atom String
             | List [LispVal]
             | DottedList [LispVal] LispVal
             | Number Integer
             | String String
             | Bool Bool
             | Char Char
             | Float Float

escapeChars :: Parser Char
escapeChars = do char '\\'
                 x <- oneOf "\\\"nrt"
                 return $ case x of 
                     '\\' -> x
                     '"' -> x
                     'n' -> '\n'
                     'r' -> '\r'
                     't' -> '\t'

parseString :: Parser LispVal
parseString = do
                char '"'
                x <- many $ escapeChars <|> noneOf "\"\\"
                char '"'
                return $ String x

parseBool = do
    char '#'
    (char 't' >> return (Bool True)) <|> (char 'f' >> return (Bool False))

parseAtom :: Parser LispVal
parseAtom = do
              first <- letter <|> symbol
              rest <- many (letter <|> digit <|> symbol)
              let atom = first:rest
              return $ case atom of
                        "#t" -> Bool True
                        "#f" -> Bool False
                        _    -> Atom atom

parseDigital1 :: Parser LispVal
parseDigital1 = Number . read <$> many1 digit

parseDigital2 :: Parser LispVal
parseDigital2 = do try $ string "#d"
                   x <- many1 digit
                   (return . Number . read) x

parseHex :: Parser LispVal
parseHex = do try $ string "#x"
              x <- many1 hexDigit
              return $ Number (hex2dig x)
                
parseOct :: Parser LispVal
parseOct = do try $ string "#o"
              x <- many1 octDigit
              return $ Number (oct2dig x)

parseBin :: Parser LispVal
parseBin = do try $ string "#b"
              x <- many1 (oneOf "10")
              return $ Number (bin2dig x)

oct2dig x = fst $ head (readOct x)
hex2dig x = fst $ head (readHex x)
bin2dig  = bin2dig' 0
bin2dig' digint "" = digint
bin2dig' digint (x:xs) = let old = 2 * digint + (if x == '0' then 0 else 1) in
                         bin2dig' old xs
-- parseHex :: Parser LispVal
parseNumber :: Parser LispVal
parseNumber = parseDigital1
            <|> parseDigital2
            <|> parseHex
            <|> parseOct
            <|> parseBin
-- parseNumber :: Parser LispVal
-- parseNumber = liftM (Number . read) $ many1 digit
-- parseNumber = do
--                 number <- many1 digit
--                 return $ (Number. read) number
-- parseNumber = many1 digit >>= \x -> return . Number . read $ x
-- parseNumber = many1 digit >>= return . Number . read

parseList :: Parser LispVal
parseList = liftM List $ sepBy parseExpr spaces

parseDottedList :: Parser LispVal
parseDottedList = do
    head <- endBy parseExpr spaces
    tail <- char '.' >> spaces >> parseExpr
    return $ DottedList head tail
    
parseQuoted :: Parser LispVal
parseQuoted = do
    char '\''
    x <- parseExpr
    return $ List [Atom "quote", x]

parseExpr :: Parser LispVal
parseExpr = parseAtom
         <|> parseString
         <|> parseNumber
         <|> parseQuoted
         <|> do char '('
                x <- try parseList <|> parseDottedList
                char ')'
                return x
         <|> do char '{'
                x <- try parseAtom <|> parseString
                char '}'
                return x 

-- >>:尝试匹配第一个解析器，然后用剩下的输入尝试匹配第二个，如果任意一次匹配失败的话，就返回失败
readExpr :: String -> String
readExpr input = case parse parseExpr "lisp" input of 
    Left err -> "No match: " ++ show err 
    Right _ -> "Found value"
    
     
main :: IO ()  
main = do 
    (expr:_) <- getArgs
    putStrLn (readExpr expr)