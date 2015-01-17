
#Explorarory data analysis
#Course project
#Plot 3.
#Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
#which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
#Which have seen increases in emissions from 1999-2008? Use the ggplot2 plotting system to make a plot answer this question.
setwd(file.path("C:","Users","David","Documents","Financial Engineering","Coursera","Exploratory data analysis","Project2"))
##Loading necessary files

NEI <- readRDS("summarySCC_PM25.rds")

library(dplyr)
NEI_dplyr<-tbl_df(NEI)
rm("NEI_dplyr")
#Selecting only pollution data from Baltimore
NEI_dplyr_Balt<-filter(NEI_dplyr,fips=="24510")
#Grouping data frame by year and type
NEI_Balt_year_type<-group_by(NEI_dplyr_Balt,year,type)
#Summing all Emissions by year for Baltimore
NEI_emi_Balt_type<-summarize(NEI_Balt_year_type, sum(Emissions))
colnames(NEI_emi_Balt_type)<-c("year","type","emissions")

#Constructing plots with pplot2
library(ggplot2)

qplot(y=emissions, x=as.factor(year), data=NEI_emi_Balt_type,geom="bar", stat="identity", facets=.~type, fill=year)+
xlab("") +ylab("Emissions PM25, (tons)") +ggtitle("Emissions in Baltimore city from 1999-2008 by source type")
dev.copy(png,file="plot3.png", width=620, height=480)
dev.off()
