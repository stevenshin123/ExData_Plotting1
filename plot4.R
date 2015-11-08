## EDA Course Project 1
## Dataset: Electric Power Consumption
## Memory Estimate: 2,075,259 rows * 9 cols * 8 b's / (2^20) b/mb rate = ~142.5 mb

setwd(wd)

## Read data into temp file replacing "?"s as NAs

datatemp <- read.table(
    "exdata-data-household_power_consumption/household_power_consumption.txt", 
    sep = ";", header = TRUE, na.strings = "?")

## Dates of Interest: 2007-02-01 & 2007-02-02 
## Date column ( dd/mm/yyyy )

datatemp$Date <- as.Date(datatemp$Date, format = "%d/%m/%Y")

## Subset temp data object by Dates of Interest

data <- datatemp[datatemp$Date %in% as.Date(c("2007-02-01", "2007-02-02")),]
data <- within(data, {
    timestamp = as.POSIXlt(format(as.POSIXlt(paste(Date, Time)), 
                                  "%Y-%m-%d %H:%M:%S"), 
                           format = "%Y-%m-%d %H:%M:%S")
})


## plot4
png("plot4.png", width = 480, height = 480, units = "px")

par(mfcol = c(2,2))

## plot2 in top left position
with(data, plot(data$timestamp, data$Global_active_power, type = "l", 
                ylab = "Global Active Power", xlab = ""))

## plot3 in bottom left position
plot(data$timestamp, data$Sub_metering_1, type = "n", 
     ylab = "Energy sub metering", xlab ="")
points(data$timestamp, data$Sub_metering_1, type = "l")
points(data$timestamp, data$Sub_metering_2, type = "l", col = "red")
points(data$timestamp, data$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1,1,1), col = c("black", "red", "blue"), )

## Voltage vs. Timestamp in top right position
with(data, plot(data$timestamp, data$Voltage, type = "l", ylab = "Voltage",
                xlab = "datetime"))

## Global_reactive_power vs. Timestamp in bottom right position
with(data, plot(data$timestamp, data$Global_reactive_power, type = "l", 
                ylab = "Global_reactive_power", xlab = "datetime"))

dev.off()

