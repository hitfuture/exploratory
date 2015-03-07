## Build the multi-graph panel

library(data.table)
 

house.hold.power<-read.csv("./data/household_power_consumption.txt",sep=";",header=TRUE , stringsAsFactors=FALSE, na.strings="?")
house.hold.power<-as.data.table(house.hold.power)

dt<-as.POSIXct(strptime("2/2/2007 23:55:00","%d/%m/%Y %H:%M:%S"))

start<-"1/2/2007" 
end <-"2/2/2007"

range.of.power <- house.hold.power%>%filter(Date == start | Date == end)
range.of.power<-range.of.power%>%mutate(datetime=as.POSIXct(strptime(paste(Date,Time),'%d/%m/%Y %H:%M:%S')))

png("plot4.png", width = 480, height = 480)
par(mfrow=c(2,2) )
plot1<-with(range.of.power,plot(datetime,Global_active_power,
                                ylab="Global Active Power (killowatts)",type="l",
                                xlab="",col="black",main=NULL))
print(plot1)

plot2<-with(range.of.power,plot(datetime,Voltage,type="l",col="black",main=NULL))
print(plot2)

plot3<-with(range.of.power,plot(datetime,Sub_metering_1,type="l",xlab="",
                                ylab="Energy sub metering",col="black",main=NULL))
with(range.of.power,lines(datetime,Sub_metering_2,col="red" ))
with(range.of.power,lines(datetime,Sub_metering_3,col="blue" ))
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1), 
       col=c("black","red","blue"),
       box.lwd=0)
print(plot3)

plot4<-with(range.of.power,plot(datetime,Global_reactive_power,type="l"))
print(plot4)
dev.off()
