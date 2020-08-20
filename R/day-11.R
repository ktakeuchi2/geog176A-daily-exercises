# Kiki Takeuchi
# Date: August 20
# Daily Assignment Day - 11: Projections

cities = readr::read_csv("data/uscities.csv") %>%
  st_as_sf(coords = c("lng", "lat"), crs = 4326) %>%
  filter(state_name == "California") %>%
  filter(city %in% c("Santa Barbara", "Walnut Creek"))

# WGS84
st_distance(cities)

# Equal Area
st_distance(st_transform(cities, 5070))

# Equidistant
st_distance(st_transform(cities, '+proj=eqdc +lat_0=40 +lon_0=-96 +lat_1=20 +lat_2=60 +x_0=0 +y_0=0 +datum=NAD83 +units=m +no_defs'))

library(units)
st_distance(cities)

(st_distance(cities) %>%
    set_units("km") %>%
    drop_units())
