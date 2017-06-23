library(lubridate)
library(dplyr)

############################
##                        ##
##     Getting data       ##
##                        ##
############################
destfile="household_power_consumption.txt"
if(!file.exists(destfile)){
        tem<-tempfile()
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", tem)
        unzip(tem)
}

# Reading the data
data<-read.csv(destfile, sep=";", as.is = TRUE, 
               dec=".", na.strings = "?")


############################
##                        ##
##   Cleaning data        ##
##                        ##
############################
data$Time<-as.POSIXct(dmy(data$Date)+hms(data$Time))
data$Date<-dmy(data$Date)


data_lim<-filter(data, Date>="2007-02-01" & Date<="2007-02-02")


############################
##                        ##
##   Plotting data        ##
##                        ##
############################

# Set Plotting device
png(file="plot1.png")

#Plot
hist(data_lim$Global_active_power, 
     col="red", 
     xlab="Global Active Power (kilowatts)", 
     main ="Global Active Power", 
     xlim = c(0,6), 
     ylim= c(0,1200))

#Close device
dev.off()
