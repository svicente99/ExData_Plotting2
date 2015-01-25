## ----------------------------------------------------------------------------------------------------------
## Coursera.org
##
## Exploratory Data Analysis - Course Project 2: solution 6
##
## Student...: Sergio Vicente (Niteroi, Brazil)
## Twitter...: svicente99 (svicente99@yahoo.com)
## 
## Source [R]: proj2_quest6.R
## Date......: Jan.25th 2015
## ----------------------------------------------------------
## Source: EPA National Emissions Inventory web site
## http://www.epa.gov/ttn/chief/eiinformation.html
## File: Data for Peer Assessment [29Mb]
## ----------------------------------------------------------------------------------------------------------

## Question 6 to be answered:

#  Compare emissions from motor vehicle sources in Baltimore City with emissions from 
#  motor vehicle sources in Los Angeles County, California (fips == "06037"). 
#  Which city has seen greater changes over time in motor vehicle emissions?

# MAIN PARAMETERS
DATA_FOLDER <- "./data"	# subdirectory of current named 'data'
URL_DATA <- "https://d396qusza40orc.cloudfront.net/exdata/data/"
ZIP_FILE <- "NEI_data.zip"
MAIN_DATA <- "summarySCC_PM25.rds"
CLASS_DATA <- "Source_Classification_Code.rds"
BALTIMORE <- "24510"
LA_COUNTY <- "06037"
# -----------------------------------------------------------------

# GRAPH DEFINITION
PNG_FILE  <- "plot6.png"
TITLE  	  <- "Total Pollutant Emissions from Motor Vehicles (1999-2008) compared"
X_LABEL   <- "Year"
Y_LABEL   <- "tons of PM2.5 Emissions"
WIDTH 	  <- 600
HEIGHT 	  <- 400
BG_COLOR  <- "white"
# -----------------------------------------------------------------

plot_graph <- function(df, titulo) {
	# draw line graph of Emissions, with features: color
	with(df, {    
		barplot(height=Emissions, names.arg=year, main=titulo,
		xlab=X_LABEL, ylab=Y_LABEL, ylim=c(0,5000))
	}) 
}
## ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ 

library(plyr)			## necessary for 'ddply()'

source("load_data.R")
loadData()

print("Reading and processing these 2 files will likely take some time... Be patient!")
print(paste("-",MAIN_DATA))
print(paste("-",CLASS_DATA))
setwd(DATA_FOLDER)
NEI <- readRDS(MAIN_DATA)
SCC <- readRDS(CLASS_DATA)
setwd("..")

cYears = seq(from=1999, to=2008, by=3)

# identifying only vehicle emissions SCC codes
sccVehicles <-subset(SCC, grepl("[Vv]ehicle",EI.Sector) )
cVehicles <- as.vector(sccVehicles$SCC)

# subset and sum data only for Baltimore Vehicles
ssBalt_Veh <- subset(NEI, fips == BALTIMORE & year %in% cYears & SCC %in% cVehicles)
dfTotBC<-ddply(ssBalt_Veh, .(year), numcolwise(sum))

# subset and sum data only for Los Angeles Vehicles
ssLA_Veh <- subset(NEI, fips == LA_COUNTY & year %in% cYears & SCC %in% cVehicles)
dfTotLA<-ddply(ssLA_Veh, .(year), numcolwise(sum))

png(PNG_FILE, width=WIDTH, height=HEIGHT, bg=BG_COLOR)
## create a panel layout 1x2 and establish margin values
par(mfrow=c(1, 2), mar=c(4, 4, 3, 2), oma=c(1, 1, 2.5, 1)) 
plot_graph(dfTotLA, "Los Angeles County")  	## draw the graph to (1,1) position
plot_graph(dfTotBC, "Baltimore City") 	## draw the graph to (1,2) position
mtext( TITLE, side=3, outer=TRUE, col="blue", font=2 )  
dev.off()

print(paste(PNG_FILE,"has been saved in your directory."));
