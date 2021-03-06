#library(sqldf)

filename <- "household_power_consumption.txt"

df <- read.table(filename,
                 header=TRUE,
                 sep=";",
                 colClasses=c("character", "character", rep("numeric",7)),
                 na="?")

## TODO: why subsetting with faster read.csv.sql was giving different result???
#df <- read.csv.sql(file, sep=";", 
#                   colClasses=c("character", "character", rep("numeric",7)), 
#                   stringsAsFactors=FALSE, 
#                   sql = "select * from file where Date = '2/1/2007' OR Date = '2/2/2007'" )


# convert date and time 
df$Time <- strptime(paste(df$Date, df$Time), 
                    "%d/%m/%Y %H:%M:%S")
df$Date <- as.Date(df$Date, 
                   "%d/%m/%Y")

# use data from certain dates
dates <- as.Date(c("2007-02-01", "2007-02-02"), 
                 "%Y-%m-%d")
df <- subset(df, 
             Date %in% dates)

png("plot1.png", 
    width=480, 
    height=480)

hist(df$Global_active_power,
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)",
     ylab="Frequency",
     col="red",
     border="black")

dev.off()
