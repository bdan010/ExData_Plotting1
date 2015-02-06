



plot1 <- function() {
    ## Read datafile - set column info
    vars <- c("character", "character", rep("numeric", 7))
    
    ##pull in file, only first few days
    elecData <- read.table("./data/household_power_consumption.txt",
                           header=TRUE, sep=";", colClasses = vars, na.strings="?",
                           nrows=69516)
    
    #Make a POSIX date/time column at the end
    dateTime <- as.POSIXlt(paste(as.Date(elecData$Date,format="%d/%m/%Y"),
                                 elecData$Time, sep=" "))
    elecData<- cbind(elecData, dateTime)
    
    #remove all dates earlier than 2-1-07
    elecDataFiltered<-subset(elecData,dateTime > "2007-02-01 00:00")
    
    hist(elecDataFiltered$Global_active_power, col="red",
              main="Global Active Power",
              xlab="Global Active Power (kilowatts)",
              ylab="Frequency", freq=TRUE , breaks=12, axes=FALSE, plot=TRUE)
    axis(1, c(0,2,4,6))
    axis(2, c(0,200,400,600,800,1000,1200)) 
    
    library(datasets)
    dev.copy(png, file = "plot1.png")
    dev.off()
}