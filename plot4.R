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
    if (file.exists("plot4.png")){
        file.remove("plot4.png")
    }
    
    png(file = "plot4.png") ##480x480 is the default size of the plot
    
    par("mfrow"= c(2,2) ) ##define 2x2 graphs
    ## graph 1
    plot(plotdata$Time, plotdata$Global_active_power, type = "l", 
         ylab = "Global Active Power", xlab = "")
    ## graph 2
    plot(plotdata$Time, plotdata$Voltage, type = "l", xlab = "datetime")
    ## graph 3
    plot(plotdata$Time, plotdata$Sub_metering_1, type = "l", col = "black", 
         ylab = "Energy sub metering", xlab = "")
    lines(plotdata$Time, plotdata$Sub_metering_2, type = "l", col = "red")
    lines(plotdata$Time, plotdata$Sub_metering_3, type = "l", col = "blue")
    legend('topright', c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
           lty = 1, col=c("black", "red", "blue"), bty = "n")
    ## graph 4
    plot(plotdata$Time, plotdata$Global_reactive_power, type = "l", 
         ylab = "Global_reactive_power", xlab = "datetime")
    dev.off()
    
} else {
    print("Error: File household_power_consumption.txt does not exist in the Working Directory!!!")
}