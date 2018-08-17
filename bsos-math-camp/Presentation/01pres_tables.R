# **********************************************
# A Crash Course in Statistical Programming in R
# Eric Dunford | edunford@umd.edu | GVPT
# **********************************************
# Presenting Results
# BSOS 2018 Math Camp
# **********************************************



# R Markdown, R "NoteBooks", R Presentation -------------------------------


    # (1) Open the markdown_basics.rmd file. [Note that a bunch of packages will download
    # on their own.]

    # (2) Then let's walk through R Notebooks. The newest feature of RStudio.

    # (3) Finally, let's look at how to put together some great slides. Open the
    # slides_basics.rmd



# LaTex Tables ------------------------------------------------------------

      # For published work we need clean tables and figures. LaTex helps us do
      # just that. The following set of functions will help show you how one can
      # translate tables and figures into publishable tables.

      # install.packages("stargazer")
      # install.packages("xtable")
      require(stargazer)
      require(xtable)



  # STARGAZER #

      # Both produce output that is translated into latex.
      stargazer(iris)

      # We can craft a lot of the output using the function.
      stargazer(iris,title = "Descriptive Statistics",style = "AJPS",
                covariate.labels = c("Sepal Length",
                                     "Sepal Width",
                                     "Petal Length",
                                     "Petal Width"))


      # When Presenting Models, we can bring multiple models together with ease.

      # Create some fake data
      X <- matrix(data = NA,nrow=100,ncol=5)
      for(i in 1:5){X[,i] <- rnorm(100,1,5)}
      y <- cbind(1,X)%*%c(2,.3,2,3,.5,1) + rnorm(100,0,1)
      data = data.frame(cbind(y,X))
      colnames(data) <- c("y",paste0("x",1:5))
      head(data)

      model1 <- lm(y~x1,data=data)
      model2 <- lm(y~x1+x2+x3,data=data)
      model3 <- lm(y~x1+x2+x3+x4+x5,data=data)

      stargazer(model1,model2,model3,
                title="OLS Results")


  # XTABLE #

      # Stargazer is great, but it doesn't always play well with all objects.
      # When you have a weird table/output that you want to latex and stargazer
      # won't behave, use xtable.

      table(mtcars$gear,mtcars$carb)
      stargazer(table(mtcars$gear,mtcars$carb))
      xtable(table(mtcars$gear,mtcars$carb))

      # Not as pretty, but it gets the job done!



# PUBLISHABLE GRAPHS ------------------------------------------------------


    # cairo_pdf() # vectorize PDF
    # cairo_ps() # Post Script

    # Both functions return graphs that can be manipulated in illustrator.
    # This (a) makes it easy for a publisher to manipulate your graphs, and
    # (b) it ensures that your graphics will be clear (rather than fuzzy and
    # granular)

    cairo_pdf("~/Desktop/test.pdf")
    hist(rnorm(1000,3,4),col="lightblue",border="white",
         breaks=50,xlab="X",main="My Histogram")
    dev.off()
