### Peer Graded Assignment: Exploratory Data Analysis Course Project (week 1)
### https://github.com/merlotpa/Exploratory-Data-AnalysisExData_week01_PlottingAssignmentProject




getData <- function() {
        originalDir <- getwd()
        setwd("/home/patechoc/Documents/COURSE/MOOCs/COURSERA_Datascienc-with-R/course04_Exploratory_Analysis/CODE/Exploratory-Data-Analysis_week01_PlottingAssignmentProject")
        ### DOWNLOAD THE DATASET (if not there already)
        mainDir <- getwd()
        rawDir <- "data"
        if(!file.exists(destfile)){
                dir.create(file.path(mainDir, rawDir))
        }
        setwd(file.path(mainDir, rawDir))
        destfile <- file.path(getwd(), "household_power_consumption.zip")
        if(!file.exists(destfile)){
                url <- "https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
                res <- tryCatch(download.file(url, destfile),
                                error=function(e) 1)
        }
        unzip("household_power_consumption.zip", exdir = "./")
        setwd(file.path(mainDir))
        dataDir <- file.path(mainDir,rawDir)
        
        
        ### GUESS SIZE OF DATASET
        # $ head household_power_consumption.txt 
        # Date;Time;Global_active_power;Global_reactive_power;Voltage;Global_intensity;Sub_metering_1;Sub_metering_2;Sub_metering_3
        # 16/12/2006;17:24:00;4.216;0.418;234.840;18.400;0.000;1.000;17.000
        # 16/12/2006;17:25:00;5.360;0.436;233.630;23.000;0.000;1.000;16.000
        # $ wc -l household_power_consumption.txt
        # 2075260 household_power_consumption.txt
        
        # ### 2,075,259 rows and 9 columns
        # m <- matrix(1,nrow=2075259,ncol=9)
        # m <- as.data.frame(m)
        # # m[,1:20] <- sapply(m[,1:20],as.character)
        # # m[,29:30] <- sapply(m[,29:30],as.factor)
        # m[,1] <- sapply(m[,1],as.character.Date)
        # m[,2:9] <- sapply(m[,1],as.factor)
        # object.size(m)
        # # 120017224 bytes
        # print(object.size(m),units="Mb")
        # # 142.5 Mb
        
        
        ### SUBSET THE LARGE DATAFILE
        setwd(dataDir)
        #### Avoid loading the whole file
        # data <- read.table(paste0(dataDir, "household_power_consumption.txt", collapse = NULL), sep=";")
        # dataToUse <- data[data$Date >= "01/02/2007" & data$Date <= "02/02/2007", ]
        # subset(data, Date >= "01/02/2007" & Date <= "02/02/2007")
        #### prefer shell commands like this one:
        ####    head -n1 household_power_consumption.txt  > subset_household_power_consumption.txt 
        ####    egrep -i "(^1/2/2007)|(^2/2/2007)" household_power_consumption.txt  >> subset_household_power_consumption.txt
        commands <- list("head -n1 household_power_consumption.txt  > subset_household_power_consumption.txt ",
                         "egrep -i '(^1/2/2007)|(^2/2/2007)' household_power_consumption.txt  >> subset_household_power_consumption.txt")
        for (cmd in commands) {
                system(cmd)
        }
        
        
        data <- read.table(paste0(dataDir, "/", "subset_household_power_consumption.txt", collapse = NULL), sep=";")
        
        ## a faster way to load the whole file than using read-table() 
        ## with fread from "data.table" package (useful for large data files)
        library(data.table)
        library(dplyr) ## (data.table + dplyr code now lives in dtplyr.)
        df <- fread(paste0(dataDir, "/", "subset_household_power_consumption.txt", collapse = NULL),
                    na.strings="?",stringsAsFactors = FALSE)
        
        #### Converting Date & Date+Time variables to Date and Date/Time classes in R
        df$Date <- as.Date(df$Date, format="%d/%m/%Y")
        setwd(originalDir)
        df <- transform(df, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
}
