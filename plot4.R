install.packages("data.table")
install.packages("ggplot2")
library("data.table")
library("ggplot2")

# read data
> power_data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

#Checking data
> head(power_data$Date)
[1] "16/12/2006" "16/12/2006" "16/12/2006" "16/12/2006" "16/12/2006" "16/12/2006"

# Format date to Type Date
power_data$Date <- as.Date(power_data$Date, "%d/%m/%Y")

# Filter data from:	 2007, Feb. 1st - 2007, Feb. 2
power_data <- subset(power_data,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

# Combine Date and Time column
datetime <- paste(power_data$Date, power_data$Time)

#remove date and time variables
power_data <- power_data[ ,!(names(power_data) %in% c("Date","Time"))]

#add datetime column
power_data <- cbind(datetime, power_data)

#format the datetime column
power_data$datetime <- as.POSIXct(datetime)

#setting the scene
par(mfrow = c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

#plot4
 with(power_data, {
    plot(Global_active_power~datetime, type="l", 
         ylab="Global Active Power (kilowatts)", xlab="")
    plot(Voltage~datetime, type="l", 
         ylab="Voltage (volt)", xlab="")
    plot(Sub_metering_1~datetime, type="l", 
         ylab="Global Active Power (kilowatts)", xlab="")
    lines(Sub_metering_2~datetime,col='Red')
    lines(Sub_metering_3~datetime,col='Blue')
    legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(Global_reactive_power~datetime, type="l", 
         ylab="Global Rective Power (kilowatts)",xlab="")
  })

#print plot 4
dev.copy(png,"plot4.png", width=480, height=480)
dev.off()
