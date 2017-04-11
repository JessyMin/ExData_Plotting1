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
data$date_time = strptime(data$date_time, format = "%Y-%m-%d %H:%M:%S")


#Set graphic device to PNG file
png(filename = "plot2.png", width = 480, height = 480)
Sys.setlocale("LC_TIME", "C")  #solving language problem

#Make and anotate histogram
with(data, plot(date_time, Global_active_power, type = "l",
                xlab = "", ylab = "Global Active Power (kilowatts)"))

#Save into PNG file
dev.off()
