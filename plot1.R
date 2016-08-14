### Peer Graded Assignment: Exploratory Data Analysis Course Project (week 1)
### https://github.com/merlotpa/Exploratory-Data-AnalysisExData_week01_PlottingAssignmentProject

setwd("/home/patechoc/Documents/COURSE/MOOCs/COURSERA_Datascienc-with-R/course04_Exploratory_Analysis/CODE/Exploratory-Data-Analysis_week01_PlottingAssignmentProject")
mainDir = getwd()
source("getData.R")

df <- getData()

### PLOT 1
par(mfrow = c(1,1))
hist(df$Global_active_power, col = "red", main = paste("Global Active Power"),
     xlab = "Global Active Power (kilowatts)")
dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()
