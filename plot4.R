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
png("plot4.png", width = 480, height = 480, bg = "transparent") 

# set graphical parameters for 2 x 2 pictures on one plot
par(mfrow = c(2, 2)) 

# add first plot
plot(dat$DateTime, dat$Global_active_power, type = "l", 
     col = "black", lwd = 1,
     xlab = "", ylab = "Global Active Power") 

# add second plot
plot(dat$DateTime, dat$Voltage, type = "l", 
     col = "black", lwd = 1,
     xlab = "datetime", ylab = "Voltage") 

# add third plot
plot(dat$DateTime, dat$Sub_metering_1, type = "l", col = "black",lwd = 1,
     xlab = "", ylab = "Energy sub metering") 
lines(dat$DateTime, dat$Sub_metering_2, type = "l", col = "red",lwd = 1) 
lines(dat$DateTime, dat$Sub_metering_3, type = "l", col = "blue",lwd = 1) 
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=1, col=c("black", "red", "blue"), bty = "n")

# add fourth plot
plot(dat$DateTime, dat$Global_reactive_power, type = "l", 
     col = "black", lwd = 1,
     xlab = "datetime", ylab = colnames(dat)[3])

# close png device 
dev.off()