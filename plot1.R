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
# Plot 1
png("plot1.png", width=480, height=480, units="px",bg = "transparent")

hist(df$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", ylim=c(0,1200), col="red")

dev.off()
