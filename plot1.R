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

GAP <- as.numeric(SubsetDataEPC$Global_active_power)
png("plot1.png", width = 480, height = 480)
hist(GAP, col = "red", main = "Global Active Power", xlab = "GAP (Kilowatts)")
dev.off()