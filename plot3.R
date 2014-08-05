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
# Plot 3
png("plot3.png", width=480, height=480, units="px",bg = "transparent")

plot(df$Datetime, df$Sub_metering_1, type="l", main="",xlab="", ylab="Energy sub metering") 
lines(df$Datetime, df$Sub_metering_2, col="red") 
lines(df$Datetime, df$Sub_metering_3, col="blue") 
legend("topright", lty=c(1,1,1), col = c("black", "blue", "red"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.off()
