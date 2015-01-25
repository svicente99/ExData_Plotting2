## ----------------------------------------------------------------------------------------------------------
## Coursera.org
##
## Exploratory Data Analysis - Course Project 2: solution 5
##
## Student...: Sergio Vicente (Niteroi, Brazil)
## Twitter...: svicente99 (svicente99@yahoo.com)
## 
## Source [R]: proj2_quest5.R
## Date......: Jan.24th 2015
## ----------------------------------------------------------
## Source: EPA National Emissions Inventory web site
## http://www.epa.gov/ttn/chief/eiinformation.html
## File: Data for Peer Assessment [29Mb]
## ----------------------------------------------------------------------------------------------------------

## Question 5 to be answered:

#  How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City? 


# MAIN PARAMETERS
DATA_FOLDER <- "./data"	# subdirectory of current named 'data'
URL_DATA <- "https://d396qusza40orc.cloudfront.net/exdata/data/"
ZIP_FILE <- "NEI_data.zip"
MAIN_DATA <- "summarySCC_PM25.rds"
CLASS_DATA <- "Source_Classification_Code.rds"
BALTIMORE <- 24510
# -----------------------------------------------------------------

# GRAPH DEFINITION
PNG_FILE  <- "plot5.png"
TITLE  	  <- "Emissions from motor vehicle in the Baltimore City"
X_LABEL   <- "Year"
Y_LABEL   <- "tons of PM2.5 Emissions"
WIDTH 	  <- 480
HEIGHT 	  <- 480
BG_COLOR  <- "white"
# -----------------------------------------------------------------

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

ssBalt_Veh <- subset(NEI, fips == BALTIMORE & year %in% cYears & SCC %in% cVehicles) 	
dt <- aggregate(ssBalt_Veh$Emissions, by=list(year=ssBalt_Veh$year), sum)

png(PNG_FILE, width=WIDTH, heigh=HEIGHT, bg=BG_COLOR)
with(dt, {    
	barplot(height=x, names.arg=year, xlab=X_LABEL, ylab=Y_LABEL,
	main = TITLE, panel.first=grid())
}) 
dev.off()
print(paste(PNG_FILE,"has been saved in your directory."));
