#read the data
SCC <- readRDS("./Source_Classification_Code.rds")
NEI <- readRDS("./summarySCC_PM25.rds")

library(dplyr)

#########################################################################
#plot 5
##How have emissions from motor vehicle sources changed from 1999¡V2008 in 
###Baltimore City?
#subset data from Baltimore
Baltimore_data <- subset(NEI, fips=="24510")

#Subset motor vehicle sources data from SCC and NEI data
SCC_vehicle <- SCC[grep("[Vv]ehicles", SCC$EI.Sector),]
Baltimore_vehicle <- subset(Baltimore_data, Baltimore_data$SCC %in% SCC_vehicle$SCC)

# aggregating Baltimore_data emissions by year
vehicle_Baltimore_byyear <- aggregate(as.numeric(Baltimore_vehicle$Emissions), by=list(Baltimore_vehicle$year), sum)
colnames(vehicle_Baltimore_byyear) <- c("Year", "total_emissions_from_vehicles")

#plot
library(ggplot2)

png("plot5.png", width = 480, height = 480)

g <- ggplot(vehicle_Baltimore_byyear, aes(Year, total_emissions_from_vehicles/1000))
g + geom_line(color="darkorchid", lwd=2) + labs(y="Emissions (in 1,000 units)", 
                                          title = "Total Emissions from Vehicles in Baltimore City over the years")

dev.off()
