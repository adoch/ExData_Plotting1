if (file.exists("household_power_consumption.txt")){
    ##read data and filter them so that the rest processing be faster
    ##pitty that you can not horizontally filter while reading the file
    pdata <- read.csv("household_power_consumption.txt", sep=";", na.strings = c("?"), 
                      colClasses = c(rep("character",2),rep("numeric",7)))
    plotdata <- pdata[pdata$Date %in% c("1/2/2007","2/2/2007"),]
    
    ##convert to date/time
    plotdata$Time <- strptime(paste(plotdata$Date,plotdata$Time), "%d/%m/%Y %H:%M:%S")
    plotdata$Date <- as.Date(plotdata$Date, "%d/%m/%Y")
    
    ##plot
    if (file.exists("plot3.png")){
        file.remove("plot3.png")
    }
    
    png(file = "plot3.png") ##480x480 is the default size of the plot
    plot(plotdata$Time, plotdata$Sub_metering_1, type = "l", col = "black", 
         ylab = "Energy sub metering", xlab = "")
    lines(plotdata$Time, plotdata$Sub_metering_2, type = "l", col = "red")
    lines(plotdata$Time, plotdata$Sub_metering_3, type = "l", col = "blue")
    legend('topright', c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
           lty = 1, col=c("black", "red", "blue"))
    dev.off()
    
} else {
    print("Error: File household_power_consumption.txt does not exist in the Working Directory!!!")
}