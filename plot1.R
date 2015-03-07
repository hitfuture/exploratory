
library(data.table)
 

house.hold.power<-read.csv("./data/household_power_consumption.txt",sep=";",header=TRUE , stringsAsFactors=FALSE, na.strings="?")
house.hold.power<-as.data.table(house.hold.power)

dt<-as.POSIXct(strptime("2/2/2007 23:55:00","%d/%m/%Y %H:%M:%S"))

start<-"1/2/2007" 
end <-"2/2/2007"

range.of.power <- house.hold.power%>%filter(Date == start | Date == end)
range.of.power<-range.of.power%>%mutate(datetime=as.POSIXct(strptime(paste(Date,Time),'%d/%m/%Y %H:%M:%S')))

png("plot1.png", width = 480, height = 480)
 
plot1<-hist(range.of.power$Global_active_power,xlab="Global Active Power (killowatts)",col="red",main="Global Active Power")
print(plot1)
dev.off()
