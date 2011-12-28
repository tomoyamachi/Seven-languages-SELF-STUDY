-- Day 2 Self-Study
-- Find:
-- Functions that you can use on lists, strings, or tuples
-- A way to sort lists

-- Do:
-- Write a sort that takes a list and returns a sorted list.
qsort :: [Integer] -> [Integer]
qsort [] = []
qsort (x:xs) = (qsort smaller) ++ [x] ++ (qsort bigger)
               where
                 smaller = [a| a <- xs ,a <= x]
                 bigger = [b| b <- xs, b > x]

-- Write a sort that takes a list and a function that compares its two arguments and then returns a sorted list.



-- Write a Haskell function to convert a string to a number. The string should be in the form of $2,345,678.99 and can possibly have leading zeros.

toNumber :: [Char] -> Float
toNumber xs = read (parseStr xs) ::Float

parseStr :: String -> String
parseStr [] = []
parseStr (x:xs) | (x == '$' || x == ',') = parseStr xs
                | otherwise = [x] ++ (parseStr xs)

-- Write a function that takes an argument x and returns a lazy sequence that has every third number, starting with x. Then, write a function that includes every fifth number, beginning with y. Combine these functions through composition to return every eighth number, beginning with x + y.

every3 x = x:(every3 (x + 3))
every5 x = x:(every5 (x + 5))
every8 x y = [a + b | (a,b) <- (zip (every3 x) (every5 y))]
--zipWith (+) (every3 x) (every5 y)

-- Use a partially applied function to define a function that will return half of a number and another that will append \n to the end of any string.

divi x y = y / x
half = divi 2

putsString x y = y ++ x
puts = putsString "\n"

--- additional
-- Write a function to determine the greatest common denominator of two integers.
-- Create a lazy sequence of prime numbers.
-- Break a long string into individual lines at proper word bound-aries.
-- Add line numbers to the previous exercise.
-- To the above exercise, add functions to left, right, and fully justify the text with spaces (making both margins straight).