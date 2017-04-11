library(dplyr)

#Load data
rawdata = read.table("household_power_consumption.txt", header=TRUE, sep=";", 
                     stringsAsFactors=FALSE)

#Subset data with Date
rawdata$Date = as.Date(rawdata$Date, format = "%d/%m/%Y")
data = filter(rawdata, Date == "2007-02-01"|Date=="2007-02-02")

#Set column classes to numeric
data[,3:9] = lapply(data[,3:9], function(x) as.numeric(x))

#Merge Date/Time columns to POSIXlt 
data$date_time = paste(data$Date, data$Time)
data$date_time = strptime(data$date_time, format = "%Y-%m-%d %H:%M:%S")


#Set graphic device to PNG file
png(filename="plot1.png", width=480, height=480, units="px")

#Make and anotate histogram
hist(data$Global_active_power, 
     xlab="Global Active Power (kilowatts)", 
     main="Global Active Power", 
     col="red"
)

#Save into PNG file
dev.off()
