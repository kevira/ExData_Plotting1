# load dplyr and tidyr packages
require (dplyr)
require (tidyr)

# read .txt file
dat <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?", stringsAsFactors = FALSE)

# select data from the dates 2007-02-01 and 2007-02-02
dat$Date <- as.Date(dat$Date, "%d/%m/%Y")
d1 <- filter(dat, Date =="2007-02-01")
d2 <- filter(dat, Date =="2007-02-02")

# combine filtered data to create final df
dat <- bind_rows(d1,d2)

# remove unnecessary data from global evnironment
rm(d1)
rm(d2)

# convert the Date and Time variables to Date/Time variable
dat <- unite(dat, "DateTime" , 1:2 , sep =" ")
dat$DateTime <- as.POSIXct(strptime(dat$DateTime, "%Y-%m-%d %H:%M:%S"))

# check df structure and a few rows of df
str(dat)
head(dat)

# open png device
png("plot1.png", width = 480, height = 480, bg = "transparent") 

# create histogram
hist(dat$Global_active_power, col = "red", 
     main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

# close png device 
dev.off()