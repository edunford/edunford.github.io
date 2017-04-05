###################################################
### An Introduction to Statistical Programming in R
### DAY 3 (April 5, 2016) 
### Eric Dunford (edunford@umd.edu)
###################################################
############      GRAPHICS       ##################
###################################################
###############     MAPS      #####################
###################################################

require(dplyr)
require(ggplot2)


# First, let's set our working directory to point to where our data is
getwd()
setwd("")



# Example 1 ----------------------------------------

      # The Geographic Distribution of Crime in the USA 
      # over the last 20 years


      # GGPLOT Polygon Shape File of the USA
      states <- map_data("state")
      
      # plot using base plots
      plot(states$long,states$lat)
      # The data provides a series of points.
      
      # plot using ggplot
      ggplot(states) +
        geom_map(map = states,
                 aes(long,lat,map_id=region)) + theme_bw()
      
      # What's in the geom_map function?
          # - map data
          # aesthetics are
              # - x-coord == longitude
              # - y-coord == lattitude
              # - map_id == the name of the polygon
      
      
      # Let's look at the structure of the states map data.
      str(states)
      
      # Let's look at the dimensions
      dim(states)
      
      unique(states$region) # each of the 49 regions corresponds with a state name
      
      View(states)
      # at it's heart, it's just normal dataset with lon-lat as a variable
      
      
      
    # FBI Crime Data
      #Let's load in the FBI crime data
      
      crime <- read.csv("fbi_crime_data.csv",stringsAsFactors = F)
      head(crime)
      dim(crime)
      
      # What we have here is data collected by the FBI that reports the number
      # of crimes by type for each major city in each state.
      
      # How many cities are in each state in the dataset?
      crime %>% group_by(state) %>% 
        tally() %>% arrange(desc(n))
      
      
      # Let's POOL the total number of violent crime by state
      crime_sub <- crime %>% group_by(state) %>% 
        summarize( violent.crime= sum(violent.crime,na.rm = T))
      
      
    # Let now visualize which states have had the most violent crimes 
      
      # First, we need to MERGE our two data sets, so that our crime variable is
      # with our map data.
      
      crime_map <- merge(states,crime_sub,
                         by.x="region",
                         by.y="state",
                         all.x=T)
      
      dim(crime_map) # same dimensions as our previous map object
      
      head(crime_map)
      # As you can see, we have our original map data, but now merged with the
      # crime data.
      
      
      # plot using ggplot -- let's plot this as a choropleth map
      ggplot(crime_map) +
        geom_map(map = crime_map,
                 aes(long,lat,map_id=region,fill=violent.crime),
                 color="black") + 
        # simple theme
        theme_classic() + 
        # change the colors to range from white to red
        scale_fill_continuous(low = "white",high="red")
      
    
      
      # Note that since the data is no different that any other type of data, we
      # can easily subset it if we care about only a states.
      
      # Here let's subset just for the western states.
      crime_map_sub <- crime_map %>% 
        filter(region %in% c("idaho","montana","california",
                             "washington","oregon","nevada",
                             "new mexico","utah","arizona"))
      
      # plot using ggplot -- let's plot this as a choropleth map
      ggplot(crime_map_sub) +
        geom_map(map = crime_map_sub,
                 aes(long,lat,map_id=region,fill=violent.crime),
                 color="black") + 
        theme_classic() + 
        scale_fill_continuous(low = "white",high="purple")
      
      
      
      
