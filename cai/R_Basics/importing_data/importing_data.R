####################################################
### An Introduction to Statistical Programming in R
### April 3, 2016
### Eric Dunford (edunford@umd.edu)
####################################################
###########      R BASICS       ####################
####################################################
###### Packages and Importing/Exporting Data #######


# Packages -----------------------------------------------------------------------
        
        
        # We've already seen a number of "base" functions
              length()
              class()
              matrix()
              as.data.frame()
              # etc.
        
    # To get functions, that are not installed on R, we need to import them from
    # other packages. To do this, we need to first `install` and then `load`
    # them
              
    
    # Installing packages
        install.packages("foreign") 
        
        # The following installs the package `foreign` from the CRAN repository.
        # When you install a package, R may ask you to identify a repository 
        # that is near by. Just click on the geographic location that is close 
        # to where you're at (in reality, the geographic proximity doesn't
        # matter too much).
        
    # Loading packages
        
        # Once installed, that version of the package is stored on your computer
        # for good. We then just need to "load" the package into R to use the 
        # functions. This will load the package into the current NAMESPACE, 
        # which is fancy way of saying that we are taking the tools out of the
        # cabinet and putting them on our work desk to use in our project. 
        
        # We use one of two functions to do this:
        library()
        require()
        # both do the same thing. 
        
        require(foreign)
        
        # Now we can use all the functions in the foreign package!
        
        # To get a census of the functions in a package, we can click on the
        # "foreign" tab in R Studio
        
        
        # QUESTION ABOUT WHAT A FUNCTION DOES?
        ?read.dta
        
        ?length
        
        ?data.frame
  
              
# Importing/Exporting Data ----------------------------------------------------------
        
        # R can read in a number of file formats. However, not all. We'll need
        # to use different packages to read in different file types.
        
        # Install the package
        install.packages("foreign") # For .dta (STATA 12 or lower)
        install.packages("readstata13") # For loading in .dta's from STATA 13 or higher
        install.packages("readxl") # For excel spreadsheets
        install.packages("haven") # For SPSS
        
        
        # Load the package
        require(foreign)
        require(readstata13)
        require(readxl)
        require(haven)
        
        
    
    # Setting the WORKING DIRECTORY
        
        # R doesn't inherently know where your data is, so we need to tell R 
        # where to look. One of the most straightforward ways of doing this is 
        # to set the "working directory" to the location of your data in R. 
        # Alternatively, one can specify the individual "path" when importing
        # data.
        
        getwd() # Get current working directory
        
        setwd("/Users/edunford/Desktop/") # Set the new directory
        setwd("/Users/edunford/Dropbox/Programming/R/Teaching/CIA_Short_Course/basics/example_data/")
        
        
    # IMPORT DATA:  
        
        # The following relies on data provided zip file.
        
        # There are two ways to import data:
              # (1) point-and-click via R Studio
              # (2) commands in the consol
        
        # .txt (text file where entries are seperated by semi-colons)
        read.table("alabama.txt")
        alabama_crime <- read.table("alabama.txt",sep=",",header=T) # Need to set the delimiter and that that the first rows are headers
        
        # .csv (Comma Seperated)
        idaho_crime <- read.csv("idaho.csv")
        
        
        # .sav (SPSS)
        alaska_crime <- read_sav("alaska.sav")
        
        
        # .dta (stata)
        illinois_crime <- read.dta("illinois.dta") # if stata 12 <=
        # illinois_crime <- read.dta13("illinois.dta") # if stata 13 >=
        
        
        # .xlsx (Excel)
        virginia_crime <- read_excel("virginia.xlsx")
        
        #.Rdata (R format)
        load("maryland.Rdata") # Loads an object directly into the working environment
        
        
    # Exporting Tables
        
        # .txt/.tab
        write.table(alabama_crime,file="alabama_crime.txt",sep=",")
        
        # .csv [RECOMMENDED]
        write.csv(idaho_crime,file="idaho_crime.csv",row.names = F)
        
        # .spss
        write_sav(alaska_crime, "alaska_crime.sav") # write .spss file format
        
        # .dta
        write.dta(illinois_crime,"illinois_crime.dta") # <= 12
        ave.dta13(illinois_crime,file="illinois_crime2.dta") # >=13
        
        # .Rdata [RECOMMENDED]
        save(maryland_crime,file="maryland_crime.Rdata") # saves as an R data object 
        
        
# Examining Data -----------------------------------------------------------       
        
        # Four options for viewing data in a dataset:
        
            # (1) Via R Studio -- click on the data frame icon in the environment
        
            # (2) from the consol with View()
        
                  View(maryland_crime)
        
            # (3) printing (not advised if the data is big!)
        
                  maryland_crime 
                  print(maryland_crime)
          
            # (4) head() and/or tail() -- grab the first part of the last part of a data frame.
        
                  head(maryland_crime,3) # just give me the first three observations
                  tail(maryland_crime,3) # just give me the last three observations
                  
                  # Head/Tail is quite useful when the data is BIG
        
                  
# Appending Data ----------------------------------------------------------     
        
      # R allows use to have multiple datasets in at once. This means that we
      # can easily combine and manipulate data with ease. 
                  
      # Let's combine our 6 crime datasets using `rbind()` which means row bind.
                  
          ls() 
                  
          dim(maryland_crime)
          dim(idaho_crime)
          
          new_data <- rbind(maryland_crime,idaho_crime) 
          
          dim(new_data)
          
          
          new_data <- rbind(new_data,alaska_crime)
          
          new_data <- rbind(new_data,alabama_crime)
          
          new_data <- rbind(new_data,illinois_crime)
          
          new_data <- rbind(new_data,virginia_crime)
          
          
          View(new_data)
          

# Practice ---------------------------------------------------------- 
          
          
          # (1) Download and install a package called "XLConnect"
          
          
          
          
          # (2) Save the object "new_data" as a .Rdata on your Desktop
          
          
          
          
          # (3) Using "View(new_data)" find out which city from our sample has
          # the most violent crime.
                  
          
          
          
          # (4) Find out what the "stringsAsFactors=" argument does on the
          # "read.csv()" function using the R Documentation
          
          