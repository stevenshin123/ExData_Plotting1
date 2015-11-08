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


## plot2
png("plot2.png", width = 480, height = 480, units = "px")
with(data, plot(data$timestamp, data$Global_active_power, type = "l", 
                ylab = "Global Active Power (kilowatts)", xlab = ""))
dev.off()
