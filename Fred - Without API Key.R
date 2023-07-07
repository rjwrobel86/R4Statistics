#FRED
library(fredr)

fredr_set_key("YOURAPIKEYGOESHERE")

ue <- fredr(
  series_id = "UNRATE",
  observation_start = as.Date("1980-01-01"),
  observation_end = as.Date("2000-01-01"),
  frequency = "a", #Annual
  units = "chg" #Change over previous value
)
ue
names(ue)

rgdp <- fredr(
  series_id = "GNPCA",
  observation_start = as.Date("1980-01-01"),
  observation_end = as.Date('2000-01-01'),
  frequency = "a",#a,m,w,d
  units = "l" #cap,cca,cch,ch1,chg,lin,log,pc1,pca,pch
)
rgdp
names(rgdp)

plot(rgdp$value,ue$value)

