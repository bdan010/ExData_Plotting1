
plot4 <- function() {
    ## Read datafile - set column info
    vars <- c("character", "character", rep("numeric", 7))
    
    ##pull in file, only first few days
    elecData <- read.table("./data/household_power_consumption.txt",
                           header=TRUE, sep=";", colClasses = vars, na.strings="?",
                           nrows=69516)
    
    #Make a POSIX date/time column at the end
    dateTime <- as.POSIXct(paste(as.Date(elecData$Date,format="%d/%m/%Y"),
                                 elecData$Time, sep=" "))
    elecData<- cbind(elecData, dateTime)
    
    #remove all dates earlier than 2-1-07
    elecDataFiltered<-subset(elecData,dateTime > "2007-02-01 00:00")
    
    #create 2x2 plotting area
    par(mfrow = c(2,2))
    
    #create plot 1 with parameters
    plot(elecDataFiltered$dateTime,
         elecDataFiltered$Global_active_power, type="l",
         ylab="Global Active Power", xlab="")
    
    #plot 1: assign axises manually at three positions
    axis.POSIXct(side=1, x=elecDataFiltered$dateTime, format="%a",
                 at=c(elecDataFiltered$dateTime[1],
                      elecDataFiltered$dateTime[1441],
                      as.POSIXct("2007-02-03 00:00")))
    axis(2, c(0,2,4,6)) 
    
    #create plot 2 with parameters
    plot(elecDataFiltered$dateTime,
         elecDataFiltered$Voltage, type="l",
         ylab="Voltage", xlab="datetime")
    
    #create plot 3 with parameters
    plot(elecDataFiltered$dateTime,
         elecDataFiltered$Sub_metering_1, type="l", col="black",
         ylab="Energy sub metering", xlab="")
    #3- add two more series manually on top
    lines(elecDataFiltered$dateTime,elecDataFiltered$Sub_metering_2, col="red")
    lines(elecDataFiltered$dateTime,elecDataFiltered$Sub_metering_3, col="blue")
    #3- assign axises manually at three positions
    axis.POSIXct(side=1, x=elecDataFiltered$dateTime, format="%a",
                 at=c(elecDataFiltered$dateTime[1],
                      elecDataFiltered$dateTime[1441],
                      as.POSIXct("2007-02-03 00:00")))
    axis(2, c(0,10,20,30)) 
    #3-create legend
    legend("topright", col=c("black","red","blue"),
           legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),
           lty=c(1,1,1), lwd=c(1,1,1), cex=0.4)
    
    #create plot 4 
    plot(elecDataFiltered$dateTime,
         elecDataFiltered$Global_reactive_power, type="l",
         ylab="Global_reactive_power", xlab="datetime")
    
    
    ##copy to file
    library(datasets)
    dev.copy(png, file = "plot4.png")
    dev.off()
}