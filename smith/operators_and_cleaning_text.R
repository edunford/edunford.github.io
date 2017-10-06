# An Introduction to Statistical Programming in R
# Applied Example 2: Operators and Cleaning Text
# Session 1 - October 6, 2017
# Eric Dunford (edunford@umd.edu)



# MATH OPERATORS ---------------------------------------------------------------

    # let's briefly review common operators by manipulating two objects: x and y
    
    x <- 3
    y <- 5
    
    # Mathematical Operators
    
          x + y  # addition
          x - y  # subtraction
          x * y  # multiplication
          x / y  # division
          x^y    # exponentiation
          x %*% y  # matrix multiplication
          
    # Mathematical Functions
          
          log(x) # Natural Log
          log(x,base = 10) # Log with another base
          exp(x) # exponential
          
          sum(1:100)
          mean(1:100)
          median(1:100)
          
          
          round(3.43455)
          round(3.43455,2)
          round(3.43455,3)
         
           
    # remember an object stores a specific piece of information, which we can 
    # manipulate down the line. Thus we can make piecewise changes and save each
    # step in a NEW OBJECT
          
          x <- 100
          x
          z <- x + 7
          z
          w <- z * 8
          w
          p <- w/1000
          p
          
    # Or overwrite each object
          
          x <- 100
          x
          x <- x + 7
          x
          x <- x * 8
          x
          x <- x/1000
          x
          
    # what's the dangers of overwriting when manipulating data?
          
          
          
# BOOLEAN OPERATORS ---------------------------------------------------------------   
            
    # Boolean ("logical") Operators
          
          x == y      # equals to
          x != y      # does not equal
          x >= y      # greater than or equal to
          x <= y      # less than or equal to
          x > y       # greater than
          x < y       # less than
          x==1 & y==5 # "and" conditional statements
          x==1 | y==5 # "or" conditional statements
          
    # Boolean ("logical") functions
          
          str <- "hello"
          num <- 1
          
        # for Class
          is.character(str)
          is.character(num)
          
          is.numeric(str)
          is.numeric(num)
          
        # for Data Type
          is.vector(str)
          is.vector(num) # vector of lenght 1
          
          is.matrix(str)
          is.data.frame(str)
          
        # For missing values
          is.na(NA)
          is.na(str)
    
    
   # Boolean statements can be used to SUBSET entire vectors and data structures
          
          vec <- c(1,5,0,9,10,100,.6,88,8.3,2.9,4)
          
          bool <- vec > 3
          
          # And we can use this statement to subset values within
          
          vec[bool]
          
          
          # Same for matrices and data frames
          
          mat <- matrix(1:25,ncol=5,nrow=5)
          
          bool2 <- mat > 10
          
          mat[bool2]
          
          
          # Interestingly we can use this property to quickly convert values
          
          mat[bool2] <- 1
          mat[!bool2] <- 0
          mat
          
          mat[bool2] <- "Yes"
          mat[!bool2] <- "No"
          mat
          
          
      # Checking if one list of values is located in another list of values
          
          values1 <- c("cat","dog","fish","cow")
          values2 <- c("zebra","panda","fish","moose","bee")
          
          values1 == values2 # didn't work!
          
          values1 %in% values2 # are any of values1 in the object values2?
          
          values1[values1 %in% values2]
          

                    
