## ----------------------------------------------------------------------------------------------------------
## Coursera.org
##
## Exploratory Data Analysis - Course Project 2: solution 3
##
## Student...: Sergio Vicente (Niteroi, Brazil)
## Twitter...: svicente99 (svicente99@yahoo.com)
## 
## Source [R]: proj2_quest3.R
## Date......: Jan.24th 2015
## ----------------------------------------------------------
## Source: EPA National Emissions Inventory web site
## http://www.epa.gov/ttn/chief/eiinformation.html
## File: Data for Peer Assessment [29Mb]
## ----------------------------------------------------------------------------------------------------------

## Question 3 to be answered:

#  Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
#  variable, which of these four sources have seen decreases in emissions from 1999–2008 
#  for Baltimore City? Which have seen increases in emissions from 1999–2008? 
#  Use the ggplot2 plotting system to make a plot answer this question.

# MAIN PARAMETERS
DATA_FOLDER <- "./data"	# subdirectory of current named 'data'
URL_DATA <- "https://d396qusza40orc.cloudfront.net/exdata/data/"
ZIP_FILE <- "NEI_data.zip"
MAIN_DATA <- "summarySCC_PM25.rds"
CLASS_DATA <- "Source_Classification_Code.rds"
BALTIMORE <- 24510
# -----------------------------------------------------------------

# GRAPH DEFINITION
PNG_FILE  <- "plot3.png"
TITLE  	  <- c("Emissions from 1999-2008 in Baltimore City", "by types of sources")
X_LABEL   <- "Year"
Y_LABEL   <- "tons of PM2.5 Emissions"
WIDTH 	  <- 8
HEIGHT 	  <- 9
# -----------------------------------------------------------------

library(ggplot2)		## necessary for 'qplot()'
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

# create factors with types of sources
#cSources = unique(NEI$type)
#sapply(cSources, capitalize)	## only for a light presentation
#NEI$type <- factor(NEI$type, levels=cSources,labels=cSources) 

# subset and sum data only for Baltimore

ssBalt <- subset(NEI, fips == BALTIMORE) 	
# Ref.: http://stackoverflow.com/questions/7615922/aggregate-r-sum
dfTot<-ddply(ssBalt, .(year,type), numcolwise(sum))

# Ref.: http://www.statmethods.net/advgraphs/ggplot2.html
p <- qplot(year, Emissions, data=dfTot, geom="line", color=type, 
	 main=TITLE, xlab=X_LABEL, ylab=Y_LABEL)
	 
# White background and black grid lines	 
p <- p + theme_bw()   
# Enhance labels and legend placed at top of plot
p <- p + theme(axis.title=element_text(face="bold",size="11",color="maroon"), 
    legend.position="top") 
# Add a box around the legend:
p <- p + theme(legend.background = element_rect( ))
# Position legend on plot
p <- p + theme(legend.position=c(0.8,0.8))

# Actually save the plot in a PNG image
ggsave(file=PNG_FILE, plot=p, width=WIDTH, height=HEIGHT, dpi=100)

print(paste(PNG_FILE,"has been saved in your directory."));
