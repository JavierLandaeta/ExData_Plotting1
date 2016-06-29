#If you already download the zip file, please be sure the name
#is "exdata%2Fdata%2Fhousehold_power_consumption.zip" and keep this file in your WD. If you haven´t,
#the code will download the file for you.

WD <- getwd()
dest_file <- paste(WD, "/exdata%2Fdata%2Fhousehold_power_consumption.zip")
dest_file <- gsub(" /", "/", dest_file)

#Checks if the EPC.zip exist in the WD
if (!file.exists(dest_file, showWarnings = FALSE)){
  URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  temp <- tempfile()
  download.file(URL, temp)
  dataEPC <- read.table(unz(temp, "household_power_consumption.txt"), header = TRUE, sep = ";", stringsAsFactors = FALSE, dec = ".")
  unlink(temp)
}else{
  dataEPC <- read.table(unz(dest_file,"household_power_consumption.txt"), header = TRUE, sep = ";", stringsAsFactors = FALSE, dec = ".")
}

SubsetDataEPC <- dataEPC[dataEPC$Date %in% c("1/2/2007", "2/2/2007"),]

Calendar <- strptime(paste(SubsetDataEPC$Date, SubsetDataEPC$Time, sep = " "), "%d/%m/%Y %H:%M:%S")
GAP <- as.numeric(SubsetDataEPC$Global_active_power)
Voltage <- as.numeric(SubsetDataEPC$Voltage)
SubM1 <- as.numeric(SubsetDataEPC$Sub_metering_1)
SubM2 <- as.numeric(SubsetDataEPC$Sub_metering_2)
SubM3 <- as.numeric(SubsetDataEPC$Sub_metering_3)
GRP <- as.numeric(SubsetDataEPC$Global_reactive_power)


png("plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))

plot(Calendar, GAP, type = "l", xlab = "", ylab = "GAP")
plot(Calendar, Voltage, type = "l", xlab = "", ylab = "Voltage")
plot(Calendar, SubM1, type = "l", xlab = "", ylab = "Energy sun metering")
lines(Calendar, SubM2, type = "l", col = "red")
lines(Calendar, SubM3, type = "l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, lwd = 2, col = c("black", "red", "blue"))
plot(Calendar, GRP, type = "l", xlab = "Datetime", ylab = "GRP")

dev.off()