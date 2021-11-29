#read the data
SCC <- readRDS("./Source_Classification_Code.rds")
NEI <- readRDS("./summarySCC_PM25.rds")

library(dplyr)

#########################################################################
#plot 3
##Of the four types of sources indicated by the type (point, nonpoint, 
###onroad, nonroad) variable, which of these four sources have seen decreases
####in emissions from 1999¡V2008 for Baltimore City? Which have seen increases
#####in emissions from 1999¡V2008?
#subset data from Baltimore
Baltimore_data <- subset(NEI, fips=="24510")

# aggregating Baltimore_data emissions by type & year
emissions_Baltimore_by_typeyear <- aggregate(as.numeric(Baltimore_data$Emissions), by=list(Baltimore_data$year, Baltimore_data$type), sum)
colnames(emissions_Baltimore_by_typeyear) <- c("Year", "Type", "Total_emissions_of_PM2.5")

#plot
library(ggplot2)

png("plot3.png", width = 480, height = 480)

g <- ggplot(emissions_Baltimore_by_typeyear, aes(Year, Total_emissions_of_PM2.5/1000, color = Type))
g + geom_line() + labs(y="Emissions (in 1,000 units)", title = "Total Emissions by sources in Baltimore City over the years")

dev.off()