#Exploratory data analysis
#Course project2
#Problem 1.
#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, 
#make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
##Setting proper working directory
setwd(file.path("C:","Users","David","Documents","Financial Engineering","Coursera","Exploratory data analysis","Project2"))
##Loading necessary files

NEI <- readRDS("summarySCC_PM25.rds")
 


library(dplyr)
NEI_dplyr<-tbl_df(NEI)
#Grouping data frame by year 
NEI_by_year<-group_by(NEI_dplyr,year)
#Summing all Emissions by year
NEI_emi<-summarize(NEI_by_year, sum(Emissions))

#Constructing the plot
barplot(NEI_emi$sum, main="Pollutant emissions in USA from 1999-2008",
        names.arg=c(1999,2002,2005,2008),ylab="PM25 (tons)",col=c("red","red","red","green"))
dev.copy(png,file="plot1.png")
dev.off()
