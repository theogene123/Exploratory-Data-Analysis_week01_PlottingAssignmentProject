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
> 
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
> 
> * You may find it useful to convert the Date and Time variables to
> Date/Time classes in R using the `strptime()` and `as.Date()`
> functions.
> 
> * Note that in this dataset missing values are coded as `?`.
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
> 
> 
> ### Plot 2
> 
> ![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-3.png) 
> 
> 
> ### Plot 3
> 
> ![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4.png) 
> 
> 
> ### Plot 4
> 
> ![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-5.png) 


