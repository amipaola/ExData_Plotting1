library(png)
# read the data from 1/2/2007 to 2/2/2007
begin <- grep("^31/1/2007",readLines("household_power_consumption.txt"))
end <- grep("^2/2/2007",readLines("household_power_consumption.txt"))
lg <- end[length(end)] - begin[length(begin)]
data <- read.table('household_power_consumption.txt', sep=";",skip=begin[length(begin)], nrow=lg)

#Put the names of the columns
colnames(data) <- c('Date', 'Time', 'Global_active_power', 'Global_reactive_power',
                    'Voltage','Global_intensity',
                    'Sub_metering_1','Sub_metering_2','Sub_metering_3')

#convert the Date and Time variables to Date/Time classes in R 
DateTime <- paste(data$Date,data$Time)
data <- cbind(data,DateTime)
data$DateTime <- strptime(data$DateTime,"%e/%m/%Y %H:%M:%S", tz="UTC")
#to look for ? in table ==> grep("\\?", data[0,1])

#open png file for first plot
png(filename = "plot4.png",width=480,height = 480, bg="transparent")
par(mfrow=c(2,2))

#create a scatterplot without points or axis
plot(data$DateTime,data$Global_active_power,
     ylab="Global Active Power (kilowatts)",xaxt="n", yaxt="n",xlab="", type="n")

#create lines
lines(data$DateTime,data$Global_active_power, lty=1)

#create axis
axis(side=2, at=c(0,2,4,6),labels = c("0","2","4","6"))
axis.POSIXct(side=1, at=c("2007-02-01 00:00:00 UTC","2007-02-02 00:00:00 UTC","2007-02-02 23:59:00 UTC"),
             labels = c("Thu","Fri","Sat"))

#Second plot
#create scatterplot without axis or points
plot(data$DateTime,data$Voltage, ylab = "Voltage",xlab="datetime", xaxt="n",yaxt="n",type="n")
#create axis
axis.POSIXct(side=1, at=c("2007-02-01 00:00:00 UTC","2007-02-02 00:00:00 UTC","2007-02-02 23:59:00 UTC"),
             labels = c("Thu","Fri","Sat"))
axis(side=2, at=c(234,236,238,240,242,244,246),labels = c("234","","238","","242","","246"))
#create lines
lines(data$DateTime,data$Voltage, lty=1)

#Third plot
#create scatterplot withour axis or points
plot(data$DateTime,data$Sub_metering_1, ylab = "Energy sub metering", 
     xaxt="n",yaxt="n", xlab = "",type="n")
#create axis
axis.POSIXct(side=1, at=c("2007-02-01 00:00:00 UTC","2007-02-02 00:00:00 UTC","2007-02-02 23:59:00 UTC"),
             labels = c("Thu","Fri","Sat"))
axis(side=2, at=c(0,10,20,30),labels = c("0","10","20","30"))
#create legend
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=c(1,1,1),lwd=c(1,1,1), cex = 1, xjust = 0.5, bty="n")
#create lines
lines(data$DateTime,data$Sub_metering_1, lty=1)
lines(data$DateTime,data$Sub_metering_2, lty=1, col="red")
lines(data$DateTime,data$Sub_metering_3, lty=1, col="blue")

#Fourth plot
#create scatterplot without points or axis
plot(data$DateTime,data$Global_reactive_power, ylab = "Global_reactive_power",xlab="datetime", xaxt="n",yaxt="n",type="n")
#create axis
axis.POSIXct(side=1, at=c("2007-02-01 00:00:00 UTC","2007-02-02 00:00:00 UTC","2007-02-02 23:59:00 UTC"),
             labels = c("Thu","Fri","Sat"))
axis(side=2, at=c(0.0,0.1,0.2,0.3,0.4,0.5),labels = c("0.0","0.1","0.2","0.3","0.4","0.5"))
#create lines
lines(data$DateTime,data$Global_reactive_power, lty=1)

#close device
dev.off()