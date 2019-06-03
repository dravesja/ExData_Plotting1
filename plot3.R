##### First Project in Exploratory Data Analysis                                                  #####
##### Using Household Power Comsumption data from the UC Irving Machine Learning Site             #####

library(lubridate)

### Downloading file as zip, convert to txt and read into data table.  Could have read in file    ###
### directly from web site instead of downlaoding from the link provided                          ###
household_power_consumption <- read.table("household_power_consumption.txt", header=TRUE, sep=";")

### Organizing and cleaning date for the time frame of 2007-02-01 through 2007-02-02.             ###
household_power_consumption[,1] <- as.Date(household_power_consumption[,1], format = "%d/%m/%Y") #format Date

# Subsetting into a working data set
hpcwork <- subset(household_power_consumption, household_power_consumption[,1] >="2007-02-01" & 
                                               household_power_consumption[,1]<= "2007-02-02")

# Removing missing data which is indicated by a "?"
hpcworking <- hpcwork[!grepl("\\?", hpcwork[,2]),]

# Converting to numeric data
hpcworking$Global_active_power <-as.numeric(as.character((hpcworking$Global_active_power)))
hpcworking$Global_reactive_power <-as.numeric(as.character((hpcworking$Global_reactive_power)))
hpcworking$Voltage <-as.numeric(as.character((hpcworking$Voltage)))
hpcworking$Sub_metering_1 <-as.numeric(as.character((hpcworking$Sub_metering_1)))
hpcworking$Sub_metering_2 <-as.numeric(as.character((hpcworking$Sub_metering_2)))
hpcworking$Sub_metering_3 <-as.numeric(as.character((hpcworking$Sub_metering_3)))

#Creating file to produce time series plots
hpcworkingTime <- hpcworking
hpcworkingTime$DateTime <- ymd(hpcworkingTime[,1]) + hms(hpcworkingTime[,2])  #used functions in Lubridate Library


# Plot 3 saved as plot3.png is a time series plot of the three Sub metering observations
     
plot(hpcworkingTime$DateTime, hpcworkingTime$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
    lines(hpcworkingTime$DateTime, hpcworkingTime$Sub_metering_2, col = "red")
    lines(hpcworkingTime$DateTime, hpcworkingTime$Sub_metering_3, col = "blue")
    legend("topright", col = c("black", "red", "blue"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
          lty=c(1,1), lwd=c(1,1))
    dev.copy(png, file="plot3.png", width = 480, height = 480)
    dev.off

