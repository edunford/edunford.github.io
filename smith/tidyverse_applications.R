# An Introduction to Statistical Programming in R
# Applied Example 2: Data Management and Manipulation in R (a tidyverse perspective)
# Session 2 - October 12, 2017
# Eric Dunford (edunford@umd.edu)


# Goal: focus of the workshop is to develop a practical toolkit for data 
# manipulation and presentation in R for those new to R.

# LOAD the DATA for today ---------------------------

        getwd() # current 'working directory'
        
        # Let's point our computer to where our data is (point to the folder we
        # downloaded)
        
        setwd('~/Desktop/foldername/')
        getwd()
        
        # For today, let's load in some data. The following contains:
            # - conflict event data form the ACLED dataset
            # - repression data from the World Bank
            # - Infant Mortality data from the World Bank
            # - change in GDP per capita data from the World Bank
        
        load("session_2_data.Rdata")
        
        
        # Look at the object we imported
        ls()
        
        View(acled_nig)
        View(infmort)
        View(repress)
        View(chgdppc)

   
# Tidyverse basics ----------------------------------------------------------
    
    # Installing Packages...
    # install.packages('tidyverse')
        
    # loading packages...
    require(tidyverse)
        
    
# What is in the tidyverse? ----------------------------
    
    # https://www.tidyverse.org
    
    # 'tidyverse' is an aggregation of a whole bunch of packages all made by the
    # same team. The goal is to build a vocabulary and best practice for data
    # science and manipulation. 
    
    
    # contained within:
        # - ggplot2
        # - dplyr
        # - tidyr
        # - readr
        # - purrr
        # - tibble
    
    
# Why learn this way? 
    
        # effective
        # intuitive/readable
        # efficient
    
        
# A grammar for combining data ('join' logic) ------------------------------------------
        
        # let's create two datasets
        
        fakedata1 = tibble(country=c('Russia','China','Latvia','United States'),
                           coolIV=c(1,5,7,2))
        
        fakedata2 = tibble(country=c('Canada','United States','Russia','Peru'),
                           coolDV=c(.5,.7,.9,.3))
        
        
        fakedata1
        fakedata2
        
        # Binding Rows and/or columns
        
        bind_rows(fakedata1,fakedata2)
        
        bind_cols(fakedata1,fakedata2)
        
        
        # joining (follows SQL query logic)
        
        left_join(fakedata1,fakedata2,by='country')
        
        right_join(fakedata1,fakedata2,by='country')
        
        inner_join(fakedata1,fakedata2,by='country')
        
        full_join(fakedata1,fakedata2,by='country')
        
        semi_join(fakedata1,fakedata2,by='country')
        
        anti_join(fakedata1,fakedata2,by='country')
        
        
        
  # Practice! -----
        
        # Merge the infmort, repress, and chgdppc datasets into a single
        # data.frame object...
        
        
        
        
        
        
        
        
    
# THE PIPE: connecting actions, and stringing them together -----------------
    
    
    # scenario 1: object by object
          x <- rnorm(10,0,1)
          x
          
          x2 <- mean(x)
          x2 
          
          x3 <- round(x2,2)
          x3
    
          
    # scenario 2: nesting functions
    
          round(mean(rnorm(10,0,1)),2)
    
    
    # scenario 3: pipe it!
    
          rnorm(10,0,1) %>% mean(.) %>% round(.,2)
    
    
    
    
    # Two things to keep in mind:
      
        # (1): functions are linked with '%>%' 
        
              # function1 %>% function2
        
        # (2): when functions have multiple arguments, point to where the data
        # should go with '.'
        
              # function1 %>% function2(arg1= ., arg2=TRUE)
        
          
# A grammar of data manipulation ('dplyr' logic) -----------------------------------
          
          
      # Functions that behave like they're named
          
          select() # select columns
          mutate() # create new variables, change existing
          transmute() # create new variables, drop existing
          filter() # subset your data by some criterion
          summarize() # summarize your data in some way
          rename() # rename variables (this is built into most all the functions)
          tally() # count your data
          count() # count your data
          arrange() # arrange your data by a column or variable 
          distinct() # gather all distinct values of a variable (only works with summarize)
          n_distinct() # count how many distinct values you have (only works with summarize)
          n() # count how many observation you have for a subgroup 
          sample_n() # Grab an N sample of your data
          sample_frac() # Grab a sample that is some fraction of your total data
          group_by() # group your data by a variable
          ungroup() # ungroup grouped data by a variable 
          glimpse() # quickly preview the data
          top_n() # get the top N number of entries from a data frame
          slice() # grab specific rows
          
          
      # Link these processes together with the pipe
          
          # data %>% select(var1,var2) %>% filter(var1>5) %>% summarize(mean(var2))
          
      # That's it
          
          
          
