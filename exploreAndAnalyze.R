#install.packages("fasttime")
#install.packages("GGally")
library(data.table)
library(ggplot2)
library(dplyr)
library(GGally)
library(scales)
library(gridExtra)

#house.hold.power<-fread("./data/household_power_consumption.txt",sep=";",header=TRUE , na.strings="?", verbose=TRUE)
house.hold.power<-read.csv("./data/household_power_consumption.txt",sep=";",header=TRUE , stringsAsFactors=FALSE, na.strings="?")

house.hold.power<-as.data.table(house.hold.power)
#house.hold.power%>%mutate(datetime=strptime(paste(Date,Time),'%d/%m/%Y %H:%M:%S'))
#house.hold.power$Date <- as.Date(house.hold.power$Date,"%d/%m/%Y")
#house.hold.power$Time <- strptime(house.hold.power$Time,"%H:%M:%S") 
 
dt<-as.POSIXct(strptime("2/2/2007 23:55:00","%d/%m/%Y %H:%M:%S"))


#start<-as.Date("2007-02-01","%Y-%m-%d") 
#end <- as.Date("2007-02-02", "%Y-%m-%d")

start<-"1/2/2007" 
end <-"2/2/2007"

range.of.power <- house.hold.power%>%filter(Date == start | Date == end)
range.of.power<-range.of.power%>%mutate(datetime=as.POSIXct(strptime(paste(Date,Time),'%d/%m/%Y %H:%M:%S')))

require(grid)
require(ggplot2)
#png("plot1.png", width = 400, height = 480)
 
plt1<-ggplot(range.of.power, aes(x=Global_active_power)) +   
       geom_histogram(binwidth=0.5,fill="red",color="black")  +
        ylab("Frequency") +
        xlab("Global Active Power (kilowatts)") +
        ggtitle("Glabal Active Power") +
        
        theme_bw() +
        theme( plot.title = element_text( size = rel (1.5), lineheight =.9, family ="Times", face ="bold.italic", colour ="black")) +
        theme(panel.grid.major=element_blank(),panel.grid.minor=element_blank(),panel.border=element_rect(size=0)) +
        coord_cartesian(xlim = c(0,8)) #+
       # geom_rug()
       # xlim(0,6)
 
print(plt1)
#dev.off()
label.builder<-function(x) {
        weekdays(x,abbreviate=TRUE)
}
pltActive<-ggplot(range.of.power, aes(x=datetime,y=Global_active_power),stat="identity") +   
        geom_line(fill="white",color="black")  +
        scale_x_datetime(breaks=date_breaks("1 day"),labels=label.builder) +
        ylab("Global Active Power (kilowatts)") +
        theme_bw() +
        theme( plot.title = element_text( size = rel (1.5), lineheight =.9, family ="Times", face ="bold.italic", colour ="black")) +
        theme(panel.grid.major=element_blank(),panel.grid.minor=element_blank()) 
print(pltActive)

pltSubmetering<-ggplot(range.of.power, aes(x=datetime,y=Sub_metering_1,color="black"),stat="identity") +   
        geom_line(fill="white",color="black")  +
         ylab("Energy sub metering") +
       scale_x_datetime(breaks=date_breaks("1 day"),labels=label.builder) +
        geom_line( aes(y=Sub_metering_2,  colour="red"),stat="identity")+
        geom_line( aes(y=Sub_metering_3,colour="darkblue"),stat="identity")+
       # geom_line( aes(y=Sub_metering_2,  colour="darkblue"),color="darkblue",stat="identity")+
       # geom_line( aes(y=Sub_metering_3,colour="red"),color = "red",stat="identity")+
        
       #Add in a legend
       theme_bw() +
      #  scale_fill_identity(name = 'the fill', guide = 'legend',labels = c('m1')) +
        scale_colour_manual(name="Line Color",
                            values=c(black="black", darkblue ="darkblue", red="red")) +
        theme( legend.position = "topright")
print(pltSubmetering)
#legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"))
pltVoltage<-ggplot(range.of.power, aes(x=datetime,y=Voltage),stat="identity") +   
        geom_line(fill="white",color="black")  +
        scale_x_datetime(breaks=date_breaks("1 day"),labels=label.builder) +
        ylab("Voltage") +
        theme_bw() +
        theme( plot.title = element_text( size = rel (1.5), lineheight =.9, family ="Times", face ="bold.italic", colour ="black")) +
        theme(panel.grid.major=element_blank(),panel.grid.minor=element_blank()) 
print(pltVoltage)

pltReactive<-ggplot(range.of.power, aes(x=datetime,y=Global_reactive_power),stat="identity") +   
        geom_line(fill="white",color="black")  +
        scale_x_datetime(breaks=date_breaks("1 day"),labels=label.builder) +
        ylab("Global Reactive Power (kilowatts)") +
        theme_bw() +
        theme( plot.title = element_text( size = rel (1.5), lineheight =.9, family ="Times", face ="bold.italic", colour ="black")) +
        theme(panel.grid.major=element_blank(),panel.grid.minor=element_blank()) 
print(pltReactive)

#Arrange the 4 graphs into a grid.
grid.arrange(pltSubmetering,pltReactive,pltActive,pltVoltage,nrow=2,as.table=TRUE)

