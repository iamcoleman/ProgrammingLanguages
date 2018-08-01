-- Coleman Lyski

{-
    This is where
    the good stuff happens
    :D
-}

import Data.List
import System.IO
import Text.Printf


---------------------
--  Sample Inputs  --
---------------------

-- Karl is on the Low Workout Plan
karlActualVisits = 3.0
karlSumWorkoutRating = 7.0
karlImprovementScore = 4.0

-- Rich is on the Medium Workout Plan
richActualVisits = 3.0
richSumWorkoutRating = 9.0
richImprovementScore = 2.5

-- Mike is on the High Workout Plan
mikeActualVisits = 4.0
mikeSumWorkoutRating = 9.0
mikeImprovementScore = 2.0




---------------------
--  Workout Plans  --
---------------------

-- Low Workout Plan
lowVisits = 3

lowVPP = (0.00, 0.34)
lowVPC = (0.34, 0.67)
lowVPB = (0.67, 1.01)
lowVP = [lowVPP, lowVPC, lowVPB]

lowWRP = (1.0, 1.5)
lowWRC = (1.5, 2.0)
lowWRB = (2.0, 3.1)
lowWR = [lowWRP, lowWRC, lowWRB]

lowWIP = (1.0, 1.0)
lowWIC = (2.0, 3.0)
lowWIB = (3.0, 5.1)
lowWI = [lowWIP, lowWIC, lowWIB]


-- Medium Workout Plan
medVisits = 4

medVPP = (0.00, 0.51)
medVPC = (0.51, 0.76)
medVPB = (0.76, 1.01)
medVP = [medVPP, medVPC, medVPB]

medWRP = (1.0, 1.75)
medWRC = (1.75, 2.25)
medWRB = (2.25, 3.1)
medWR = [medWRP, medWRC, medWRB]

medWIP = (1.0, 2.0)
medWIC = (2.0, 3.0)
medWIB = (3.0, 5.1)
medWI = [medWIP, medWIC, medWIB]


-- High Workout Plan
highVisits = 5

highVPP = (0.00, 0.61)
highVPC = (0.61, 0.81)
highVPB = (0.81, 1.01)
highVP = [highVPP, highVPC, highVPB]

highWRP = (1.0, 2.0)
highWRC = (2.0, 2.5)
highWRB = (2.5, 3.1)
highWR = [highWRP, highWRC, highWRB]

highWIP = (1.0, 3.0)
highWIC = (3.0, 4.0)
highWIB = (4.0, 5.1)
highWI = [highWIP, highWIC, highWIB]


-- Combination of WR and WI
combVP = [lowVP, medVP, highVP]
combWR = [lowWR, medWR, highWR]
combWI = [lowWI, medWI, highWI]


---------------------
--    Functions    --
---------------------


-- the percentage of actual visits vs. scheduled visits (visitAvg)
calcVisitPercentage :: Double -> Double -> Double
calcVisitPercentage actualVisits plannedVisits = actualVisits / plannedVisits

-- the average rating of the workouts for the week (wrAvg)
calcWorkoutRatingAvg :: Double -> Double -> Double
calcWorkoutRatingAvg sumOfWorkoutRatings actualVisits = sumOfWorkoutRatings / actualVisits

-- checks to see if n is in between (low, high)
-- low in inclusive / high is exclusive
isInRange :: (Double, Double) -> Double -> Bool
isInRange (low, high) n
    | (n >= low) && (n < high) = True
    | otherwise = False

-- Find the index position in for Workout Rating
-- ex:  findIndexPosWR isInRange 1.5 0
-- Level: 0 = low, 1 = med, 2 = high
findIndexPosVP :: ((Double, Double) -> Double -> Bool) -> Double -> Int -> Int 
findIndexPosVP isInRange value level
    | isInRange ((combVP !! level) !! 0) value = 0
    | isInRange ((combVP !! level) !! 1) value = 1
    | isInRange ((combVP !! level) !! 2) value = 2

-- Find the index position in for Workout Rating
-- ex:  findIndexPosWR isInRange 1.5 0
-- Level: 0 = low, 1 = med, 2 = high
findIndexPosWR :: ((Double, Double) -> Double -> Bool) -> Double -> Int -> Int 
findIndexPosWR isInRange value level
    | isInRange ((combWR !! level) !! 0) value = 0
    | isInRange ((combWR !! level) !! 1) value = 1
    | isInRange ((combWR !! level) !! 2) value = 2

