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

#plot2
plot(power_data$Global_active_power~power_data$datetime, type="l", ylab="Global Active Power (kilowatts)", xlab="")

# print plot2 to png
dev.copy(png,"plot2.png", width=480, height=480)
dev.off()
