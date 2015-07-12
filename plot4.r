# Using knowledge of the dataset to help reduce memory usage.
# I find this preferable to the SQL solution; given that it only uses base R commands,
# it's likely to be more portable. (though it has the weakness of not working if the 
# data set changes)

data <- read.csv2("household_power_consumption.txt", skip = 66637, nrows = 2879, 
                  col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power",
                                "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2",
                                "Sub_metering_3"),
                  stringsAsFactors = F,
                  na.strings = "?",)

# now adding a timestamp column to the data frame to make the graphing easier

data <- within(data, {timestamp = as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")})

# creating plot in file

png("plot4.png")
par(mfrow = c(2,2), mar = c(4,4,2,2))
with(data, {
    plot(timestamp, as.numeric(Global_active_power), type = "l", ylab="Global Active Power", xlab="")
    plot(timestamp, as.numeric(Voltage), type = "l", ylab="Voltage", xlab="")
    plot(timestamp, as.numeric(Sub_metering_1), type = "l", xlab="", ylab="Energy sub metering")
    lines(timestamp,as.numeric(Sub_metering_2), col="red")
    lines(timestamp,as.numeric(Sub_metering_3), col="blue")
    legend("topright", lty=c(1,1), bty="n", col = c("black", "red", "blue"), 
               legend = c("sub_metering_1","sub_metering_2","sub_metering_3"))
    plot(timestamp, as.numeric(Global_reactive_power), type = "l", ylab="Global Reactive Power", xlab="")
})
dev.off()