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

# creating plot in file

png("plot1.png")
with(data, hist(as.numeric(Global_active_power), col = "red", xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power"))
dev.off()