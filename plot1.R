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

##converting Global_active_power filed into numeric
eda_data_sample$Global_active_power <- as.numeric(eda_data_sample$Global_active_power)

##plotting histogram 
hist(eda_data_sample$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red", cex.sub=0.8)

##Exporting the graph into png file 
dev.copy(png, file="./Desktop/plot1.png", height=480, width=480)
dev.off()
