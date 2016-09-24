#Read Data
temp <- tempfile()
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- unzip(temp)
unlink(temp)
data2 <- read.table(data, header=T, sep=";")
data2$Date <- as.Date(data2$Date, format="%d/%m/%Y")
df <- data2[(data2$Date=="2007-02-01") | (data2$Date=="2007-02-02"),]
df$Global_active_power <- as.numeric(as.character(df$Global_active_power))
df$Global_reactive_power <- as.numeric(as.character(df$Global_reactive_power))
df$Voltage <- as.numeric(as.character(df$Voltage))
df <- transform(df, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
df$Sub_metering_1 <- as.numeric(as.character(df$Sub_metering_1))
df$Sub_metering_2 <- as.numeric(as.character(df$Sub_metering_2))
df$Sub_metering_3 <- as.numeric(as.character(df$Sub_metering_3))

#Plot4
plot4 <- function() {
par(mfrow=c(2,2))
  
plot(df$timestamp,df$Global_active_power, type="l", 
     xlab="", ylab="Global Active Power")

plot(df$timestamp,df$Voltage, type="l", 
     xlab="datetime", ylab="Voltage")
  
plot(df$timestamp,df$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(df$timestamp,df$Sub_metering_2,col="red")
lines(df$timestamp,df$Sub_metering_3,col="blue")
legend("topright", 
       col=c("black","red","blue"), 
       c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),
       lty=c(1,1), bty="n", cex=.5) 
  
plot(df$timestamp,df$Global_reactive_power, type="l", 
     xlab="datetime", ylab="Global_reactive_power")
  
dev.copy(png, file="plot4.png", 
         width=480, height=480)
dev.off()}
plot4()