# Example 2 ----------------------------------------- 
      
      
  # Insurgent Activity in Nigeria in 2011.
      
      # In the following we will learn to load in and read shape files. From 
      # there we'll merge ethnicity, and conflict data, to get a sense of the 
      # where conflict occurred most in Nigeria for 2011, and to see if there is
      # any descriptive association with ethnicity. 
  
      
      # For this exercise, we are going to use a number of new packages. The
      # following are a number of useful geospatial packages.
      
      #install.packages(c("raster","sp"))
      library(raster)
      library(sp)
      
     
  # PART 1: LOADING AND MANIPULATING SHAPEFILES
      
      # First, let's download the polygon data for Nigeria from 
      # http://www.diva-gis.org/gdata. This will provide us with the shapefile
      # for Nigeria.
      
      # As you'll note, ALOT comes with these files, but we really only care
      # about the shape (.shp) files. 
      
      # Read in Shape File
      shape <- shapefile("NGA_adm/NGA_adm1.shp")
      
      plot(shape) # Visualize
      
      # Note that each shape is unique but connected
      
      View(shape) # Again, the data is similar to a data frame
      
      unique(shape$NAME_1) # with each administrative district outlined
      
      
      # We can subset and visualize districts individually, using techniques we
      # already know.
      
      plot(shape[shape$NAME_1 == "Ebonyi",])
      plot(shape[shape$NAME_1 == "Borno",])
      plot(shape[shape$NAME_1 == "Bauchi",])
      
      
      # Knowing this, we can easily highlight and emphasize regions by creating
      # a COLOR VARIABLE
      
      shape$color <- "grey" 
      shape$color[shape$NAME_1 %in% c("Ebonyi","Borno","Bauchi")] <- "steelblue"
      
      plot(shape) # Looks the same?
      plot(shape,col=shape$color)
      plot(shape,col=shape$color,border="white") # remove the border
      
      #As we can see, it's quite easy to manipulate shapefiles!
      
      
  # PART 2: OVERLAYING SHAPEFILES
      
      # Often we have multiple shapefiles that we want to overlay onto one image
      
      # Here I am going to bring in data from the geo-referenced Ethnic Power 
      # relations dataset, which records and maps various ethnic groups within a
      # country. I've subsetted this data to only include Ethnic groups located in Nigeria
      
      geoEPR <- shapefile("Nigeria_geoEPR/Nigeria_geoEPR.shp")
      
      plot(geoEPR) 
      
      # These are polygon intent on describing the LOCATION of ethnic groups
      # across locations. These aren't entirely meaningful on their own
      # though... we need to combine them with our map of Nigeria.
      
      
      plot(shape)
      plot(geoEPR,add=T)
      
      # We've overlayed them! But it's difficult to make out what is what. Let's
      # use what we know about color in plots help with this. 
      
      # Total number of ethnic groups?
      View(geoEPR)
      geoEPR$groupname
      
      # Let's assign each ethnic group a color
      geoEPR$color <- c("red","blue","orange","green","purple","wheat")
      
      plot(shape)
      plot(geoEPR,col=geoEPR$color,add=T)
      
      # Better! But we can't see what is behind the color
      
      # Let's familiarize ourselves with a function called 
      # `alpha` from the packages `scales` which generates a TRANSPARENCY on
      # colors.
      
      # install.packages("scales")
      require(scales)
      
      plot(shape)
      plot(geoEPR,col=alpha(geoEPR$color,.4),add=T)
      
      
      # Let's turn it all into a complete graphic by adding to the country map
      # and adding a legend
      plot(shape,col="lightgrey",border="white")
      plot(geoEPR,col=alpha(geoEPR$color,.3),
           border=alpha(geoEPR$color,.3),add=T)
      legend("bottomright",legend = geoEPR$groupname,fill=geoEPR$color,cex=.6,
             box.col = "white")
      
      
  # PART 3: INCORPORATING POINTS
      
      # Let's know fold in information we know about conflict occurrences in
      # Nigeria in 2011. 
      
      # We'll use the Armed Conflict Location and Event Data Project (ACLED) 
      # data, which provides granular event data for a diversity of confilct
      # occurrences within a country.
      
      acled <- read.csv("acled_nig2011.csv",stringsAsFactors = F) # Read in the data
      
      View(acled)
      
      # There are many key things to note about event data, but the most 
      # important (for our purposes) is the geo-references (lon-lat location),
      # and the timestamp (date).
      
      
      # Lon-lat locations are essentially coorindate points that can be plotted.
      plot(acled$longitude,acled$latitude)
      
      # We can overlay these points onto our map using the points() function
      plot(shape)
      points(acled$longitude,acled$latitude)
      
      
      # Let's make things clearer by making the dots darker
      plot(shape)
      points(acled$longitude,acled$latitude,pch=16)
      
      
      # Now there are both non-violent (protest/demonstrations), and violent
      # activities in these data. Let's differentiate between the two.
      acled$color <- "red"
      acled$color[acled$event_tax == "Protests"] <- "blue"
      
      plot(shape)
      points(acled$longitude,acled$latitude,
             col=acled$color,pch=16)
      
      # We can do the same with the shape of a point.
      acled$shape <- 16
      acled$shape[acled$event_tax == "Protests"] <- 17
      
      plot(shape)
      points(acled$longitude,acled$latitude,
             col=acled$color,pch=acled$shape)
      
      
      # Finally, for the violent events, we can see which had the highest
      # fatalities by fluctuating the size of the point
      acled$fatalities
      
      acled$size <- ifelse(acled$fatalities>15,3,2) # if more than 15 fatalities
      acled$size[acled$fatalities==0] <- 1 # if there are no fatalities
      
      plot(shape)
      points(acled$longitude,acled$latitude,
             col=acled$color,pch=acled$shape,
             cex=acled$size)
      
      # Let's fold in an alpha on the colors so we can better observe overlap
      plot(shape)
      points(acled$longitude,acled$latitude,
             col=alpha(acled$color,.4),pch=acled$shape,
             cex=acled$size)
      
      
      # As with everything, it's useful to have a legend
      plot(shape)
      points(acled$longitude,acled$latitude,
             col=alpha(acled$color,.4),pch=acled$shape,
             cex=acled$size)
      legend("topright",legend=c("Protest","Violence (No Deaths)",
                                 "Violence (1 - 15 Deaths)",
                                 "Violence (15+ Deaths)"),
             pch = c(17,16,16,16),
             col=c("blue","red","red","red"),
             pt.cex=c(1,1,2,3),
             cex=.85,box.col = "white")
      
      
  # Part 4: LOCATING the Urban Centers
      
      # It would be useful if we know WHERE the major cities were in Nigeria. As
      # we'd expect Conflict to occur in more densely populated areas, it's 
      # useful to have an understanding of where each city is located.
      
      # Here is a list of the 10 most populated cities in Nigeria
      cities <- c("Lagos, Nigeria",
                  "Kano, Nigeria",
                  "Ibadan, Nigeria",
                  "Benin City, Nigeria",
                  "Port Harcourt, Nigeria",
                  "Jos, Nigeria",
                  "Llorin, Nigeria",
                  "Abuja, Nigeria",
                  "Kaduna, Nigeria",
                  "Enugu, Nigeria")
      
      # We want to know WHERE these cities are located. 
      
      # Luckily, there is a useful package that taps into the Google API that
      # takes in a name and report back a location. 
      
      # install.packages("ggmap")
      require(ggmap)
      
      cities[1] # Location for lagos
      loc <- geocode(cities[1])
      
      plot(shape)
      points(loc$lon,loc$lat,pch=16,col="purple",cex=2)
      
      
      city_locations <- geocode(cities) # Lets collect the locations for all rel. cities
      city_locations$name <- cities # Save the names
      
      city_locations
      
      # Now, plot:
      plot(shape)
      points(city_locations$lon,city_locations$lat,pch=16,col="purple",cex=2)
      
      # We can add text if need be
      plot(shape)
      points(city_locations$lon,city_locations$lat,pch=16,col="purple",cex=2)
      text(city_locations$lon,city_locations$lat,label=city_locations$name)
      
      # Nice, but the Nigeria is sort of in the way, let's remove it using what
      # we know about regular expressions.
      city_locations$name2 <- gsub(", Nigeria","",city_locations$name)
      
      plot(shape)
      points(city_locations$lon,city_locations$lat,pch=15,col="darkgrey")
      text(city_locations$lon,city_locations$lat,label=city_locations$name2,font=2)
      
      
      
  # PART 5: Bringing it all together
      
      # Let's incorporate it all together now
      
      
      plot(shape,col="lightgrey",border="white",main="Ethnicity and Conflict in Nigeria 2011")
      plot(geoEPR,col=alpha(geoEPR$color,.2),
           border=alpha(geoEPR$color,.3),add=T)
      points(acled$longitude,acled$latitude,
             col=alpha(acled$color,.4),pch=acled$shape,
             cex=acled$size)
      points(city_locations$lon,city_locations$lat,pch=15,col="darkgrey")
      text(city_locations$lon,city_locations$lat,label=city_locations$name2,
           font=2,cex=.8)
      legend("topright",legend=c("Protest","Violence (No Deaths)",
                                 "Violence (1 - 15 Deaths)",
                                 "Violence (15+ Deaths)"),
             pch = c(17,16,16,16),
             col=c("blue","red","red","red"),
             pt.cex=c(1,1,2,3),
             cex=.85,box.col = "white",title ="Conflict")
      legend("bottomright",legend = geoEPR$groupname,fill=geoEPR$color,cex=.8,
             box.col = "white",border="white",title="Ethnicity")
      
      
      # Here we've brought together multiple forms of spatial data to present a 
      # geographic description of conflict occurence and intencity and relative
      # to the distribution ethnicity within Nigeria. 
      
      # What now we can gain a more accurate picture of which areas are more 
      # prone to conflict (at least during this year) and to being to think
      # about why that is.
      