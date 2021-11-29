#read the data
SCC <- readRDS("./Source_Classification_Code.rds")
NEI <- readRDS("./summarySCC_PM25.rds")

library(dplyr)

#########################################################################
#plot 2
##Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
###(fips == 24510)from 1999 to 2008?
#subset data from Baltimore
Baltimore_data <- subset(NEI, fips=="24510")

# aggregating Baltimore_data emissions by year
emissions_Baltimore_byyear <- aggregate(as.numeric(Baltimore_data$Emissions), by=list(Baltimore_data$year), sum)
colnames(emissions_Baltimore_byyear) <- c("Year", "total_emissions_of_PM2.5")

#plot
png("plot2.png", width = 480, height = 480)

barplot(height=emissions_Maryland_byyear$total_emissions_of_PM2.5/1000, 
        names.arg=emissions_Baltimore_byyear$Year,
        xlab = "Year", ylab = "Emissions(in 1,000 units)",
        col = c("blue","blueviolet","brown","burlywood"),
        main = "Total Emissions in Baltimore City over the Years")

dev.off()