# Applied Examples:
          
      dat = acled_nig # create a new object called 'dat'
      
      # Preview the data
      glimpse(dat)
      
      
      
      # How many observations are there in the Nigeria subset of the acled data?
        
          dat %>% tally()
          
      
          
          
      # Select the date, fatalities, and actor variables
          
          dat %>% select(event_date,fatalities,actor1,actor2)
          
          
          
          
          
      # Reorder the columns so that event_date, actor1, country are leading. 
      # Rename the actor1 variable to 'group' 
          
          dat %>% select(event_date,group=actor1,country,everything())
          
          
          
          
      # Drop the 'event_id_cnty' variable
          
          dat %>% select(-event_id_cnty)
          
      
          
          
      # Gather the first 5 rows of the first 5 columns
          
          dat %>% select(gwno:year) %>% slice(1:5)
      
          
          
      # What is the temporal coverage of the data?
          
          dat %>% summarize(start = min(event_date),
                            end = max(event_date))
      
          
             
           
      # How many actors are in the data for Nigeria?
          
          dat %>% summarize(n_distinct(actor1))
          
          
          
          
      # What year was there the most activity?
          
          dat %>% group_by(year) %>% tally() %>% arrange(desc(n))
      
              
          
          
          
       # How many events occurred by event type?
          
          dat %>% group_by(event_type) %>% tally()
          
          
          
          
          
      # Who were the top 5 most violent groups in Nigeria in 2015?
          
          dat %>% filter(year==2015,fatalities>0) %>% 
            group_by(actor1) %>% 
            summarize(n_fatal = sum(fatalities)) %>% 
            top_n(5) 
          
          
          
          
      # Create a categorical variable where that takes on the following schema?
          
          # "No Violence" == no fatalities
          # "Some Violence" == 1 - 5 fatalities
          # "A lot of Violence" == more than 5 fatalities
          
      # Then order the data by that schema and see how many events fall within 
      # the specific bins, and the proportion of total events that each ordered
      # category constitutes
          
    
          dat = dat %>% 
            mutate(oFatal=NA,
                   oFatal = ifelse(fatalities==0,"No Violence",oFatal),
                   oFatal = ifelse(fatalities>0 & fatalities <=5,"Some Violence",oFatal),
                   oFatal = ifelse(fatalities>5 ,"A lot of Violence",oFatal)) 
          
          dat %>%  select(fatalities,oFatal)
          
          
          dat %>% mutate(total_N = n()) %>% 
            group_by(oFatal) %>% summarize(Freq = n(),
                                           prop = n()/max(total_N),
                                           prop = round(prop,2))
          
          
          
          
          
      # Build a dataset where the unit of analysis is the organization-year,
      # containing the following variables: 
          
          # (i) the total number of nonviolent events committed by the actor by year,
          # (ii) the total number of violent events committed by the actor by year,
          # (iii) the total number of fatalities
          # (iv) i-iii lagged by one year
          
          
        # List the Different event types...
          dat %>% select(event_type) %>% unique
          
        # A list of nonviolent events
          nv = c('Riots/Protests','Strategic development',
                 'Non-violent transfer of territory',
                 'Headquarters or base established') 
        
        # Generate data set
          newdata <- dat %>% group_by(actor1,year) %>% 
            summarize(nonviolent = sum(event_type%in% nv),
                      violent = sum(!event_type%in% nv),
                      fatal=sum(fatalities)) %>% 
            mutate(nonviolentL1=lag(nonviolent,1),
                   violentL1=lag(violent,1),
                   fatalL1 = lag(fatal,1))
          
        # View data (arranging by actor)
          newdata %>%  arrange(actor1) %>% View(.)
          

    
          
# A grammar of data visualization ('ggplot' logic) -----------------------------------      
          
      
        # Two pieces to plotting
          
              # (i): ggplot() starts the show, this is where your data goes
              
              # (ii): all variables/arguments draw from the data, need to be wrapped
              # in the aes() function (i.e. the 'aesthetics' function)
          
          
        # From there, functions that behave like they're named
          
          geom_histogram() # histogram
          geom_bar() # bar plot
          geom_line() # line plot
          geom_point() # scatter plot
          geom_boxplot() # box plot
          geom_density() # density plot
          geom_dotplot() # dot plot
          geom_violin() # violin plot
          
          
        # Everything in ggplot() is cumulative, that is we 'add' it together
          
          ggplot() + geom_histogram()
          
          
          
        # Plot themes can be changed easily
          
          theme_bw() # black and white
          theme_classic() # old school no grids
          theme_dark() # dark theme
          theme_minimal() # minimal theme
          theme_void() # no theme
          
          # again you 'add' these features on as you go
          
          ggplot() + geom_histogram() + theme_minimal()
          
          
        # Labels can be easily added to any plot
          
          ggplot() + geom_histogram() + 
            theme_minimal() + labs()
          
          
        # Customization is limitless
          
          ?theme
          
      
        # Group data either directly or generate facet plots to produce
        # individual plots (see below)
          
          ggplot(aes(x=var1,y=var2,group=country)) + geom_histogram() 
          
          ggplot(aes(x=var1,y=var2)) + geom_histogram() + facet_wrap(~country)
            
        
        # Save graphics with ggsave() or pdf() and dev.off()
         
          
          
