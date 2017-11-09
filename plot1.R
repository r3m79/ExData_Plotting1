####################################################
# Script for Plot 1 generation
####################################################
# Script must be executed in same folder as dataset
# for reading the Data, package sqldf will be used

#load library
library(sqldf)

#check if file exists
sourcefile<-"./household_power_consumption.txt"
if (!file.exists("./household_power_consumption.txt")){ 
    stop("Dataset file not present!") 
}

#read data
filecon<-file(sourcefile)
sqlstr<-"select * from filecon where Date =='1/2/2007' or Date =='2/2/2007'"
household<-sqldf(sqlstr,file.format=list(sep=";",header=TRUE))

#plot
hist(household$Global_active_power,xlab = "Global Active Power (killowats)",
     col="red",main="Global Active Power")

#write PNG
dev.copy(png,"plot1.png")
dev.off()
#close file connection
close(filecon)




