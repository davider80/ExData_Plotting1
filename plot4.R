require(sqldf)

#------------------------------------------------------
# Download of dataset
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
unzip(temp)
unlink(temp)

#------------------------------------------------------
# Read data set by selecting only the date range
df <- read.csv.sql("household_power_consumption.txt", 
        sep=";",
        sql = 'select * from file where Date = "1/2/2007" or Date = "2/2/2007"')

#------------------------------------------------------
# Convert Date/Time to POSIX
df$Datetime <- as.POSIXct(paste(df$Date, df$Time),format = "%d/%m/%Y %H:%M:%S")


#------------------------------------------------------
# Plot 4
png("plot4.png", width=480, height=480, units="px",bg = "transparent")

par(mfrow = c(2, 2))

#First plot, similae as plot2.r
plot(df$Datetime, df$Global_active_power, type="l", main="",xlab="", ylab="Global Active Power") 

#Second plot
plot(df$Datetime, df$Voltage, type="l", main="",xlab="datetime", ylab="Voltage") 


#Third plot, similar as plot3.r but without legend border
plot(df$Datetime, df$Sub_metering_1, type="l", main="",xlab="", ylab="Energy sub metering") 
lines(df$Datetime, df$Sub_metering_2, col="red") 
lines(df$Datetime, df$Sub_metering_3, col="blue") 
legend("topright", lty=c(1,1,1), bty = "n", col = c("black", "blue", "red"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#Fourth plot
plot(df$Datetime, df$Global_reactive_power, type="l", main="",xlab="datetime", ylab="Global_reactive_power",ylim=c(0,0.5)) 

dev.off()
