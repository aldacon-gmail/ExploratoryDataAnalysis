library(lubridate)
library(dplyr)

############################
##                        ##
##     Downloading data   ##
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
png(file="plot3.png")

#Plot
with(data_lim, plot(Sub_metering_1 ~ Time, type="l", 
                    xlab="", ylab="Energy sub metering"))
with(data_lim, points(Sub_metering_2 ~ Time, type="l", col="red"))
with(data_lim, points(Sub_metering_3 ~ Time, type="l", col="blue"))
legend("topright", 
       col=c("black","red","blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), 
       lwd=c(1,1,1))


#Close device
dev.off()

