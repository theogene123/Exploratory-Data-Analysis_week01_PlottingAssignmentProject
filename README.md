# Peer Graded Assignment: Exploratory Data Analysis Course Project (week 1)

This assignment is the first project assignment for the course on COURSERA named ["Exploratory Data Analysis"](https://www.coursera.org/learn/exploratory-data-analysis)

## COURSERA instructions

[link to dataset at UC Irvine Machine Learning Repository](https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption)

> ## Introduction
> 
> This assignment uses data from
> the <a href="http://archive.ics.uci.edu/ml/">UC Irvine Machine
> Learning Repository</a>, a popular repository for machine learning
> datasets. In particular, we will be using the "Individual household
> electric power consumption Data Set" which I have made available on
> the course web site:
> 
> 
> * <b>Dataset</b>: <a href="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip">Electric power consumption</a> [20Mb]

```R
### DOWNLOAD THE DATASET (if not there already)
mainDir = getwd()
rawDir = "data"
dir.create(file.path(mainDir, rawDir))
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
```

 
> * <b>Description</b>: Measurements of electric power consumption in
> one household with a one-minute sampling rate over a period of almost
> 4 years. Different electrical quantities and some sub-metering values
> are available.
> 
> 
> The following descriptions of the 9 variables in the dataset are taken
> from
> the <a href="https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption">UCI
> web site</a>:
> 
> <ol>
> <li><b>Date</b>: Date in format dd/mm/yyyy </li>
> <li><b>Time</b>: time in format hh:mm:ss </li>
> <li><b>Global_active_power</b>: household global minute-averaged active power (in kilowatt) </li>
> <li><b>Global_reactive_power</b>: household global minute-averaged reactive power (in kilowatt) </li>
> <li><b>Voltage</b>: minute-averaged voltage (in volt) </li>
> <li><b>Global_intensity</b>: household global minute-averaged current intensity (in ampere) </li>
> <li><b>Sub_metering_1</b>: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered). </li>
> <li><b>Sub_metering_2</b>: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light. </li>
> <li><b>Sub_metering_3</b>: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.</li>
> </ol>
> 
> ## Loading the data
> 
> 
> 
> 
> 
> When loading the dataset into R, please consider the following:
> 
> * The dataset has 2,075,259 rows and 9 columns. First
> calculate a rough estimate of how much memory the dataset will require
> in memory before reading into R. Make sure your computer has enough
> memory (most modern computers should be fine).

You can look at the file properties and get its size on the disk:

```shell
$ ls -lh household_power_consumption.txt 
-rw-rw-r-- 1 patechoc patechoc 127M Oct 12  2012 household_power_consumption.txt
```

Check the number of rows and columns also from the command line
```shell
$ wc -l household_power_consumption.txt
2075260 household_power_consumption.txt
$
$ head household_power_consumption.txt 
Date;Time;Global_active_power;Global_reactive_power;Voltage;Global_intensity;Sub_metering_1;Sub_metering_2;Sub_metering_3
16/12/2006;17:24:00;4.216;0.418;234.840;18.400;0.000;1.000;17.000
16/12/2006;17:25:00;5.360;0.436;233.630;23.000;0.000;1.000;16.000
16/12/2006;17:26:00;5.374;0.498;233.290;23.000;0.000;2.000;17.000
16/12/2006;17:27:00;5.388;0.502;233.740;23.000;0.000;1.000;17.000
16/12/2006;17:28:00;3.666;0.528;235.680;15.800;0.000;1.000;17.000
16/12/2006;17:29:00;3.520;0.522;235.020;15.000;0.000;2.000;17.000
16/12/2006;17:30:00;3.702;0.520;235.090;15.800;0.000;1.000;17.000
16/12/2006;17:31:00;3.700;0.520;235.220;15.800;0.000;1.000;17.000
16/12/2006;17:32:00;3.668;0.510;233.990;15.800;0.000;1.000;17.000
```

Finally with those numbers, you can calculate more precisely the size the data will take in memory

```R
m <- matrix(1,nrow=2075259,ncol=9)
m <- as.data.frame(m)
m[,1] <- sapply(m[,1],as.character.Date)
m[,2:9] <- sapply(m[,1],as.factor)
object.size(m)
print(object.size(m),units="Mb")
```

which returns `142.5 Mb`.


> 
> * We will only be using data from the dates 2007-02-01 and
> 2007-02-02. One alternative is to read the data from just those dates
> rather than reading in the entire dataset and subsetting to those
> dates.

While the R commands below requires to load the whole data file and then requires to filter a subset

```shell
fulldata <- read.table("<path-your-data>/household_power_consumption.txt", sep=";")
data     <- fulldata[fulldata$Date >= "01/02/2007" & fulldata$Date <= "02/02/2007", ]
```

a better way to subset a large data file (if you can) is to filter the data right from the command line.

