# downloadData.R
site<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
#Step 0. Download data
## Create the ./data directory if it does not exist.
if(!file.exists("./data")) {
        dir.create("data") 
        message("Createing directory: ./data")
}
## Download the data from the Internet if it does not exist.
if(!file.exists("./data/power_consumption.zip")) {
        data.source.url<-site
        download.file(url=data.source.url,destfile="./data/power_consumption.zip",method="curl")
        download.date<-date()
##Manually unzip the file so that it can be processed.        
        
} 


