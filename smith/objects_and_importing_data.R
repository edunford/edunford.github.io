# An Introduction to Statistical Programming in R
# Applied Example 1: Objects & Importing data 
# Session 1 - October 6, 2017
# Eric Dunford (edunford@umd.edu)


# OBJECTs---------------------------------------------------------------------
 
  # Different TYPES of Data ----------------------------------------------------

            7                 # Integers
            4.5               # Numeric
            "hello!"          # Character/string 
            TRUE              # Logical
            2i                # Complex
            factor("hello!")  # factors -- a string where a numerical value is 
            # associated with each entry (more on this later).


  # What is an object? ---------------------------------------------------------

            x <- 7
            x
            
            # `<-` assigns `7` to the letter `x`
            
            
            # Once we assign a value, it appears in the `environment` 
            
            ls() # command prints off all `objects` currently in the environment
            
            # Also look at the `environments` tab in R Studio.
            
            
            # We can write over objects to assign them new values.
            x
            x <- "hello"
            x
            x <- 6.556789
            x
            
            
            # R is an `object-oriented` language, so all the base line functionality
            # stems from assigning data to objects when we then use down the line. 
            


  # Class ----------------------------------------------------------------------

            # Every object and data structure has a specific class. Class tells us 
            # specific information about the properties of that object. As we know, 
            # there are many different types of information in R and not all of it
            # behaves the same way. 
            
            # We use the function `class()` on an object to tell us what class it is.
            
            x
            class(x)
            class("hello")
            class(FALSE)
            class(2i)
            
            
            # We can also query directly to see if an object is a particular class. 
            
            is.character("hello")
            is.character(1.45)
            
            
            # Class is important because it tells use what we can and cannot do with
            # an object. For example, we CANNOT add to a character string.
            
            object = "A sentence about something."
            class(object)
            object + 1 # error
            
            object = 1
            class(object)
            object + 1 # success!


  # Data structures ---------------------------------------------------------

        # Vector
            y <- c(1,2,3,4,5)
            y
            
            
            # c() == concatenate: "link (things) together in a chain or series"
            
            # Here we can "link" different values together into a single vector. 
            
            z <- c("Nigeria","Canada","Ohio")
            z
            
            # Look at the environment tab in R Studio. See the new objects we've created. 
            
            # Vectors can also be generated as ranges
            p <- 1:10
            p
            
            h <- 1:100
            h
            
            
            # the class of a vector is always the class of the entries in the vector.
            class(y)
            class(z)
            
            
            
            # When different classes are in the same vector, one class dominates
            vec1 <- c(TRUE,89,3,FALSE) # Logical to Numeric
            vec1
            
            vec2 <- c("cat",89,3,"dog") # all to character
            vec2
            
            vec3 <- c(TRUE,"cat",89,3,"dog",FALSE) # all to character
            vec3
            
            # Character class dominates. 
            
            
            
        # Matrix
            
            # Like a vector, a matrix offers a way of organizing data into a 2-dimensional array
            
            m <- matrix(c(1,2,3,4,5))
            m
            class(m)
            
            m <- matrix(c(1,2,3,4,5),nrow=1) # Specify the number of rows
            m
            
            m <- matrix(1:25,nrow=5,ncol=5) # Specify the number of rows and columns
            m
            
            # Again, the class rules we identified above are true for a matrix as well.
            mat1 <- matrix(c(1:10,"dog","cat"),ncol=2,nrow=6)
            mat1
            
            
            
        # Array 
            
            # similar to a matrix but with more than dimensions 
            a = array(0,c(2,2,2))
            a
            class(a)
            
            
        # List
            
            # A list is a way of organizing data of different lengths and classes
            L = list(var1 = c(1,2,3,4,5),
                     var2= c("A","B","C","D","E"))
            L
            class(L)
            
            
        # Data Frame
            
            # A data frame (or a dataset) is what we traditionally think of for data
            # analysis. 
            var1=c(1,2,3,4,5)
            var2=c("A","B","C","D","E")
            var1
            var2
            D <- data.frame(var1,var2)
            D
            class(D)
            
            # Though a data frame looks similar to a matrix, it differs in one 
            # important way: a data frame can hold many different types of classes
            # within each column. 
            
            
            
            D <- data.frame(var1=c(1,2,3,4,5),
                            var2=c("A","B","C","D","E"))
            M <- matrix(c(1,2,3,4,5,"A","B","C","D","E"),ncol=2)
            
            
            # What's the difference between the two?
            D
            M
            
            M[,1]
            class(M[,1])
            D[,1]
            class(D[,1])
            
            
            
            # Finally, the same object can be "coerced" into taking on a different structure
            
            x = 1:10
            x
            as.matrix(x)
            as.data.frame(x)
            as.list(x)


  # Accessing a data structure -------------------------------

            # Length/Dimension
            
            length(1)
            length("hello")
            
            y 
            length(y) 
            
            m
            dim(m)
            nrow(m)
            ncol(m)
            
            D
            dim(D)
            
            
            # Accessing the Structure of a data object
            
            # in R, we can access ("get inside") an object by using brackets.
            
            y # vector
            y[1]
            y[3] # we can grab specific locations within a vector. 
            
            
            # We know a matrix and data frame has two dimensions, and we can
            # leverage that information to give use specific pieces of the object.
            
            M # look at the row and column heading when we print our matrix
            M[1,] # the first row
            M[,1] # the first column
            M[1,1] # the first cell
            
            D # data frame
            D[1,] # first row
            D[,1] # first column
            D[,"var1"] # first column using the columns name
            D[1,"var1"] # first cell
            
            
            # For data frames, we can access the information inside the set by using a
            # handle (`$`). This helps use extract specific variables.
            
            D$var1
            D$var2
            
            
            
  # APPLIED PRACTICE (OBJECTS) ----------------------------------------
            
            
            # (1) From the following Vector, pull out the Fifth Element.
            
                vec <- c("A","B","C","D","E","F")
            

            
            
            # (2) What class is the object vec?
            
            
            
            
            
            # (3) Access the 5th row and 2nd column of the `M` matrix object we
            # created above. What's it's value?
            
            
            
            
            
            # (4) Using two seperate approachs, create and save a vector of
            # numbers in an object name "monday".
            
            
            
            
            
            # (5) Clear all objects from the environment.
            
        
              
              
