#read the data
SCC <- readRDS("./Source_Classification_Code.rds")
NEI <- readRDS("./summarySCC_PM25.rds")

library(dplyr)

#########################################################################
#plot 4
##Across the United States, how have emissions from coal combustion-related
###sources changed from 1999¡V2008?
# Subset coal combustion-related data from SCC and NEI data
SCC_Coal_related <- SCC[grep("[Cc]oal", SCC$EI.Sector),]
NEI_Coal_related <- subset(NEI, NEI$SCC %in% SCC_Coal_related$SCC)

#merge data
merge_Coal_Combustion <- merge(x = NEI_Coal_related, y = SCC,
                       by.x = "SCC", by.y = "SCC")

# aggregating emissions by year
merge_Coal_Combustion_byyear <- aggregate(as.numeric(merge_Coal_Combustion$Emissions), by=list(merge_Coal_Combustion$year), sum)
colnames(merge_Coal_Combustion_byyear) <- c("Year", "Total_coal_combustion_emissions")

#plot
library(ggplot2)

png("plot4.png", width = 480, height = 480)

g <- ggplot(merge_Coal_Combustion_byyear, aes(Year, Total_coal_combustion_emissions/1000))
g + geom_line(color="cyan", lwd=2) + labs(y="Emissions (in 1,000 units)", 
                       title = "Total Coal combustion-related Emissions by sources over the years")

dev.off()