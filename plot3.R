#Create a plot that show each Sub metering vector.
library(data.table)
 

house.hold.power<-read.csv("./data/household_power_consumption.txt",sep=";",header=TRUE , stringsAsFactors=FALSE, na.strings="?")
house.hold.power<-as.data.table(house.hold.power)

start<-"1/2/2007" 
end <-"2/2/2007"

range.of.power <- house.hold.power%>%filter(Date == start | Date == end)
range.of.power<-range.of.power%>%mutate(datetime=as.POSIXct(strptime(paste(Date,Time),'%d/%m/%Y %H:%M:%S')))

png("plot3.png", width = 480, height = 480)
 
plot3<-with(range.of.power,plot(datetime,Sub_metering_1,type="l",xlab="",ylab="Energy sub metering",col="black",main=NULL))
with(range.of.power,lines(datetime,Sub_metering_2,col="red" ))
with(range.of.power,lines(datetime,Sub_metering_3,col="blue" ))
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1), 
       col=c("black","red","blue"))

print(plot3)
dev.off()
