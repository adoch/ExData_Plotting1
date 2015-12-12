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
    if (file.exists("plot2.png")){
        file.remove("plot2.png")
    }
    
    png(file = "plot2.png") ##480x480 is the default size of the plot
    plot(plotdata$Time, plotdata$Global_active_power, type = "l", 
         ylab = "Global Active Power (kilowatts)", xlab = "")
    dev.off()
    
} else {
    print("Error: File household_power_consumption.txt does not exist in the Working Directory!!!")
}