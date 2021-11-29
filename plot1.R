#read the data
SCC <- readRDS("./Source_Classification_Code.rds")
NEI <- readRDS("./summarySCC_PM25.rds")

library(dplyr)

#########################################################################
#plot 1
##make a plot showing the total PM2.5 emission from all sources for each of
###the years 1999, 2002, 2005, and 2008.
# aggregating NEI emissions data by year
emissions_byyear <- aggregate(as.numeric(NEI$Emissions), by=list(NEI$year), sum)
colnames(emissions_byyear) <- c("Year", "total_emissions_of_PM2.5")

#plot
png("plot1.png", width = 480, height = 480)

barplot(height=emissions_byyear$total_emissions_of_PM2.5/1000, 
        names.arg=emissions_byyear$Year,
        xlab = "Year", ylab = "Emissions(in 1,000 units)",
        col = c("red","orange","yellow","green"),
        main = "Total Emissions over the Years")

dev.off()