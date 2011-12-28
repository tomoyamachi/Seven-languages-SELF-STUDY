-- How many different ways can you find to write allEven?
allEven1 :: [Integer] -> [Integer]
allEven1 [] = []
allEven1 (x:xs) = if even x then x:allEven1 xs else allEven1 xs

allEven2 :: [Integer] -> [Integer]
allEven2 xs = [x| x <- xs, even x]

allEven3 :: [Integer] -> [Integer]
allEven3 xs = foldr (\ y ys -> if even y then (y:ys) else ys ) [] xs

allEven4 :: [Integer] -> [Integer]
allEven4 xs = filter even xs

-- Write a function that takes a list and reverses the same list in reverse.
reverse1 :: [a] -> [a]
reverse1 [] = []
reverse1 (x:xs) = reverse1 xs ++ [x]

reverse2 :: [a] -> [a]
reverse2 xs = foldl (\ ys y -> y:ys) [] xs

-- Write a function that builds two-tuples with all possible combina-tions of two of the colors black, white, blue, yellow, and red. Note that you should include only one of (black, blue) and (blue, black).

makeCombinations :: [String] -> [(String,String)]
makeCombinations xs = [(x,y)| x <- xs, y <- xs, (x < y)]

-- Write a list comprehension to build a childhood multiplication table. The table would be a list of three-tuples where the first two are integers from 1-12 and the third is the product of the first two.

makeTable :: [(Integer,Integer,Integer)]
makeTable = [(a,b,a*b)| a <- [1..12], b <- [1..12], (a < b)]

-- Solve the map-coloring problem (Section 4.2, Map Coloring, on page 101) using Haskell.

bannedCombination = [("Mississippi", "Tennessee"),
                    ("Mississippi", "Alabama"),
                    ("Alabama", "Tennessee"),
                    ("Alabama", "Mississippi"),
                    ("Alabama", "Georgia"),
                    ("Alabama", "Florida"),
                    ("Georgia", "Florida"),
                    ("Georgia", "Tennessee")]
mapNames = ["Tennessee","Florida","Mississippi","Georgia","Alabama"]
colorNames = ["red","blue","green"]

-- 地名の数まで、[色,色...]の組み合わせをつくる。
colorList = rcomb colorNames (length mapNames)

rcomb :: [String] -> Int -> [[String]]
rcomb [] _ = []
rcomb xs 0 = [[]]
rcomb xs 1 = [[x] | x <- xs]
rcomb xxs@(x:xs) n = map (x:) (rcomb xxs (n-1)) ++ rcomb xs n

-- zipをつかって、[(地名,色)] の組み合わせをつくる。
mapColoringCombination :: [String] -> [[String]] -> [[(String,String)]]
mapColoringCombination map colors = [zip map c|c<- colors]
allMapColoringCombinations = mapColoringCombination mapNames colorList

-- 上でつくった組み合わせをふるいにかける。
allowCombination :: [(String,String)] -> [[(String,String)]] -> [[(String,String)]]
allowCombination xs ys = [y|y<-ys,scan xs y]

findValue :: Eq a => a -> [(a,b)] -> [b]
findValue key list = [value|(key',value) <- list,key == key']

scan :: [(String,String)] -> [(String,String)] -> Bool
scan [] ys = True
scan ((a,b):xs) ys | (findValue a ys) == (findValue b ys) = False
                   | otherwise = scan xs ys

allows = allowCombination bannedCombination allMapColoringCombinations

--ここまで!!




-- http://www.boyplankton.com/2011/04/10/my-solution/
-- states = [ "Tennessee", "Mississippi", "Alabama", "Georgia", "Florida" ]

-- borders = [ [ "Mississippi", "Tennessee" ], [ "Mississippi", "Alabama" ], [ "Alabama", "Tennessee" ], [ "Alabama", "Mississippi" ], [ "Alabama", "Georgia" ], [ "Alabama", "Florida" ], [ "Georgia", "Florida" ], [ "Georgia", "Tennessee" ] ]

-- colors = [ "red", "green", "blue" ]

-- -- > getBorders "Georgia"  #=> ["Florida","Tennessee"]
-- getBorders y = [last x|x <- borders, head x == y]

-- getBorderColors y z = [last x| x <- y, any ( == head x) (getBorders z)]

-- colorsLeft :: [[Char]] -> [[Char]]
-- colorsLeft [] = colors
-- colorsLeft (x:xs) = [y| y <- colorsLeft xs , (x /= y)]

-- mapColors xs = helper [] xs
--                where helper sol (x:xs) = helper ([x, head (colorsLeft (getBorderColors sol x ))] : sol) xs
--                      helper sol _ = sol


-- http://blog.plagelao.com/7languages7weeks/haskell/2011/07/30/haskell-day-one.html
-- states = ["Tenesse", "Missisipi", "Alabama", "Georgia", "Florida"]
-- borders = [["Missisipi", "Alabama", "Georgia"], ["Tenesse", "Alabama"], ["Tenesse", "Missisipi", "Georgia", "Florida"], ["Tenesse", "Alabama", "Florida"], ["Georgia", "Alabama"]]
-- statesAndBorders = zip states borders

-- paintMap ((state,neighbours):states) colors coloredStates | states == []    = [paintState]
--                                                           | otherwise       = paintState:paintMap states colors (paintState:coloredStates)
--   where paintState                   = (state, head colorsNotUsedByNeighbours)
--         colorsNotUsedByNeighbours = [ color | color <- colors, isAFreeColor color]
--         isAFreeColor color         = all (\usedColor -> usedColor /= color) usedColorsInNeighbours
--         usedColorsInNeighbours     = [ color | (state, color) <- coloredStates, isNeighbour state]
--         isNeighbour coloredState    = any (\neighbour -> coloredState == neighbour) neighbours

-- colorMap colors = paintMap statesAndBorders colors []