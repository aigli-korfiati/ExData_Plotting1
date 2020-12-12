#getting data from the web
rawDataDir <- "./rawData"
rawDataUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
rawDataFilename <- "exdata_data_household_power_consumption.zip"
rawDataDFn <- paste(rawDataDir, "/", rawDataFilename, sep = "")
dataDir <- "./data"
#generate a rawData folder for the zip file
if (!file.exists(rawDataDir)) {
  dir.create(rawDataDir)
  download.file(rawDataUrl, rawDataDFn)
}
#generate a data folder for the extracted folder
if (!file.exists(dataDir)) {
  dir.create(dataDir)
  unzip(rawDataDFn, exdir = dataDir)
}

# read data we specify headers true, seperator and NA symbol
data <- read.table(paste(sep = "/", dataDir, "household_power_consumption.txt"), header = TRUE, sep = ";", na.strings = "?")

# keep only rows with specific dates and all columns
datasubset <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007",]

#concatenate date and time
datetime <- paste(datasubset$Date, datasubset$Time)
#and format the concatenated date and time
datetimeformatted <- strptime(datetime, "%d/%m/%Y %H:%M:%S")

# plot4
png(filename = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2,2))
plot(datetimeformatted, datasubset$Global_active_power,type = "l", xlab = "", ylab = "Global Active Power")

plot(datetimeformatted, datasubset$Voltage,type = "l", xlab = "datetime", ylab = "Voltage")

plot(datetimeformatted, datasubset$Sub_metering_1,type="n", xlab="", ylab = "Energy sub metering")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"),lty = 1)
points(datetimeformatted, datasubset$Sub_metering_1,type="l", col="black")
points(datetimeformatted, datasubset$Sub_metering_2, type="l", col="red")
points(datetimeformatted, datasubset$Sub_metering_3, type="l", col="blue")

plot(datetimeformatted, datasubset$Global_reactive_power,type = "l", xlab = "datetime", ylab = "Global_reactive_power")

dev.off()