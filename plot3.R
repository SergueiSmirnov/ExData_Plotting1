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
#                   sql = "select * from file where Date = '1/2/2007' OR Date = '2/2/2007'" )


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

png("plot3.png", 
    width=480, 
    height=480)

plot(df$Time, 
     df$Sub_metering_1, 
     type="l", 
     col="black", 
     xlab="", 
     ylab="Energy sub metering")
lines(df$Time, 
      df$Sub_metering_2, 
      col="red")
lines(df$Time, 
      df$Sub_metering_3, 
      col="blue")

legend("topright",
       col=c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=1)

dev.off()
