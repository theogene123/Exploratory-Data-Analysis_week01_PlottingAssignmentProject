### Peer Graded Assignment: Exploratory Data Analysis Course Project (week 1)
### https://github.com/merlotpa/Exploratory-Data-AnalysisExData_week01_PlottingAssignmentProject

setwd("/home/patechoc/Documents/COURSE/MOOCs/COURSERA_Datascienc-with-R/course04_Exploratory_Analysis/CODE/Exploratory-Data-Analysis_week01_PlottingAssignmentProject")
mainDir = getwd()
source("getData.R")

df <- getData()

### PLOT 4
png(width=480, height=480, file = "plot4.png")
par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(df, {
        plot(Global_active_power ~ timestamp, type = "l", 
             ylab = "Global Active Power", xlab = "")
        plot(Voltage ~ timestamp, type = "l", ylab = "Voltage", xlab = "datetime")
        plot(Sub_metering_1 ~ timestamp, type = "l", ylab = "Energy sub metering",
             xlab = "")
        lines(Sub_metering_2 ~ timestamp, col = 'Red')
        lines(Sub_metering_3 ~ timestamp, col = 'Blue')
        legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
               bty = "n",
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(Global_reactive_power ~ timestamp, type = "l", 
             ylab = "Global_reactive_power", xlab = "datetime")
})
dev.off()