-- Find the index position in for Workout Improvement
-- ex:  findIndexPosWI isInRange 2.0 0
-- Level: 0 = low, 1 = med, 2 = high
findIndexPosWI :: ((Double, Double) -> Double -> Bool) -> Double -> Int -> Int 
findIndexPosWI isInRange value level
    | isInRange ((combWI !! level) !! 0) value = 0
    | isInRange ((combWI !! level) !! 1) value = 1
    | isInRange ((combWI !! level) !! 2) value = 2

-- Print Penalty, Consistent, or Bonus
printPCB :: Int -> String 
printPCB indexPos 
    | indexPos == 0 = "Penalty"
    | indexPos == 1 = "Consistent"
    | indexPos == 2 = "Bonus"

main = do
    putStrLn "----     Karl     ----"
    putStrLn "----  Input Data  ----"
    putStrLn "Actual Visits: "
    print karlActualVisits
    putStrLn "Sum Workout Rating: "
    print karlSumWorkoutRating
    putStrLn "Improvement Rating: "
    print karlImprovementScore
    putStrLn "\n---  Calculations  ---"
    putStrLn "Visit Percentage: "
    let visitPercent = calcVisitPercentage karlActualVisits lowVisits
    printf "%.2f\n" (visitPercent*100)
    putStrLn "Workout Rating Average: "
    let avgWR = calcWorkoutRatingAvg karlSumWorkoutRating karlActualVisits
    printf "%.2f\n" avgWR
    putStrLn "\n--- Penalty, Consistent, Bonus ---"
    putStrLn "Visit Percentage: "
    let indexPosVP = findIndexPosVP isInRange visitPercent 0
    let vpPCB = printPCB indexPosVP 
    print vpPCB
    putStrLn "Workout Rating: "
    let indexPosWR = findIndexPosWR isInRange avgWR 0
    let wrPCB = printPCB indexPosWR
    print wrPCB
    putStrLn "Workout Improvement: "
    let indexPosWI = findIndexPosWI isInRange karlImprovementScore 0
    let wiPCB = printPCB indexPosWI
    print wiPCB

    putStrLn "\n\n----     Rich     ----"
    putStrLn "----  Input Data  ----"
    putStrLn "Actual Visits: "
    print richActualVisits
    putStrLn "Sum Workout Rating: "
    print richSumWorkoutRating
    putStrLn "Improvement Rating: "
    print richImprovementScore
    putStrLn "\n---  Calculations  ---"
    putStrLn "Visit Percentage: "
    let visitPercent2 = calcVisitPercentage richActualVisits medVisits
    printf "%.2f\n" (visitPercent2*100)
    putStrLn "Workout Rating Average: "
    let avgWR2 = calcWorkoutRatingAvg richSumWorkoutRating richActualVisits
    printf "%.2f\n" avgWR2
    putStrLn "\n--- Penalty, Consistent, Bonus ---"
    putStrLn "Visit Percentage: "
    let indexPosVP2 = findIndexPosVP isInRange visitPercent2 1
    let vpPCB2 = printPCB indexPosVP2
    print vpPCB2
    putStrLn "Workout Rating: "
    let indexPosWR2 = findIndexPosWR isInRange avgWR2 1
    let wrPCB2 = printPCB indexPosWR2
    print wrPCB2
    putStrLn "Workout Improvement: "
    let indexPosWI2 = findIndexPosWI isInRange richImprovementScore 1
    let wiPCB2 = printPCB indexPosWI2
    print wiPCB2

    putStrLn "\n\n----     Mike     ----"
    putStrLn "----  Input Data  ----"
    putStrLn "Actual Visits: "
    print mikeActualVisits
    putStrLn "Sum Workout Rating: "
    print mikeSumWorkoutRating
    putStrLn "Improvement Rating: "
    print mikeImprovementScore
    putStrLn "\n---  Calculations  ---"
    putStrLn "Visit Percentage: "
    let visitPercent3 = calcVisitPercentage mikeActualVisits highVisits
    printf "%.2f\n" (visitPercent3*100)
    putStrLn "Workout Rating Average: "
    let avgWR3 = calcWorkoutRatingAvg mikeSumWorkoutRating mikeActualVisits
    printf "%.2f\n" avgWR3
    putStrLn "\n--- Penalty, Consistent, Bonus ---"
    putStrLn "Visit Percentage: "
    let indexPosVP3 = findIndexPosVP isInRange visitPercent3 2
    let vpPCB3 = printPCB indexPosVP3 
    print vpPCB3
    putStrLn "Workout Rating: "
    let indexPosWR3 = findIndexPosWR isInRange avgWR3 2
    let wrPCB3 = printPCB indexPosWR3
    print wrPCB3
    putStrLn "Workout Improvement: "
    let indexPosWI3 = findIndexPosWI isInRange mikeImprovementScore 2
    let wiPCB3 = printPCB indexPosWI3
    print wiPCB3