```shell
$ head -n1 household_power_consumption.txt  > subset_household_power_consumption.txt 
$
$ head subset_household_power_consumption.txt 
Date;Time;Global_active_power;Global_reactive_power;Voltage;Global_intensity;Sub_metering_1;Sub_metering_2;Sub_metering_3
$
$ egrep -i "(^1/2/2007)|(^2/2/2007)" household_power_consumption.txt  >> subset_household_power_consumption.txt
$
$ head subset_household_power_consumption.txt 
Date;Time;Global_active_power;Global_reactive_power;Voltage;Global_intensity;Sub_metering_1;Sub_metering_2;Sub_metering_3
1/2/2007;00:00:00;0.326;0.128;243.150;1.400;0.000;0.000;0.000
1/2/2007;00:01:00;0.326;0.130;243.320;1.400;0.000;0.000;0.000
1/2/2007;00:02:00;0.324;0.132;243.510;1.400;0.000;0.000;0.000
1/2/2007;00:03:00;0.324;0.134;243.900;1.400;0.000;0.000;0.000
1/2/2007;00:04:00;0.322;0.130;243.160;1.400;0.000;0.000;0.000
1/2/2007;00:05:00;0.320;0.126;242.290;1.400;0.000;0.000;0.000
1/2/2007;00:06:00;0.320;0.126;242.460;1.400;0.000;0.000;0.000
1/2/2007;00:07:00;0.320;0.126;242.630;1.400;0.000;0.000;0.000
1/2/2007;00:08:00;0.320;0.128;242.700;1.400;0.000;0.000;0.000
$
patechoc@Jarvis:data$ tail subset_household_power_consumption.txt 
2/2/2007;23:50:00;3.624;0.104;241.110;15.000;0.000;0.000;18.000
2/2/2007;23:51:00;3.628;0.104;241.260;15.000;0.000;0.000;18.000
2/2/2007;23:52:00;3.626;0.104;241.070;15.000;0.000;0.000;18.000
2/2/2007;23:53:00;3.700;0.208;240.720;15.400;0.000;0.000;18.000
2/2/2007;23:54:00;3.696;0.226;240.710;15.200;0.000;1.000;17.000
2/2/2007;23:55:00;3.696;0.226;240.900;15.200;0.000;1.000;18.000
2/2/2007;23:56:00;3.698;0.226;241.020;15.200;0.000;2.000;18.000
2/2/2007;23:57:00;3.684;0.224;240.480;15.200;0.000;1.000;18.000
2/2/2007;23:58:00;3.658;0.220;239.610;15.200;0.000;1.000;17.000
2/2/2007;23:59:00;3.680;0.224;240.370;15.200;0.000;2.000;18.000
$ 
```
 
> * You may find it useful to convert the Date and Time variables to
> Date/Time classes in R using the `strptime()` and `as.Date()`
> functions.
> 
> * Note that in this dataset missing values are coded as `?`.

No missing values in the data subset, as we didn't find any `?`

```shell
$ grep "?" subset_household_power_consumption.txt 
$
```

What you obtain from loading the smaller data file

```R
> pathCode = "/home/patechoc/Documents/COURSE/MOOCs/COURSERA_Datascienc-with-R/course04_Exploratory_Analysis/CODE/Exploratory-Data-AnalysisExData_week01_PlottingAssignmentProject/"
> pathData = paste0(pathCode, "/../data/")
> setwd(pathData)
> data <- read.table(paste0(pathData, "subset_household_power_consumption.txt", collapse = NULL), sep=";")
> class(data)
[1] "data.frame"
> dim(data)
[1] 2881    9
> head(data)
        V1       V2                  V3                    V4      V5               V6             V7             V8             V9
1     Date     Time Global_active_power Global_reactive_power Voltage Global_intensity Sub_metering_1 Sub_metering_2 Sub_metering_3
2 1/2/2007 00:00:00               0.326                 0.128 243.150            1.400          0.000          0.000          0.000
3 1/2/2007 00:01:00               0.326                 0.130 243.320            1.400          0.000          0.000          0.000
4 1/2/2007 00:02:00               0.324                 0.132 243.510            1.400          0.000          0.000          0.000
5 1/2/2007 00:03:00               0.324                 0.134 243.900            1.400          0.000          0.000          0.000
6 1/2/2007 00:04:00               0.322                 0.130 243.160            1.400          0.000          0.000          0.000
```

Converting Date/Time variables to Date/Time classes in R

```R
#### Converting Date & Date+Time variables to Date and Date/Time classes in R
df$Date <- as.Date(df$Date, format="%d/%m/%Y")
df <- transform(df, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
```


The whole setup to collect and clean the data is store in this script [`getData.R`](./getData.R)

> 
> 
> ## Making Plots
> 
> Our overall goal here is simply to examine how household energy usage
> varies over a 2-day period in February, 2007. Your task is to
> reconstruct the following plots below, all of which were constructed
> using the base plotting system.
> 
> First you will need to fork and clone the following GitHub repository:
> [https://github.com/rdpeng/ExData_Plotting1](https://github.com/rdpeng/ExData_Plotting1)
> 
> 
> For each plot you should
> 
> * Construct the plot and save it to a PNG file with a width of 480
> pixels and a height of 480 pixels.
> 
> * Name each of the plot files as `plot1.png`, `plot2.png`, etc.
> 
> * Create a separate R code file (`plot1.R`, `plot2.R`, etc.) that
> constructs the corresponding plot, i.e. code in `plot1.R` constructs
> the `plot1.png` plot. Your code file **should include code for reading
> the data** so that the plot can be fully reproduced. You should also
> include the code that creates the PNG file.
> 
> * Add the PNG file and R code file to your git repository
> 
> When you are finished with the assignment, push your git repository to
> GitHub so that the GitHub version of your repository is up to
> date. There should be four PNG files and four R code files.
> 
> 
> The four plots that you will need to construct are shown below. 
> 
> 
> ### Plot 1
> 
> 
> ![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2.png) 

* [plot1.R](plot1.R)
* [plot1.png](plot1.png)

> 
> 
> ### Plot 2
> 
> ![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-3.png) 


* [plot2.R](plot2.R)
* [plot2.png](plot2.png)

> 
> 
> ### Plot 3
> 
> ![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4.png) 

* [plot3.R](plot3.R)
* [plot3.png](plot3.png)

> 
> 
> ### Plot 4
> 
> ![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-5.png) 

* [plot4.R](plot4.R)
* [plot4.png](plot4.png)


