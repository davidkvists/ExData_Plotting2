#Explorarory data analysis
#Course project
#Plot 4
#Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

setwd(file.path("C:","Users","David","Documents","Financial Engineering","Coursera","Exploratory data analysis","Project2"))
##Loading necessary files

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(dplyr)

#In SCC data set SCC$Short.Name maps pollution source names with SCC code
#We can check which SCC$Short.Name row has strings "coal" and "comb" included in it refering as "coal combustion" source
#We also have to change all name variables to lower case.

#We extract rows seperately by "coal" and 'comb' and then check if both names are included in the source names.
#Rows that does not include both "coal" and "comb" in the names are dropped.
SCC_index_coal<-grep("coal" ,tolower(SCC$Short.Name))
SCC_index_comb<-grep("comb", tolower(SCC$Short.Name))
SCC_source_index<-which(SCC_index_coal %in% SCC_index_comb)

##Next we extract SCC codes according to SCC_source_index vector
SCC_codes<-as.character(SCC$SCC[SCC_source_index])

##Next filtering NEI data frame according to coal combustion source
SCC_dplyr<-tbl_df(NEI)
rm("NEI")
SCC_coal<-filter(SCC_dplyr,SCC%in%SCC_codes)

#Grouping data frame by year a
NEI_coal_year<-group_by(SCC_coal,year)
#Summing all Emissions by year for Baltimore
NEI_coal<-summarize(NEI_coal_year, sum(Emissions))
colnames(NEI_coal)<-c("year","emissions")

#Constructing plots with pplot2
library(ggplot2)

qplot(y=emissions, x=as.factor(year), data=NEI_coal,geom="bar", stat="identity", fill=year)+
      xlab("") +ylab("Emissions PM25,(tons)") +ggtitle("Emissions from coal-combustions in USA from 1999-2008")              
 

dev.copy(png,file="plot4.png", width=480, height=480)
dev.off()