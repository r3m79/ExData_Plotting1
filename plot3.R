####################################################
# Script for Plot 3 generation
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


#plot
with(household,plot(datetime,Sub_metering_1,type="n",xlab="",ylab="Energy sub metering"))
with(household,lines(datetime,Sub_metering_1))
with(household,lines(datetime,Sub_metering_2,col="red"))
with(household,lines(datetime,Sub_metering_3,col="blue"))
legend("topright",pch="-",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=0.9,lty=1)


#write PNG
dev.copy(png,"plot3.png")
dev.off()
#close file connection
close(filecon)