# Applied Examples:
    
          
          
      # Visualize using a barplot the number of events by year that occurred in
      # the data?
          
          ggplot(dat,aes(x=year)) + geom_bar()
          
          
          
          
      # What is the density distribution of the log of fatal events in Nigeria?
      # Fill in the density plot with the color blue and change the background
      # from gray to white.
          
          ggplot(dat,aes(x=log(fatalities))) + 
            geom_density(fill="blue",alpha=.5) +
            theme_bw()
    
      
          
          
      # How many events of each event type happened by year in Nigeria? 
          
          # - Drop the legend
          # - Present the data as a grid (three columns)
          # - Drop the text on the x axis, 
          # - add labels and a title to the plot. 
          # - Lose the gray bands on the facets. 
          # - Have a minimal theme.
          # - Save plot image to your desktop.
          
          
          p1 = ggplot(dat,aes(x=year)) +
            geom_bar() + 
            facet_wrap(~event_type,ncol=3) + 
            labs(title="Event Types by Year in Nigeria",
                 y = "Number of Events",x="Event Type") +
            theme_minimal() +
            theme(legend.position = 'none',
                  panel.background = element_blank()) 
          
          # Save plot
          ggsave(p1,filename = '~/Desktop/myplot.pdf',device = 'pdf',width = 10,height=10)
          
          
          
          
# A grammar for cleaning and reshaping data ('tidyr' logic) -------------------------------------
      
      
    # Reshaping Data
      
      # 'gather' columns into rows
      dat %>% select(year,fatalities) %>% 
        gather(var_name,value)
      
      # 'spread' rows into columns
      dat %>% group_by(year) %>% tally %>% 
        spread(key = year,value = n)
      
      # 'separate' one column into several
      dat %>% select(event_date) %>% 
        separate(event_date,c('year','month',"day"))
      
      # 'unite' two or more columns into one
      dat %>% select(country,year) %>% 
        unite(country_year,country,year,sep="_")
      
      
    # Cleaning data
      
      # Example data
      df = tibble(group=c('a','a','b','b','c','c'),
                  year=c(1995:2000),
                  var = c(1, NA,0,NA,NA,1))
      
      # drop NAs
      df %>% drop_na()  
      
      # replace NAs
      df %>% replace_na(list(var=0))
      df %>% replace_na(list(var='unknown'))
      
      # Return only complete cases
      df %>% complete(var)
      
      
      # Expand ranges
      df %>% expand(year,group) %>% arrange(group)
      
      
      df %>% expand(year,group) %>% arrange(group) %>% 
        left_join(.,df) %>% replace_na(list(var='unknown'))
        
      
      
# Now combine dplyr, tidyr, and ggplot seamlessly....
      
      
      # Show using a line graph all the events that are associate with boko
      # haram and all events that are not associate with the group by year.
      
      
      dat %>% 
        mutate(boko_activities = grepl('boko',actor1,ignore.case = T)) %>% 
        group_by(year) %>% 
        summarize(boko_n = sum(boko_activities),non_boko_n = n()-boko_n) %>% 
        gather(var,val,-year) %>%  
        ggplot(.,aes(y=val,x=year,color=var)) + 
        geom_line(lwd=1.5) +
        labs(title='Conflict activity in Nigeria',
             y="Number of Events",x="") +
        scale_color_manual(values=c('steelblue','black'),
                           labels=c('Boko Haram','Other Events'),
                           name='') +
         theme_classic() +
        theme(legend.position = 'bottom')
      

      
# ADVANCED EXAMPLE ------------------------------------

      # Here is an advanced application but that utilizes all the same tools
      # that we've been using
      
      
      # There is world map data inherent to ggplot()
      map_data("world") %>% ggplot(.,aes(x=long, y=lat,group=group)) +
        geom_polygon(fill='grey50') 
      
      
      # Let produce a spatio-temporal heat map of all conflict occurrences in
      # Nigeria
      
      heat_colors = c("#3288BD","#99D594","#E6F598",
                      "#FFFFBF","#FEE08B","#FC8D59",
                      "#D53E4F")
      
      map_data("world") %>% 
        filter(region=="Nigeria") %>% 
        ggplot(., aes(x=long, y=lat)) +
        geom_polygon(fill='grey50') + 
        stat_density2d(data = dat,aes(y=latitude,x=longitude,
                                      fill=..level..),
                       geom="polygon",alpha=.7) +
        scale_fill_gradientn(colours=heat_colors)+
        theme_void() + theme(legend.position = "none") +
        facet_wrap(~year) + 
        labs(title="Spatio-Temporal Distribution of Conflict in Nigeria")
      
      
      