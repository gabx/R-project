
# plot1.R

suppressPackageStartupMessages(library(data.table))

## GET DATA TABLE #####################################
if ('DT' %in% ls() == FALSE){
    
    # download and unzip the file if not already done
    if ('NEI.zip' %in% list.files() == FALSE){
        download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip',
                      destfile = 'NEI.zip', quiet = T, method = 'curl')
        unzip('NEI.zip')
    }
    
    
    
    # read the .rds files using readRDS()
    # Function to write a single R object to a file, and to restore it.
    # These functions provide the means to save a single R object to a connection 
    # (typically a file) and to restore the object, quite possibly under a different 
    # name. This differs from save and load, which save and restore one or more named 
    # objects into an environment. 
    
    
    # use data.table() as it is more efficient
    DT <- data.table(readRDS('summarySCC_PM25.rds'))
    Scc <- data.table(readRDS('Source_Classification_Code.rds'))
    
    # see how tables look
    #head(DT)
    #str(DT)
    #head(Scc)
    #str(Scc)
    
}

# write a short codebook.txt using sink() if not already writen
if ('codebook.txt' %in% list.files() == FALSE){
    
    sink('codebook.txt', append=T)
    cat('Codebook for Source Classification data file\n\n')
    cat('fips: A five-digit number (represented as a string) indicating 
        the U.S. county\n')
    cat('SCC: The name of the source as indicated by 
        a digit string (see source code classification table)\n')
    cat('Pollutant: A string indicating the pollutant\n')
    cat('Emissions: Amount of PM2.5 emitted, in tons\n')
    cat('type: The type of source (point, non-point, on-road, or non-road)\n')
    cat('year: The year of emissions recorded\n')
    sink()
}



## SELECT ELEMENTS #######################################
# total emission/year
yearly <- DT[,list(Emissions=sum(Emissions)), by='year']
# round numbers
yearly$Emissions <- round(yearly$Emissions/1000000, digits = 2)

## PLOT #######################################################
# plot using base ploting system
opt <- par(las=1) # horizontal labels
png('plot1.png')
with(yearly, plot(year, Emissions, 
                  main='Fine Particulate matter emissions\nacross USA',
                  type='l', xaxt = 'n', yaxt = 'n',
                  xlab = 'Year', ylab = 'Emissions in mega-tons' ))

axis(1, at = yearly$year)
axis(2, at = yearly$Emissions)
dev.off()
# reset the plotting margins    
par(opt)
# clean wd
suppressWarnings(rm(yearly, opt))


## plot 2
## SELECT ELEMENTS #######################################
# Select Baltimore City fips == '24510'
Balt <- DT[fips == '24510',list(Emissions=sum(Emissions)), by='year']
# round numbers
Balt$Emissions <- round(Balt$Emissions, digits = 0)

## PLOT #######################################################
# plot using base ploting system
opt <- par(las=1) # horizontal labels
png('plot2.png')
with(Balt, plot(year, Emissions, main='Fine Particulate matter emissions in Baltinore City',
                type='l', xaxt = 'n', yaxt = 'n',
                xlab = 'Year', ylab = 'Emissions in tons' ))

axis(1, at = Balt$year)
axis(2, at = Balt$Emissions)
dev.off()
# reset the plotting margins    
par(opt)
suppressWarnings(rm(Balt, opt))

## plot 3
## SELECT ELEMENTS #######################################
# Select Baltimore City: fips == '24510'
Balt <- DT[fips == '24510',]
# order Balt by type using setkey()
# check listed keys with tables()
setkey(Balt,type)
my.type <- Balt[,list(Emissions=sum(Emissions)), by=c('type','year')]
# round numbers
my.type$Emissions <- round(my.type$Emissions, digits = 2)

## PLOT #######################################################
## plot with ggplot2() ##
# help : http://www.cookbook-r.com/Graphs/
# custom colors in RGB
my.palette <- c('#F50031','#06B109','#7FA5D7','#C57AD6')
# create plot object
p <- ggplot(my.type, aes(year, Emissions, colour = type)) +
    geom_line() +
    # use custom colors
    scale_colour_manual(values = my.palette) +
    # hide the grid line, transparent background, grey border
    theme(panel.grid.minor=element_blank(), panel.grid.major=element_blank(),
          panel.background = element_rect(fill = "transparent",colour = NA),
          panel.border = element_rect(fill = NA, colour="grey50")) +
    # title
    ggtitle('Emissions of Fine Particulate matter\nin Baltimore city by types of sources') +
    # change y axis label
    ylab('Emissions in tons') 


png('plot3.png')
print(p)
dev.off()
# clean wd
suppressWarnings(rm(Balt, my.type, my.palette, p)) 

# plot 4
## SELECT ELEMENTS #######################################
# select emissions from coal combustion-related sources with Scc data, i.e 
# EI.Sector in ...
# find sector with coal then get the SCC code
# NB : we use here Value = T to get a vector containing the matching elements
u <- unique(grep('coal', Scc$EI.Sector, ignore.case = T, value = T))
sel <- Scc[Scc$EI.Sector %in% u]
my.Scc <- as.vector(sel$SCC)
# select emissions with SCC in my.Scc
sel <- DT[DT$SCC %in% my.Scc]
coal.emissions <- sel[,list(Emissions=sum(Emissions)), by='year']
# round numbers
coal.emissions$Emissions <- round(coal.emissions$Emissions/100, digits = 0)


## PLOT #######################################################
# plot using base ploting system
opt <- par(las=1) # horizontal labels
png(filename='plot4.png')
with(coal.emissions, plot(year, Emissions, 
                          main='emissions from coal combustion-related sources\nacross USA',
                          type='l', xaxt = 'n', yaxt = 'n',
                          xlab = 'Year', ylab = 'Emissions in thausand tons' ))

axis(1, at = coal.emissions$year)
axis(2, at = coal.emissions$Emissions)
dev.off()
# reset the plotting margins    
par(opt)
# clean wd
suppressWarnings(rm(coal.emissions, sel, my.Scc, opt, u)) 


## plot 5

## SELECT ELEMENTS #######################################
# select emissions from from motor vehicle sources changed from 1999–2008 in Baltimore City
# find sector with vehicles then get the SCC code
# NB : we use here Value = T to get a vector containing the matching elements
u <- unique(grep('vehicles', Scc$EI.Sector, ignore.case = T, value = T))
sel <- Scc[Scc$EI.Sector %in% u]
my.Scc <- as.vector(sel$SCC)
# select emissions with SCC in my.Scc
sel <- DT[DT$SCC %in% my.Scc | DT$fips == '24510']
veh.emissions <- sel[,list(Emissions=sum(Emissions)), by='year']
# round numbers
veh.emissions$Emissions <- round(veh.emissions$Emissions, digits = 0)


## PLOT #######################################################
# plot using base ploting system
# we need to adjust margins to avoid labels and tick mark to cross. 
# This is done with mgp = and mar = 
opt <- par(las=1, mar = c(5, 6, 4, 2) + 0.1) # horizontal labels
png(filename='plot5.png')
with(veh.emissions, plot(year, Emissions, 
                         main='emissions from motor vehicles in Baltimor city',
                         type='l', xaxt = 'n', yaxt = 'n',
                         mgp = c(4, 1, 0),
                         xlab = 'Year', ylab = 'Emissions in tons'))

axis(1, at = veh.emissions$year)
axis(2, at = veh.emissions$Emissions)
dev.off()
# reset the plotting margins    
par(opt)
# clean wd
suppressWarnings(rm(coal.emissions, sel, veh.emissions, my.Scc, opt, u)) 


## plot 6
## SELECT ELEMENTS #######################################
# select emissions from from motor vehicle sources changed from 1999–2008 in Baltimore City
# and Loas Angeles County (fips == '06037')
# find sector with vehicles then get the SCC code
# NB : we use here Value = T to get a vector containing the matching elements
u <- unique(grep('vehicles', Scc$EI.Sector, ignore.case = T, value = T))
sel <- Scc[Scc$EI.Sector %in% u]
my.Scc <- as.vector(sel$SCC)
# select emissions with SCC in my.Scc and fips = 24510 and 06037
sel.balt <- DT[fips == '24510' & SCC %in% my.Scc] 
sel.los <- DT[fips == '06037' & SCC %in% my.Scc]
# remove uneeded columns
# HINT : assign null to uneeded columns (col num)
sel.balt <- sel.balt[,c(2L, 3L,5L):=NULL]
sel.los <- sel.los[,c(2L, 3L,5L):=NULL]
# sum emissions
balt <- sel.balt[,list(Emissions=sum(Emissions)), by=c('fips','year')]
los <- sel.los[,list(Emissions=sum(Emissions)), by=c('fips','year')]
# round numbers
balt[[3]] <- round(balt[[3]], digits = 2)
los[[3]] <- round(los[[3]], digits = 2)


# bind by row
sel <- rbind(sel.balt,sel.los)
emissions <- sel[,list(Emissions=sum(Emissions)), by=c('fips','year')]
# round numbers
emissions[[3]] <- round(emissions[[3]], digits = 2)


# RESHAPE ###############################
# We want each row represents one observation of one variable, a MOLTEN dt
# help : http://had.co.nz/reshape/introduction.pdf
balt <- melt(balt, id = c('fips','year'))
los <- melt(los, id = c('fips','year'))
# cast in the desired table
balt <- cast(balt, fips+year ~ variable)
los <- cast(los, fips+year ~ variable)
# remove the fips column 
balt <- balt[2:3]
los <- los[2:3]
# make the two variables start at same level for comparaison
delta <- los[1,2] - balt[1,2]
los[2] <- los[2] - delta


## PLOT #######################################################
# plot using base ploting system
# we want both line on same x,y axis. We need to specify extremes of the user 
# ccordinates
# ?par for a list of all param
opt <- par(las=1) # horizontal labels
png('plot6.png')
range <- c(50,1200)
with(balt, plot(year, Emissions, 
                type='l', col = 'red', xaxt = 'n', yaxt = 'n',
                xlab = 'Year', ylab = '', ylim = range,
                main='Motor vehicule fine particulate matter emissions'))
axis(1, at = balt$year)
# add a second line
par(new = TRUE)
with(los, plot(year, Emissions, 
               type='l', col = 'blue', ylim = range, axes = F,
               xlab = '', ylab = '' ))
legend('topleft', col=c('red','blue'), lty=1, legend = c('Baltimore City',
                                                         'Los Angeles County'))
mtext("Variation of motor vehicule emissions of PM",side=2,line=2.5)
dev.off()
# reset the plotting margins    
par(opt)
# clean wd
suppressWarnings(rm(range, opt, delta, balt, los, u, sel, sel.balt, sel.los, 
                    emissions, my.Scc)) 

# another and better soluion is to use boxplot()
#boxplot(df[1:4,1], df[5:8,1], names = c('Los Angeles County','Baltimore city'),
#col = 'red', ylim = c(0, max(df$emissions)))
#mtext("Variation of motor vehicule emissions in tons over the period",side=2,line=2.5)
