##Downloading the data
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile = "./Desktop/Eda_Data.zip",method = "curl")

##unzipping the file
unzip("./Desktop/Eda_Data.zip")

##reading the data from file
eda_data <- read.table("./Desktop/household_power_consumption.txt",header = TRUE,sep = ";",stringsAsFactors = FALSE,na.strings = "?")

##converting the date format 
eda_data$Date <- as.Date(eda_data$Date,format= "%d/%m/%Y")

##filtering the data only for two dates
eda_data_sample <- eda_data[eda_data$Date>="2007-02-01"&eda_data$Date<="2007-02-02",]

##Adding new column containg both date and time
eda_data_sample$DateTime <- as.POSIXct(paste(eda_data_sample$Date,eda_data_sample$Time))

##converting Global_active_power,Sub_metering,voltage,global reactive power fields into numeric
eda_data_sample$Global_active_power <- as.numeric(eda_data_sample$Global_active_power)
eda_data_sample$Global_reactive_power <- as.numeric(eda_data_sample$Global_reactive_power)
eda_data_sample$Voltage <- as.numeric(eda_data_sample$Voltage)
eda_data_sample$Sub_metering_1 <- as.numeric(eda_data_sample$Sub_metering_1)
eda_data_sample$Sub_metering_2 <- as.numeric(eda_data_sample$Sub_metering_2)
eda_data_sample$Sub_metering_3 <- as.numeric(eda_data_sample$Sub_metering_3)

##plotting graph
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(eda_data_sample,{plot(eda_data_sample$DateTime,eda_data_sample$Global_active_power,xlab="",ylab="Global Active Power (kilowatts)",type="l")
plot(eda_data_sample$DateTime,eda_data_sample$Voltage,xlab="datetime",ylab="",type="l")
plot(DateTime,Sub_metering_1,type="l",xlab="",ylab="Energy Sub Metering")
  lines(DateTime,Sub_metering_2,type="l",col="Red")
  lines(DateTime,Sub_metering_3,type="l",col="Blue")
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.5)
plot(eda_data_sample$DateTime,eda_data_sample$Global_reactive_power,xlab="datetime",ylab="Global_reactive_power",type="l")})

##Exporting the graph into png file 
dev.copy(png, file="./Desktop/plot4.png", height=480, width=480)
dev.off()
