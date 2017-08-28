## Setting work directory
## setwd( "your working directory here")

## Setting locale 
## I had issues with weekday names in my own language
## This way they will appear in English
Sys.setlocale("LC_TIME", "C")

## Data download
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="data.zip")

## Unzipping
unzip("data.zip")

## Loading libraries
library(dplyr)
library(graphics)
library(grDevices)

## load file into a data frame
origData <- read.csv("household_power_consumption.txt", sep=";",stringsAsFactors = FALSE)
origData <- mutate(origData,Date1=as.Date(Date,"%d/%m/%Y"))
dAux <- c( "2007-02-01", "2007-02-02")
dAux <- as.Date (dAux, "%Y-%m-%d")
workData <- subset( origData, Date1 %in% dAux)
workData <- mutate(workData, fullDate = as.POSIXct(paste(workData$Date,workData$Time), "%d/%m/%Y %H:%M:%S", tz=""))

## PLot 4
png(file="plot4.png",width=480, height=480)
## Setting plot frame
par(mfcol=c(2,2))
## Plot 1/4
with(workData,plot(fullDate,Global_active_power,type="l",xlab="",ylab="Global Active Power"))
## Plot 2/4
with(workData,plot(fullDate,Sub_metering_1,type="l",xlab="",ylab="Energy sub metering"))
with(workData,lines(fullDate,workData$Sub_metering_2, type='l', col="red"))
with(workData,lines(fullDate,workData$Sub_metering_3, type='l', col="blue"))
legend("topright", bty = "n", lty=1, cex=0.9, col=c("black","blue","red"),legend=c("Sub_metering_1", "Sub_metering_2", "Sub-metering_3"))
## Plot 3/4
with(workData,plot(fullDate,Voltage,type="l",xlab="datetime"))
## Plot 4/4
with(workData,plot(fullDate,Global_reactive_power,type="l",xlab="datetime"))

dev.off()


