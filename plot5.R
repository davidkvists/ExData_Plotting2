#Explorarory data analysis
#Course project
#Plot 5.
#How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City? 

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

#Selecting only pollution data from motor vehicle source in Baltimore
SCC_dplyr<-tbl_df(NEI)
rm("NEI")
SCC_motor<-filter(SCC_dplyr,fips=="24510",SCC%in%SCC_codes)

#Grouping data frame by year 
NEI_Balt_motor<-group_by(SCC_motor,year)
#Summing all Emissions by year for Baltimore
NEI_motor<-summarize(NEI_Balt_motor, sum(Emissions))
colnames(NEI_motor)<-c("year","emissions")

#Constructing plots with pplot2
library(ggplot2)

qplot(y=emissions, x=as.factor(year), data=NEI_motor,geom="bar", stat="identity", fill=year)+
      xlab("") +ylab("Emissions PM25, (tons)") +ggtitle("Emissions from motor vehicles in Baltimore from 1999-2008")              


dev.copy(png,file="plot5.png", width=480, height=480)
dev.off()