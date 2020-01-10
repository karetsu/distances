-- |

module Numeric.Metrics where

-- Imports ---------------------------------------------------------------------
import           Numeric.Metrics.Vectors
import           Numeric.Metrics.Distributions
import           Numeric.Metrics.Surfaces



sumprod :: Floating a => [a] -> [a] -> a
sumprod xs ys = sum $ abs <$> zipWith (*) xs ys


-- | Haversine distance: great-circle distance between two points on a sphere
-- FIXME: currently the sphere's radius is based on the first point passed
haversine :: (Floating a, Ord a, Num a) => (a, a) -> (a, a) -> a
haversine (x1, x2) (y1, y2) = 2 * r * asin (min (sqrt hav) 1)
 where
  lambda = deg2rad (y1 - x1)  -- ^ longitude
  phi1   = deg2rad x2         -- ^ latitude (component 1)
  phi2   = deg2rad y2         -- ^ latitude (component 2)
  delta  = phi2 - phi1
  r      = sqrt ((x1 ** 2) + (x2 ** 2))
  hav    = sin (delta / 2) ** 2 + cos phi1 * cos phi2 * ((sin lambda / 2) ** 2)


-- | Euclidean distance
-- FIXME: create these for an arbitrary foldable
sqeuclid :: Floating a => [a] -> [a] -> a
sqeuclid xs ys = sum $ (** 2) <$> zipWith (-) ys xs

euclid :: Floating a => [a] -> [a] -> a
euclid xs ys = sqrt $ sqeuclid xs ys


-- | Manhattan distance (city block/taxi cab distance)
-- FIXME: create for arbitrary folable
manhattan :: Num a => [a] -> [a] -> a
manhattan xs ys = sum $ abs <$> zipWith (flip (-)) xs ys


-- | Cosine distance between vectors
-- FIXME: create for arbitrary foldable
cosine :: Floating a => [a] -> [a] -> a
cosine a b = 1 - (sumprod a b / sqrt (sumprod a a * sumprod b b))
