####################################################
# Script for Plot 4 generation
####################################################
# Script must be executed in same folder as dataset
# for reading the Data, package sqldf will be used

#load library
library(sqldf)

#Since my local settings are not English, this will force the locale 
#so that the plot has the same naming in the x-axis as expected.
#Sys.setlocale("LC_ALL","English")

#check if file exists
sourcefile<-"./household_power_consumption.txt"
if (!file.exists("./household_power_consumption.txt")){ 
    stop("Dataset file not present!") 
}

#read data
filecon<-file(sourcefile)
sqlstr<-"select * from filecon where Date =='1/2/2007' or Date =='2/2/2007'"
household<-sqldf(sqlstr,file.format=list(sep=";",header=TRUE))
household$datetime<-strptime(paste(household$Date, household$Time, sep=" "), 
                             "%d/%m/%Y %H:%M:%S")

par(mfrow=c(2,2))
#plot
with(household,{
    plot(datetime,Global_active_power,type="l",xlab="",ylab="Global Active Power
         (killowats)")
    plot(datetime,Voltage,type="l",xlab="datetime",ylab="Voltage")
    plot(datetime,Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
    lines(datetime,Sub_metering_1)
    lines(datetime,Sub_metering_2,col="red")
    lines(datetime,Sub_metering_3,col="blue")
    legend("topright",pch="-",col=c("black","red","blue"),legend=
               c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=0.4,
           lty=1,bty="n")
    plot(datetime,Global_reactive_power,type="l",xlab="datetime")
}
)
 
#write PNG
dev.copy(png,"plot4.png")
dev.off()
#close file connection
close(filecon)




