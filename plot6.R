#read the data
SCC <- readRDS("./Source_Classification_Code.rds")
NEI <- readRDS("./summarySCC_PM25.rds")

library(dplyr)

#########################################################################
#plot 6
##Compare emissions from motor vehicle sources in Baltimore City with 
###emissions from motor vehicle sources in Los Angeles County, California
####(fips == 06037). Which city has seen greater changes over time in motor
#####vehicle emissions?

#subset data from Baltimore
Baltimore_data <- subset(NEI, fips=="24510")

#Subset Baltimore motor vehicle sources data from SCC and NEI data
SCC_vehicle <- SCC[grep("[Vv]ehicles", SCC$EI.Sector),]
Baltimore_vehicle <- subset(Baltimore_data, Baltimore_data$SCC %in% SCC_vehicle$SCC)

# aggregating Baltimore_data emissions by year
vehicle_Baltimore_byyear <- aggregate(as.numeric(Baltimore_vehicle$Emissions), by=list(Baltimore_vehicle$year), sum)
colnames(vehicle_Baltimore_byyear) <- c("Year", "total_emissions_from_vehicles")
vehicle_Baltimore_byyear$City <- "Baltimore"

#subset data from Los Angeles
LA_data <- subset(NEI, fips=="06037")

#Subset LA motor vehicle sources data from SCC and NEI data
LA_vehicle <- subset(LA_data, LA_data$SCC %in% SCC_vehicle$SCC)

# aggregating Los Angeles_data emissions by year
vehicle_LA_byyear <- aggregate(as.numeric(LA_vehicle$Emissions), by=list(LA_vehicle$year), sum)
colnames(vehicle_LA_byyear) <- c("Year", "total_emissions_from_vehicles")
vehicle_LA_byyear$City <- "Los Angeles"

#merge data of both cities
data_twocities <- rbind(vehicle_Baltimore_byyear, vehicle_LA_byyear)

#plot
library(ggplot2)

png("plot6.png", width = 480, height = 480)

g <- ggplot(data_twocities, aes(Year, total_emissions_from_vehicles/1000))
g + geom_bar(aes(fill=City), stat="identity") + facet_grid(City~.) +
  labs(y="Emissions (in 1,000 units)",
       title = "Total Emissions from Vehicles over the years")

dev.off()
