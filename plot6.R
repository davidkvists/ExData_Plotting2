#Explorarory data analysis
#Course project
#Plot 6.
#Compare emissions from motor vehicle sources in Baltimore City 
#with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037").
setwd(file.path("C:","Users","David","Documents","Financial Engineering","Coursera","Exploratory data analysis","Project2"))
##Loading necessary files

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(dplyr)
#In SCC data set SCC$Short.Name maps pollution source names with SCC code
#We can check which SCC$Short.Name row has strings "motor"  included in it refering as "motor vehicle" source
#Looking only for string "motor" fill include "motorcycles" as well.
#We also have to change all name variables to lower case.

SCC_source_index<-grep("motor" ,tolower(SCC$Short.Name))

##Next we extract SCC codes according to SCC_source_index vector
SCC_codes<-as.character(SCC$SCC[SCC_source_index])

#Selecting only pollution data from motor vehicle source in Baltimore and Los Angeles
SCC_dplyr<-tbl_df(NEI)
rm("NEI")
SCC_motor_BLA<-filter(SCC_dplyr,fips%in%c("24510","06037"),SCC%in%SCC_codes)

#Splitting fips column to "Baltimore" and "Los Angeles"

#Grouping data frame by year and fips
NEI_BLA_motor<-group_by(SCC_motor_BLA,fips,year)
#Summing all Emissions by year for Baltimore
NEI_motor<-summarize(NEI_BLA_motor, sum(Emissions))
colnames(NEI_motor)<-c("city","year","emissions")

#Modifying fips by its descriptive name

NEI_motor$city<-replace(NEI_motor$city,NEI_motor$city=="24510","Baltimore")
NEI_motor$city<-replace(NEI_motor$city,NEI_motor$city=="06037","Los Angeles")

 

#Constructing plots with pplot2
library(ggplot2)

qplot(y=emissions, x=as.factor(year), data=NEI_motor,geom="bar", stat="identity", fill=city)+
      xlab("") +ylab("Emissions (tons)") +ggtitle("Emissions from motor vehicle comparison in Baltimore and Los Angeles from 1999-2008")              


dev.copy(png,file="plot6.png", width=650, height=480)
dev.off()