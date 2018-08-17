# **********************************************
# A Crash Course in Statistical Programming in R
# Eric Dunford | edunford@umd.edu | GVPT
# **********************************************
# GEOSPATIAL EXAMPLE
# BSOS 2018 Math Camp
# **********************************************



# Load the relevant Pacakges ----------------------------------------------


# install.packages('tidyverse)
# install.packages('sf')


require(tidyverse) # Data management and visualization
require(sf) # mapping data (treats spatial files as geometries)



# Import the Data  --------------------------------------------------------

  # You'll need to specify your own library here
  load('~/Desktop/nigeria_data.Rdata')

  # These data are from the ACLED data project: https://www.acleddata.com/
  # The data has been subsetted to only include conflict activity from NIGERIA



# Geospatial data ---------------------------------------------------------

  # Understanding the data
  glimpse(acled_nig)

  View(acled_nig)





# Plotting the Data  ------------------------------------------------------

  # Events occur at a longitude and latitude location. These are just coordinate
  # locations (x/y). We can plot these the same way we'd plot any data.
    ggplot(acled_nig,aes(y=latitude,x=longitude)) + geom_point()


    # We can bin points to see where activity is more dense. And color code so
    # that we get something that sort of looks like a hear map
    ggplot(acled_nig,aes(y=latitude,x=longitude)) +
      geom_bin2d() +
      scale_fill_gradient(low="white",high="darkred")


    # We can break the data up by some other variable, like year, and look at
    # the distribution of activity across time
    ggplot(acled_nig,aes(x=year)) + geom_bar()


    # What are the most dangerous subnational areas?
    ggplot(acled_nig,aes(x=admin1,y=fatalities)) +
      geom_bar(stat="identity") +
      coord_flip()







# Generating a Heat Map using data in GGPLOT2 ---------------------------

    # There is world map data inherent to ggplot()
    map_data("world") %>%
      ggplot(.,aes(x=long, y=lat,group=group)) +
      geom_polygon(fill='grey50')


    # Let produce a spatio-temporal heat map of all conflict occurrences in
    # Nigeria
    heat_colors = c("#3288BD","#99D594","#E6F598",
                    "#FFFFBF","#FEE08B","#FC8D59",
                    "#D53E4F")

    # Here's an example of building a map in one easy go.
    map_data("world") %>%                                                     # pipe the world data
      filter(region=="Nigeria") %>%                                           # filter the data to only have the Nigeria map
      ggplot(., aes(x=long, y=lat)) +                                         # plot the coordinates
      geom_polygon(fill='grey50') +                                           # color the map a dark grey
      stat_density2d(data = acled_nig,                                        # Add the conflict points as a density
                     aes(y=latitude,x=longitude,
                         fill=..level..),
                     geom="polygon",alpha=.7) +
      scale_fill_gradientn(colours=heat_colors)+                              # Change the colors of our map to follow our color scheme
      theme_void() +                                                          # Add a simple theme with no axis
      theme(legend.position = "none") +                                       # drop the color legend
      facet_wrap(~year) +                                                     # Break up observations by year
      labs(title="Spatio-Temporal Distribution of Conflict in Nigeria")       # Add title






# Creating a Cloropleth Map by Administration Unit -----------------------------------------------

    # We can use existing maps data to make maps.
    # You can get country administration shapefile from this site: http://www.diva-gis.org/gdata



    # Use 'sf' package to read in shape files as geometries.


    # We already read in shapefile data when we loaded the data that came with
    # this example

    # Plot
    nigeria_map %>%
      ggplot() +
      geom_sf()


    # Clean
    nigeria_map %>%
      ggplot() +
      geom_sf(fill="grey70",color="white") +
      theme_void()


    # drop those gridlines
    nigeria_map %>%
      ggplot() +
      geom_sf(fill="grey70",color="white") +
      theme_void() +
      theme(panel.grid.major = element_line(colour = 'transparent'))


    # Match the Administration Unit with the events data
    total_events <- acled_nig %>%
      group_by(admin1) %>%
      summarize(n_events = n())
    total_events


    # Merge the two data sets
    nigeria_map2 <- left_join(nigeria_map,total_events, by=c("NAME_1"="admin1"))


    # Filling missing entries (i.e. entries with no activity)
    nigeria_map2 <- nigeria_map2  %>%
      mutate(n_events = ifelse(is.na(n_events),0,n_events))


    # Color code each map by intensity
    nigeria_map2 %>%
      ggplot(aes(fill=n_events)) +
      geom_sf(color="white") +
      theme_void() +
      theme(panel.grid.major = element_line(colour = 'transparent'))



    # Introduce a more compelling color scheme
    nigeria_map2 %>%
      ggplot(aes(fill=n_events)) +
      geom_sf(color="grey") +
      scale_fill_gradient(low = "white",high="darkred") +
      theme_void() +
      theme(panel.grid.major = element_line(colour = 'transparent'))



    # Move legend to the bottom and change labels
    nigeria_map2 %>%
      ggplot(aes(fill=n_events)) +
      geom_sf(color="grey") +
      scale_fill_gradient(low = "white",high="darkred") +
      theme_void() +
      theme(panel.grid.major = element_line(colour = 'transparent'),
            legend.position = "bottom") +
      labs(fill="Number of Events",
           title="Violent Activity in Nigeria 1997 to 2016")



