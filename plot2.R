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

#open png file
png(filename = "plot2.png",width=480,height = 480, bg="transparent")
#create the scatterplot without the points and axis
plot(data$DateTime,data$Global_active_power,
     ylab="Global Active Power (kilowatts)",xaxt="n", yaxt="n",xlab="", type="n")
#create the line
lines(data$DateTime,data$Global_active_power, lty=1)
#create the axis
axis(side=2, at=c(0,2,4,6),labels = c("0","2","4","6"))
axis.POSIXct(side=1, at=c("2007-02-01 00:00:00 UTC","2007-02-02 00:00:00 UTC","2007-02-02 23:59:00 UTC"),
             labels = c("Thu","Fri","Sat"))
#copy the graph to a png file
dev.off()