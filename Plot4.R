library(dplyr)

#Load data
rawdata = read.table("household_power_consumption.txt", header=TRUE, sep=";", 
                     stringsAsFactors=FALSE)

#Subset data with Date
rawdata$Date = as.Date(rawdata$Date, format = "%d/%m/%Y")
data = filter(rawdata, Date == "2007-02-01"|Date == "2007-02-02")

#Set column classes to numeric
data[,3:9] = lapply(data[,3:9], function(x) as.numeric(x))

#Merge Date/Time columns to POSIXlt 
data$date_time = paste(data$Date, data$Time)
data$date_time = strptime(data$date_time, format="%Y-%m-%d %H:%M:%S")


#Set graphic device to PNG file
png(filename="plot4.png", width=480, height=480, units="px")
Sys.setlocale("LC_TIME", "C")  #solving language problem

par(mfrow=c(2,2))

#Make 1st plot
with(data, plot(date_time, Global_active_power, type="l",
                xlab="", ylab="Global Active Power"))

#Make 2nd plot
with(data, plot(date_time, Voltage, type="l",
                xlab="datetime", ylab="Voltage"))

#Make 3rd plot
with(data, plot(date_time, Sub_metering_1, type="l",
                xlab="", ylab="Energy sub metering", ylim=c(0,38)))
with(data, lines(date_time, Sub_metering_2, col=2))
with(data, lines(date_time, Sub_metering_3, col=4))

legend("topright", c("sub_metering_1", "sub_metering_2", "sub_metering_3"), 
       lwd=1, col=c(1,2,4), bty="n")

#Make 4th plot
with(data, plot(date_time, Global_reactive_power, type="l",
                xlab="datetime"))

#Save into PNG file
dev.off()
