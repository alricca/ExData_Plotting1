#project4 - Plot 2

#load dplyr to use mutate and filter

library(plyr)
library(dplyr)

#load and read file from website

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("./project3")) {dir.create("./project3")}
if(!file.exists("./project4")) {dir.create("./project4")}
download.file(fileUrl, destfile = "./project4/zippedfile", method = "curl")
filenames <- unzip("./project4/zippedfile", list = TRUE)
unzip("./project4/zippedfile")
elec_data <- read.table(filenames$Name, header = TRUE, sep = ";", stringsAsFactors = FALSE, na.strings = "?")

#extract teh dates in question

elect <- mutate(elec_data, Date = as.character(Date))
elec1 <- filter(elect, Date == "1/2/2007")
elec2 <- filter(elect, Date == "2/2/2007")
electricity <- rbind(elec1, elec2)

# merge dates and times and then convert to POSITXct format

fixed_dates <- mutate(electricity, Date = gsub("1/2/", "01-02-", Date))
fixed_dates <- mutate(fixed_dates, Date = gsub("2/2/", "02-02-", Date))
new_date <- mutate(fixed_dates, Date_Time = paste(Date, Time))
fixed_elec <- mutate(new_date, Date_Time = as.POSIXct(Date_Time, format = "%d-%m-%Y %H:%M:%S"))

# open png file

png(filename = "plot2.png")

#Plot 1

# reset parameters to defaults


par(mar=c(5.1, 4.1, 4.1,2.1))
par(mfcol= c(1,1))

# Draw Plot 2

plot(fixed_elec$Date_Time, fixed_elec$Global_active_power, ylab = "Global Active Power (kilowatts", xlab ="", type = "l")

dev.off()
