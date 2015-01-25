## ----------------------------------------------------------------------------------------------------------
## Coursera.org
##
## Exploratory Data Analysis - Course Project 2: solution 2
##
## Student...: Sergio Vicente (Niteroi, Brazil)
## Twitter...: svicente99 (svicente99@yahoo.com)
## 
## Source [R]: proj2_quest2.R
## Date......: Jan.21st 2015
## ----------------------------------------------------------
## Source: EPA National Emissions Inventory web site
## http://www.epa.gov/ttn/chief/eiinformation.html
## File: Data for Peer Assessment [29Mb]
## ----------------------------------------------------------------------------------------------------------

## Question 2 to be answered:

#  Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
#  Use the base plotting system to make a plot answering this question.


# MAIN PARAMETERS
DATA_FOLDER <- "./data"	# subdirectory of current named 'data'
URL_DATA <- "https://d396qusza40orc.cloudfront.net/exdata/data/"
ZIP_FILE <- "NEI_data.zip"
MAIN_DATA <- "summarySCC_PM25.rds"
CLASS_DATA <- "Source_Classification_Code.rds"
# -----------------------------------------------------------------

# GRAPH DEFINITION
PNG_FILE  <- "plot2.png"
TITLE	  <- "Total Emissions from PM2.5 in the Baltimore City"
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

subsetBaltimore <- subset(NEI, fips == 24510) 	

dt <- aggregate(subsetBaltimore$Emissions, by=list(year=subsetBaltimore$year), sum)

png(PNG_FILE, width=WIDTH, heigh=HEIGHT, bg=BG_COLOR)
with(dt, {    
	barplot(height=x, names.arg=year, xlab="Year", ylab="tons of Emissions", main = TITLE)
}) 
dev.off()

