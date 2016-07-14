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

#Plot1
#open the png file
png(filename = "plot1.png",width=480,height = 480, bg="transparent")

#create the histogram without axis
hist(data$Global_active_power, col="red", main="Global Active Power", 
     xlab="Global Active Power (kilowatts)",ylab="Frequency",breaks = 12, xaxt="n", yaxt="n")
#create the axis
axis(side=1, at=c(0,2,4,6),labels = c("0","2","4","6"))
axis(side=2, at=c(0,200,400,600,800,1000,1200),
     labels = c("0","200","400","600","800","1000","1200"))

#close the png device
dev.off()