import System.FilePath (dropTrailingPathSeparator, splitFileName, (</>))
import Control.Exception (handle, SomeException)
import Control.Monad (forM)
import GlobRegex (matchesGlob)

isPattern :: String -> Bool
