#Exploratory data analysis
#Course project2
#Problem 2.
#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
##Setting proper working directory
setwd(file.path("C:","Users","David","Documents","Financial Engineering","Coursera","Exploratory data analysis","Project2"))
##Loading necessary files

NEI <- readRDS("summarySCC_PM25.rds")

library(dplyr)

NEI_dplyr<-tbl_df(NEI)
rm("NEI")
#Selecting only pollution data from Baltimore
NEI_dplyr_Balt<-filter(NEI_dplyr,fips=="24510")
#Grouping data frame by year 
NEI_Balt_by_year<-group_by(NEI_dplyr_Balt,year)
#Summing all Emissions by year for Baltimore
NEI_emi_Balt<-summarize(NEI_Balt_by_year, sum(Emissions))
#Constructing the plot
barplot(NEI_emi_Balt$sum, main="Pollutant emissions in Baltimore from 1999-2008",
        names.arg=c(1999,2002,2005,2008),ylab="PM25 (tons)", col=c("red","red","red","green"))
dev.copy(png,file="plot2.png")
dev.off()
 