# IMPORTING/EXPORTING DATA -------------------------------------
    
  
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
    install.packages("readr") 
    
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
    
    require(readr)
    
    # Now we can use all the functions in the foreign package!
    
    # To get a census of the functions in a package, we can click on the
    # "foreign" tab in R Studio
    
    
    # QUESTION ABOUT WHAT A FUNCTION DOES?
    ?read_dta
    
    ?length
    
    ?data.frame
    
    
  # Importing/Exporting Data ----------------------------------------------------------
    
      # R can read in a number of file formats. However, not all. We'll need
      # to use different packages to read in different file types.
      
      # Install the package
      install.packages("readr") # A robust package for importing many data types
      install.packages("readxl") # For excel spreadsheets
      install.packages("haven") # For .dta, spss, sas
      
      
      # Load the package
      require(readr)
      require(readxl)
      require(haven)
    
    
    
    # Setting the WORKING DIRECTORY
      
      # R doesn't inherently know where your data is, so we need to tell R 
      # where to look. One of the most straightforward ways of doing this is 
      # to set the "working directory" to the location of your data in R. 
      # Alternatively, one can specify the individual "path" when importing
      # data.
      
      getwd() # Get current working directory
      
      # Set the new directory to some "practice" folder on our desktop (you'll have to create this)
      setwd("/Users/edunford/Desktop/Practice_Folder") 
      
      
    # For the following example, we are going to use the `sleep` example dataset,
    # which is inherent in R.
      
      ?sleep # to see what it's all about
       
      
  # Let's EXPORT the sleep data into a number of different formats in
    
    # as a .dta
    write_dta(sleep,path = "sleep.dta")
   
    # as a .csv 
    write_csv(sleep,path = "sleep.csv")
    
            # as a excel (.csv)
            write_excel_csv(sleep,path = "sleep.csv")
    
    # as a .tab
    write_tsv(sleep,path = "sleep.tab")
    
    # as spss (.sav)
    write_sav(sleep,path = "sleep.sav")
    
    # as .Rdata
    save(sleep,file='sleep.Rdata')
    
  # Now let's IMPORT that data back into R (and load into new objects)
      
    # There are two ways to import data:
      # (1) point-and-click via R Studio
      # (2) commands in the console (as we've been doing)
      
      S1 <- read_dta("sleep.dta")
      S2 <- read_csv("sleep.csv")
      S3 <- read_tsv("sleep.tab")
      S4 <- read_sav("sleep.sav")
      load(file='sleep.Rdata')
    
  
    
    
    