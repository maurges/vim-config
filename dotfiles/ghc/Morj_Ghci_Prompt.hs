module Morj_Ghci_Prompt (morj_ghci_prompt) where

import Prelude
import qualified Data.List

morj_ghci_prompt :: [String] -> Int -> IO String
morj_ghci_prompt modules _linenr = pure $
    let
      modules' = filter (/= "*Morj_Ghci_Prompt") modules
      joinModules = Data.List.intercalate " "
      modulesString = case Data.List.splitAt 5 (reverse modules') of
            ([], _) -> "Prelude"
            (modules'', []) -> joinModules modules''
            (modules'', _)  -> joinModules modules'' ++ " ..."
    in "\ESC[34m\STX" ++ modulesString ++ "\nλ\ESC[0m\STX "
