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

##converting Sub_metering fields into numeric
eda_data_sample$Sub_metering_1 <- as.numeric(eda_data_sample$Sub_metering_1)
eda_data_sample$Sub_metering_2 <- as.numeric(eda_data_sample$Sub_metering_2)
eda_data_sample$Sub_metering_3 <- as.numeric(eda_data_sample$Sub_metering_3)

##plotting graph
with(eda_data_sample,{plot(DateTime,Sub_metering_1,type="l",xlab="",ylab="Energy Sub Metering")
  lines(DateTime,Sub_metering_2,type="l",col="Red")
  lines(DateTime,Sub_metering_3,type="l",col="Blue")})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=1, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.8)

##Exporting the graph into png file 
dev.copy(png, file="./Desktop/plot3.png", height=480, width=480)
dev.off()
