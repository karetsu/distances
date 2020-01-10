-- |
module Numeric.Metrics.Surfaces where

-- Imports ---------------------------------------------------------------------

-- Type declarations -----------------------------------------------------------

-- Declarations ----------------------------------------------------------------

-- | Convert degrees to radians
toRad :: (Floating a) => [a] -> [a]
toRad = map ((* pi) . (/ 180))


-- | Haversine distance: great-circle distance between two points on a sphere
haversine :: (Floating a, Ord a) => a -> [a] -> [a] -> Maybe a
haversine r xs ys
  | length xs == 2 && length ys == 2 = Just $ 2 * r * asin (min (sqrt hav) 1)
  | otherwise                        = Nothing
 where
  xr              = toRad xs
  yr              = toRad ys
  diffs           = zipWith (-) yr xr
  [dlambda, dphi] = diffs
  phi1            = cos $ xr !! 1
  phi2            = cos $ yr !! 1
  hav             = sin (dphi / 2) ** 2 + phi1 * phi2 * (sin (dlambda / 2) ** 2)
