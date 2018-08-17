# **********************************************
# A Crash Course in Statistical Programming in R
# Eric Dunford | edunford@umd.edu | GVPT
# **********************************************
# NETWORK EXAMPLE w/ bits data
# BSOS 2018 Math Camp
# **********************************************



# Load Packages -----------------------------------------------------------

require(tidyverse)
require(tidygraph)
require(ggraph)



# Load data ---------------------------------------------------------------

load("/Users/edunford/Desktop/bits_data.Rdata")


# Generate Network --------------------------------------------------------

bits_net <-
  bits_data %>%
  filter(year_signed == 2005) %>%
  as_tbl_graph()


# Visualizing the Network -------------------------------------------------

# Plot the initial network (all Bilateral Trade Agreements from 2005 onward)
    bits_net %>%
    ggraph(layout="nicely") +
      geom_edge_link(color="grey",alpha=.4) +
      geom_node_point(size = 5, colour = 'steelblue') +
      theme_graph()


    # Plot the country labels
    bits_net %>%
      ggraph(layout="nicely") +
      geom_edge_link(color="grey",alpha=.4) +
      geom_node_label(aes(label = name), colour = 'black', vjust = 0.4) +
      theme_graph()


# Generate centrality metrics

    # Degree Centrality
    bits_net %>%
      mutate(centrality = centrality_degree()) %>%
      ggraph(layout="nicely") +
      geom_edge_link() +
      geom_node_point(aes(size = centrality, colour = centrality)) +
      scale_color_continuous(guide = 'legend') +
      theme_graph()

    # Eigen Centrality
    bits_net %>%
      mutate(centrality = centrality_eigen()) %>%
      ggraph(layout="nicely") +
      geom_edge_link() +
      geom_node_point(aes(size = centrality, colour = centrality)) +
      scale_color_continuous(guide = 'legend') +
      theme_graph()


# Community detection

    # Random Walk
    bits_net %>%
      mutate(community = as.factor(group_walktrap())) %>%
      ggraph(layout = 'nicely') +
      geom_edge_link() +
      geom_node_point(aes(colour = community), size = 7) +
      theme_graph()

    # Google Search
    bits_net %>%
      mutate(community = as.factor(group_infomap())) %>%
      ggraph(layout = 'nicely') +
      geom_edge_link() +
      geom_node_point(aes(colour = community), size = 7) +
      theme_graph()


    # There are many many more things one can do with a network. Check out all
    # tidygraph has to offer!