# REGULAR EXPRESSIONS AND STRING MANIPULATIONS in R ---------------------
          
      str = c("Canada","2 good","New Zealand","News","R2D2")
          
          
      # grep() --- Locating pattern in a vector
          
          grep(pattern = "New",str) # provides location in a vector
          
          # E.g. 
          str[1]
          str[grep(pattern = "New",str)]
          
          str[grep(pattern = "New ",str)]
          
          str[grep(pattern = "New\\w",str)]
          
          str[grep(pattern = "\\d",str)]
          
          str[grep(pattern = "\\d\\w",str)]
          
          str[grep(pattern = "\\d\\s",str)]
          
          
      # grepl() --- Locating pattern in a vector (returns logical)
          
          grepl(pattern = "New ",str) # Provides a logical vector
          
          # E.g.
          str[grepl(pattern = "New ",str)]
          
          
          
          
      # gsub() ---- Replacing Text
          
          gsub(pattern = "New",replacement = "Old",str) # replace values in a vector
          
          gsub(pattern = "New ",replacement = "Old ",str) 
          
          gsub(pattern = "\\d",replacement = "",str) 
          
          
          
       # manipulate case
          tolower("THIS IS IMPORTANT")
          toupper("This is a normal sentence.")
          
      # trim white space
          trimws("\n\n This string has so much white space.  ")
          
          
  ### Some handy characters to know:
          
      # `+` = match 1 or more of the previous character
      # `*` = match 0 or more of the previous character
      # `?` = the preceding item is optional (i.e., match 0 or 1 of the previous character).
      # `[ ]` = match 1 of the set of things inside the bracket
      # `\\w` = match a "word" character (i.e., letters and numbers). 
      # `\\d` = match digits
      # `\\s` = match a space character
      # `\\t` = match a "tab" character
      # `\\n` = match a "newline" character
      # `^` = the "beginning edge" of a string
      # `$` = the "ending edge" of a string
      # {n} = the preceding character is matched n times
          
      trouble = c("4Texas::","BigSmall","!But! What about Number 5?")
          
      trouble[grep("\\d",trouble)] # draw out digits
      trouble[grep("Tex*",trouble)] # find fuzzy text
      trouble[grep("Bi+",trouble)] # find fuzzy text
      trouble[grep("[::]",trouble)] # find specific punctuation.
      trouble[grep("[!]",trouble)]
      trouble[grep("?Sm",trouble)] # Locate partials.
      trouble[grep("?Sm|[!]",trouble)] # Conditionals work
      trouble[grep("[[:upper:]]",trouble)] # Locate strings with upper case
      
      
      # Use this combination to, say, clean a string of punctuation
      dirt = "22Clean 5674.5this $%&*_@string!"
      gsub("[[:punct:]]","",dirt)
      gsub("[[:punct:]]|\\d","",dirt)
          
          
          
          
          
    # Manipulation requires that you tokenize a string (i.e. break it up)
          
      text = "We're all very sad that Hillary Clinton lost the election."
      
      token = strsplit(text,split = " ") # Splitting by Spaces.
      token = token[[1]]
      token[1]
      token[2]
      token[10]
      
      # we can "paste" vectors back together after tokenizing
      
      paste0(token,collapse = " ")
      
      # Collapse denotes what to piece the string together by
      paste0(token,collapse = "")
      paste0(token,collapse = "<<>>")
      
      
      # paste() and paste0() are extremely useful string functions. I use them
      # on EVER SCRIPT. 
      
      paste("Fruit","Juice") # Requires a seperator; default is a space
      paste("Fruit","Juice",sep="--")
      
      paste0("Fruit","Juice") # doesn't require a seperator. Is how you present the info.
      paste0("Fruit"," ","Juice")
      
      
  # STRINGR ------------------------------------------------------
      
      # "STRINGR" is an extremely versatile regex package. 
      # install.packages("stringr")
      require(stringr)
      
      text
      str_count(text) # count the number of charaters
      
      str
      str_count(str)
      
      str_detect(str,"Canada") # detect a word (same as grepl)
      
      str_dup("Laughable ",5) # repeat a word
      
      str_extract(token,"\\w+[']\\w+") # Extract Word from String
      
      str_c(token,collapse = " ") # similar to paste(,collapse=)
      
      str_match(text,"Hillary")
      
      str_locate(text,"Hill") # Locate where and the length in the text
      
      str_replace(text,"Hillary Clinton","Donald Trump") # Replace a value in a string
      
      str_split(text," ") # same as strsplit()
      
      
      # lower/upper/title case
      str_to_title("the great gatsby")
      str_to_lower(text)
      str_to_upper(text)
      
      
      str_trim("\n\n This string has so much white space.  ") # same as trimws()
      
      
      str_trunc(text,25) # truncate after the first 25 characters.
      
      
  ## DATES -------------------------
      
      my.date = "2009-Jan-01"
      
      as.Date(my.date)
      
      clean.date = as.Date(my.date,"%Y-%B-%d")
      clean.date
      
      # Date formats have nice properties
      clean.date + 1
      clean.date + 31
      clean.date + 365
      clean.date - as.Date("2008-01-01")
      
      
      # Date formating features to keep in mind
      
      # %d = day as a number 
      # %a = abbrev. weekday
      # %A = Unabbrex. weekday
      # %m = month as number
      # %b = abbrev. month
      # %B = Unabbrev. month
      # %y = 2 digit year
      # %Y = 4 digit year
      
      dates = c("January 7, 2009","10/30/88","7th of May 2000")
      dates
      
      as.Date(dates[1],"%B %d, %Y")
      as.Date(dates[2],"%m/%d/%y")
      as.Date(dates[3],"%dth of %B %Y")
      
      
      
      # Use what we know to easily manipulate date data
      dates.data = data.frame(month=c(1,3,5,10),
                              day = c(30,4,6,16),
                              year = c(1988,2021,1977,2014))
      dates.data
      
      # Paste dates together
      dates.data$date = paste(dates.data$month,dates.data$day,dates.data$year,sep="-") # paste
      
      
      # Convert to date
      dates.data$date = as.Date(dates.data$date,"%m-%d-%Y")
      head(dates.data)
      
      
      # Analyze
      dates.data$days_since_min = as.numeric(dates.data$date - min(dates.data$date))
      dates.data$years_since_min = round(dates.data$days_since_min/365,2)
      head(dates.data)
      
      
      
  # Dealing with problematic country names ----------------------------------------
      
      # Here is a quick and easy package for dealing with country names.
      
      # install.packages("countrycode")
      require(countrycode)
      
      countries = c("Democratic Republic of Congo","DR Congo","Congo","Zaire")
      
      countries
      countrycode(countries,origin = "country.name",destination = "country.name") # Standardize Country Names
      countrycode(countries,"country.name","cowc") # Cow three letter code
      countrycode(countries,"country.name","cown") # Cow numerical code
      countrycode(countries,"country.name","wb") # World Bank code 
      # etc.
      
      
      