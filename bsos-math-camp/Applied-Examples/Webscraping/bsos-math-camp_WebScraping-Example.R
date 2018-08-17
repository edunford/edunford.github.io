# **********************************************
# A Crash Course in Statistical Programming in R
# Eric Dunford | edunford@umd.edu | GVPT
# **********************************************
# WEBSCRAPING EXAMPLE
# BSOS 2018 Math Camp
# **********************************************



#  Load Packages ----------------------------------------------------------

# install.packages('tidyverse')
# install.packages('rvest')

require(tidyverse)
require(rvest)



# Basics ---------------------------------

      # For this exercise, we will use a news story from the BBC as a motivating
      # example.

      # Save URL as an object
      url = "https://www.bbc.com/news/business-45216554"




      # Basics of the process:
            # (A) identify what information you want;
            # (B) examine the structure and elements;
            # (C) download website;
            # (D) extract element;
            # (E) clean element;
            # (F) store outcome.

      # Here let's shoot to extract three pieces of information.
            # (1) Headline
            # (2) Date
            # (3) Story

      # Assuming we've already knocked out A and B

      # C. download the website
      site = read_html(url)
      # Here the entire website is now retained in the "site" object.

                  # QUESTION: Why is it useful to get the whole thing in one go?

      # D. extract element
      # Two choices in extraction: xml and css ... what is the difference?

      headline.path = "//*[@id='page']/div[1]/div[2]/div/div[1]/div[1]/h1"
      site %>% html_node(.,xpath = headline.path)
      # Slightly meaningless...still in raw HTML form, let's translate

      # E. clean element
      site %>% html_node(.,xpath = headline.path) %>% html_text(.)

      # F. store outcome
      headline = site %>% html_node(.,xpath = headline.path) %>% html_text(.)
      headline



      # [1] KEEP IN MIND: Often the unstructured text requires cleaning to provide it with
      # a useable structure. What we have here is pretty clean, but keep in mind that
      # all those text manipulation skills will be of prime importance when processing
      # more complex sources.




      # Let's rinse wash and repeat -- this time using the css path (which is the
      # default for RVest)

      date.path = "//*[@id='page']/div[1]/div[2]/div/div[1]/div[1]/div[1]/div/div[1]/div[1]/ul/li/div"
      date = site %>% html_node(.,xpath=date.path) %>% html_text(.)
      # format date into a usable "R format"
      date = as.Date(date,"%d %b %Y")
      date

      # To get ALL of the body text, we really need to think about what it is we are
      # grabbing. Here comprehending the structure of the website can be really useful.
      body.path = "//*[@id='page']/div[1]/div[2]/div/div[1]/div[1]/div[2]/p[1]"
      site %>% html_node(.,xpath=body.path) %>% html_text(.)


      # This is only part of the picture. We want the WHOLE story. We can do this by
      # not just taking an individual element, but rather all tags within that div.
      body.path = "//*[@id='page']/div[1]/div[2]/div/div[1]/div[1]/div[2]/p"
      body = site %>% html_nodes(.,xpath=body.path) %>% html_text(.) # Note the plural on the function
      body = paste(body,collapse=" ") # Clean
      body

      # Storage ---------- Data frames aren't always your friend when it comes to
      # storing unstructured data. Given the multi-"entry" nature of the data, let's
      # store this information into a list.

      output = list()
      output$headline = headline
      output$date = date
      output$story = body
      str(output)




# Let’s build out what we have into a more useful function ----------------




      # [1] Building the BBC scraper -----------------------
      # Rather than gather the whole story (as we did before), let's construct a
      # dataset that tells us a slightly different story.

      # Let's grab:
          # (1) The Headline
          # (2) The Date

            my_scraper <- function(url){
              raw = read_html(url)
              headline = raw %>%
                html_nodes(.,xpath="//*[@id='page']/div[1]/div[2]/div/div[1]/div[1]/h1") %>%
                html_text(.)
              date = raw %>%
                html_nodes(.,xpath="//*[@id='page']/div[1]/div[2]/div/div[1]/div[1]/div[1]/div/div[1]/div[1]/ul/li/div") %>%
                html_text(.) %>% as.Date(.,"%d %b %Y")
              body = raw %>% html_nodes(.,xpath="//*[@id='page']/div[1]/div[2]/div/div[1]/div[1]/div[2]/p") %>%
                html_text(.) %>% paste(.,collapse=" ")
              data.out = data.frame(headline,date,body,stringsAsFactors = F)
              return(data.out)
            }
            my_scraper(url)



      # Let's now run ralph on a number of URLs that we want information on.
      urls = c("http://www.bbc.com/news/world-middle-east-36156865",
               "http://www.bbc.com/news/world-middle-east-36162701",
               "http://www.bbc.com/news/world-australia-36166803",
               "http://www.bbc.com/news/world-latin-america-36166632")
      urls

      # Gather all the stories
      store <- bind_rows(
        my_scraper(urls[1]),
        my_scraper(urls[2]),
        my_scraper(urls[3]),
        my_scraper(urls[4])
      )
      store


      # OR run a loop
      for(url in urls){
        print(url)
      }

      store = c()
      for(url in urls){
        store = bind_rows(store,my_scraper(url))
      }
      store



# [3] EXPAND to unknown URLS....

      # Now... let's build things so that we can seach stories by topic
      # Build function that runs a query and give back all the stories, dates, and links
      grab_relevant_stories = function(query){
        search_url = str_glue("https://www.bbc.co.uk/search?q={query}&sa_f=search-product&scope=")
        raw = read_html(search_url)
        headlines = raw %>% html_nodes(xpath="//*[@id='search-content']/ol[2]/li/article/div/h1") %>% html_text()
        links = raw %>% html_nodes(xpath="//*[@id='search-content']/ol[2]/li/article/div/h1/a") %>% html_attr(name = "href")
        date = raw %>% html_nodes(xpath="//*[@id='search-content']/ol[2]/li/article/aside[1]/dl/dd/time") %>%
          html_text() %>% str_trim() %>% as.Date(.,'%d %b %Y')
        return(data.frame(headlines,date,links,stringsAsFactors = F))
      }

      grab_relevant_stories('Syria') %>%
        arrange(date)

