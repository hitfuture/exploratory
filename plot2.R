#Create a graph  
library(data.table)
#Retrieve the data
house.hold.power<-read.csv("./data/household_power_consumption.txt",sep=";",header=TRUE , stringsAsFactors=FALSE, na.strings="?")
house.hold.power<-as.data.table(house.hold.power)
 
start<-"1/2/2007" 
end <-"2/2/2007"
#Filter the data based on 2 dates
range.of.power <- house.hold.power%>%filter(Date == start | Date == end)
range.of.power<-range.of.power%>%mutate(datetime=as.POSIXct(strptime(paste(Date,Time),'%d/%m/%Y %H:%M:%S')))
#Save the plot to a file
png("plot2.png", width = 480, height = 480)
plot2<-with(range.of.power,plot(datetime,Global_active_power,type="l",xlab="",ylab="Global Active Power (killowatts)",col="black",main=NULL))
print(plot2)
dev.off()
