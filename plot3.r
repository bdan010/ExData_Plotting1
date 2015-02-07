
plot3 <- function() {
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
    
    #create plot with parameters
    plot(elecDataFiltered$dateTime,
         elecDataFiltered$Sub_metering_1, type="l", col="black",
         ylab="Energy sub metering", xlab="")
    #add two more series manually on top
    lines(elecDataFiltered$dateTime,elecDataFiltered$Sub_metering_2, col="red")
    lines(elecDataFiltered$dateTime,elecDataFiltered$Sub_metering_3, col="blue")
    
    #assign axises manually at three positions
    axis.POSIXct(side=1, x=elecDataFiltered$dateTime, format="%a",
                 at=c(elecDataFiltered$dateTime[1],
                      elecDataFiltered$dateTime[1441],
                      as.POSIXct("2007-02-03 00:00")))
    axis(2, c(0,10,20,30)) 
    
    legend("topright", col=c("black","red","blue"),
           legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),
           lty=c(1,1,1), lwd=c(1,1,1), cex=0.7)
    
    ##copy to file
    library(datasets)
    dev.copy(png, file = "plot3.png")
    dev.off()
}