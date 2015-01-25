## ----------------------------------------------------------------------------------------------------------
## Coursera.org
##
## Exploratory Data Analysis - Course Project 2: solution 4
##
## Student...: Sergio Vicente (Niteroi, Brazil)
## Twitter...: svicente99 (svicente99@yahoo.com)
## 
## Source [R]: proj2_quest4.R
## Date......: Jan.21st 2015
## ----------------------------------------------------------
## Source: EPA National Emissions Inventory web site
## http://www.epa.gov/ttn/chief/eiinformation.html
## File: Data for Peer Assessment [29Mb]
## ----------------------------------------------------------------------------------------------------------

## Question 4 to be answered:

#  Across the United States, how have emissions from coal
#  combustion-related sources changed from 1999-2008?


# MAIN PARAMETERS
DATA_FOLDER <- "./data"	# subdirectory of current named 'data'
URL_DATA <- "https://d396qusza40orc.cloudfront.net/exdata/data/"
ZIP_FILE <- "NEI_data.zip"
MAIN_DATA <- "summarySCC_PM25.rds"
CLASS_DATA <- "Source_Classification_Code.rds"
# -----------------------------------------------------------------

# GRAPH DEFINITION
PNG_FILE  <- "plot4.png"
TITLE     <- "Emissions from coal combustion-related sources in USA"
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

# identifying only COAL emissions SCC codes
sccCoal <-subset(SCC, grepl("[Cc]oal",EI.Sector) )
cCoal <- as.vector(sccCoal$SCC)

subsetCoal <- subset(NEI, year %in% cYears & SCC %in% cCoal) 	
df <- aggregate(subsetCoal$Emissions, by=list(year=subsetCoal$year), sum)

png(PNG_FILE, width=WIDTH, heigh=HEIGHT, bg=BG_COLOR)
with(df, {    
	barplot(height=x, names.arg=year, xlab=X_LABEL, 
	ylab=Y_LABEL, main = TITLE, panel.first=grid())
}) 
dev.off()
print(paste(PNG_FILE,"has been saved in your directory."));
