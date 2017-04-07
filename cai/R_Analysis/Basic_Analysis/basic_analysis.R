####################################################
### An Introduction to Statistical Programming in R
### DAY 4 (April 6, 2016) 
### Eric Dunford (edunford@umd.edu)
####################################################
############    BASIC ANALYSIS       ###############
####################################################


# Since we're familiar with dplyr and ggplot. Let's load it and use it when we can.
require(dplyr)
require(ggplot)



# EXAMPLE DATA --------------------

# For the following plunge we'll use a variety of data sources, some of which are
# inherent to R, and others which we will import via the downloaded .Rdata

      load("analysis.Rdata")
      

# Summary Statistics in R --------------------
      
      # For the following, let's use the "iris" dataset in R
      
      df <- iris
      
     
      # The basic summary function can offer the spread of just one variable
      summary(df$Sepal.Length)
      
      # or all variables in a data frame
      summary(df)

  # There are a wealth of summary opperators in R. 

      # Mean
        mean(df$Sepal.Length) 

      # Median
        median(df$Sepal.Length) 

      # Five Number Summary
        fivenum(df$Sepal.Length)
        # which is like summary() but doesn't report the mean
        
      # Standard Deviation
        sd(df$Sepal.Length) 
        
      # Variance 
        var(df$Sepal.Length)
        
            # Variance-Covariance
            df %>% select(-Species) %>% var
        
      # Minimum
        min(df$Sepal.Length) 
        
      # Maximum
        max(df$Sepal.Length) 
        
      # Range of a varible (min-max)
        range(df$Sepal.Length) 
        
      # Means by Column 
        colMeans(df[,1:4]) # you cannot have strings
        
      # Means by Row
        rowMeans(df[,1:4]) 
        
      # Distribution Quantiles
        quantile(df$Sepal.Length) 
        
        
            
  # Sometimes the best way to understand a distribution is to visualize it. 
        
        # as histograms...
        qplot(Sepal.Length,data=df) + xlim(0,10)
        
        # or as density plots...
        qplot(Sepal.Length,data=df,geom="density") + xlim(0,10)

        
        
# CORRELATIONS ---------------------------------------------------------
        
        # Most statistical analysis pivots off a simple
        # question: "how are two variables related to one another?"
        
        
        # Let's consider two variables from the IRIS data
        df %>% select(Sepal.Length,Petal.Length) %>% summary
        
        
        # Let's visualize the correlation
        qplot(Sepal.Length,Petal.Length,data=df)
        
        
        # To get a quick correlation
        cor(df$Sepal.Length,df$Petal.Length)
        
        
        # ...but is that correlation statistically significant?
        cor.test(df$Sepal.Length,df$Petal.Length)
        
        
    # A Few Things to Note....
        
        # There are many different types of correlation tests. Luckily, there is
        # just one function. 
            cor.test(df$Sepal.Length,df$Sepal.Width,method = "kendall")
            cor.test(df$Sepal.Length,df$Sepal.Width,method = "spearman")
        
        
        # We can process a whole data frame at once using cor() to return a
        # correlation matrix
        
            cor_mat <- df %>% select(-Species) %>% cor
            
            cor_mat
        
        
        # There are even packages out there that will help us visualize these correlations
        
            # install.packages("corrplot")
            require(corrplot)
            
            corrplot(cor_mat)
            
            dev.off() # clear the plotting function
        
        
        
        
# DIFFERENCES IN MEANS between two groups -------------------------------------
        
        # the "sleep" data in R Data which show the effect of two soporific
        # drugs (increase in hours of sleep compared to control) on 10 patients.
        
        head(sleep)
        
            # extra sleep (numeric)
            # group ID (interger)
            # participant ID (integer)
        
            
        # Examine the different distributions between the two groups
            
            qplot(extra,facets=~group,data=sleep,geom="density")
            
            
        # How (if at all) different are the effects of these two drugs?
        
            sleep %>% 
              group_by(group) %>% 
              summarize(extra = mean(extra))
            
            
        
             
        
        # The means are quite different. But is that difference meaningful --
        # that is, is it better than random chance? 
            
        # A T-Test can help us figure that out.
        
            g1 <- sleep %>% filter(group==1) %>% select(extra)
            g2 <- sleep %>% filter(group==2) %>% select(extra)
            
            
            t.test(g1,g2)
            
            # What does this tell us?
            
          
            # Saving a statistical analysis as an object
            
            tt_obj <- t.test(g1,g2)
            
            str(tt_obj)
            
            tt_obj$estimate
            tt_obj$p.value
            
            
            # Why might it be useful to save results as an object?
            
            
            
# DIFFERENCE in PROPORTION -------------------------
        
      # Say we have the outcome of two coins which we flip 100 times, we want to
      # figure out if either coin is "unfair" (i.e. where the odds of flipping a
      # heads is not 50/50).
        
            head(coins)
            
            coin1 <- coins$coin1
            qplot(coin1,geom="bar")
            
            coin2 <- coins$coin2
            qplot(coin2,geom="bar")
        
        
      # prop.test() helps us calculate the difference between a proportion and
      # our prior belief regarding the true population proprotion (which in this
      # case is random chance)
        
            successes <- sum(coin1=="Heads")
            successes
            prop.test(x=successes,n=100,p=.5) # Not significant
            
            successes <- sum(coin2=="Heads")
            successes
            prop.test(x=successes,n=100,p=.5) # Highly significant
        
        # Conclusion: coin2 is unfair (i.e. there is not a 50/50 chance of
        # getting a heads/tails)
        
        
        
        
# CROSS TABULATION -----------------------------------------
        
        # A crosstab offers a powerful descriptive and statistical analysis when
        # comparing the effect of one categorical variable on another. 
        
            
        
        # For the following analysis, let's use part of a  2016 MTURK survey
        # that looked at partician affliation and gun support. 
            
            
        # The data records: respondents home state, self-reported age/sex, 
        # whether he/she approves of guns (guns), and political affiliation
        # (rep/dem/indep)
            
            colnames(gun_survey)
            
            dim(gun_survey) # 661 respondents in the sample. 
            
            head(gun_survey)
            
            
        # What is the breakdown in support/approval among respondents by affiliation?
            
            qplot(data=gun_survey,x=guns,facets=~ideol,fill=guns)
            
            qplot(data=gun_survey,x=ideol,facets=~guns,fill=ideol)
            
            
        # How many were sampled from each pol. aff.?
            
            table(gun_survey$ideol)
            
            # slight over representation of the dems
            
            
        # What is the relationship between party and gun approval? --- There is
        # a numbe of ways we can look at this questions in R. 
            
            
            # table() offers a really basic cross table
            
            tab1 <- table(gun_survey$guns,gun_survey$ideol)
            
            tab1
            
            # but this doesn't give us a sense of proportion. 
            
            
            # We can get a proportion manually by dividing the table by the
            # total
            
            tab_prop <- tab1/nrow(gun_survey)
            round(tab_prop,2)
            
            # or we can use prop.table()
            
            prop.table(tab1) # cell percentages
            prop.table(tab1,1) # row percentages
            prop.table(tab1,2) # col percentages
            
            
           
    # Packages 
        # There are many extremely useful packages for crosstabs. Here are two
        # (both of which are quite similar to one another)
          
              
        # (1) CrossTable() from the package descr
            
            # install.packages("descr")
            require(descr)
            
            
            CrossTable(x=gun_survey$ideol,y=gun_survey$guns)
            
            # Produces a TON of information, which we can cutomize
            
            ?CrossTable
            
            # Props by Row
            CrossTable(x=gun_survey$guns,gun_survey$ideol,
                       prop.r = T,prop.c = F,prop.t = F,
                       prop.chisq = F)
            
            # Props by Column
            CrossTable(x=gun_survey$guns,gun_survey$ideol,
                       prop.r = F,prop.c = T,prop.t = F,
                       prop.chisq = F)
            
            
            # Can even through in a Chisq test to see if the differences between
            # categories are significant
            CrossTable(x=gun_survey$guns,gun_survey$ideol,
                       prop.r = T,prop.c = F,prop.t = F,
                       prop.chisq = F,chisq = T)
            
      # (2) CrossTable() fromt the package gmodels
            
            # install.packages("gmodels")
            require(gmodels)
            
            CrossTable(x=gun_survey$guns,gun_survey$ideol)
            
            # Practically the same thing as the descr version...
            CrossTable(x=gun_survey$guns,gun_survey$ideol,
                       prop.r = T,prop.c = F,prop.t = F,
                       prop.chisq = F,chisq = T)
            
            # But you can set the format to your SAS or SPSS likings
            
            CrossTable(x=gun_survey$guns,gun_survey$ideol,
                       prop.r = T,prop.c = F,prop.t = F,
                       prop.chisq = F,chisq = T,
                       expected=T, # expected counts
                       format="SPSS")
            
            
      
# Linear Regression in R ------------------------------------
            
      # Linear regression is a method for finding the line that best explains 
      # the relationship between an explanatory and outcome variable. We do this
      # by minimizing the squared errors -- which put simply, is saying we want 
      # a line where the distance between any data point and that line is the
      # smallest.
      
      # R is fundamentally a statistical software package, and thus, it excels 
      # performing advanced statistical analyses such as regression. In the 
      # following, I will lay out how to deal with a lm (linear model) objects,
      # and will show some useful tools for prediction, visualization, and fit. 
      
      
      # TREES DATA
      # Let's use the trees data in R for the following example. This data
      # provides measurements of the girth, height and volume of timber in 31
      # felled black cherry trees. [Note that girth is the diameter of the tree
      # (in inches) measured at 4 ft 6 in above the ground.]
      
      head(trees)
      
      par(mfrow=c(1,3))
      hist(trees$Girth,col="wheat")
      hist(trees$Height,col="steelblue")
      hist(trees$Volume,col="coral")
      
      dev.off()
      
      
      # Theory: fatter tries produce more timber (even when controlling for height)
      
      
      # bi-variate relationship
      qplot(trees$Girth,trees$Volume) # relationship looks almost linear
      qplot(trees$Height,trees$Volume) # relationship looks almost linear
      
      
      
      # LOESS regression (Locally Weighted Scatterplot Smoothing) --- generate a
      # smooth line through a scatter plot to help see relationships between two
      # variables. 
      
      qplot(trees$Girth,trees$Volume) + geom_smooth()
      qplot(trees$Height,trees$Volume) + geom_smooth()
      # (Note that the confidence intervals are bootstrapped)
      
      # we can also fit a loess smoother with Base plots
      plot(trees$Girth,trees$Volume,pch=16,col="grey50",cex=1.5) 
      lines(loess.smooth(trees$Girth,trees$Volume),lwd=3) 
      
      
      
      
      
      # Regressing girth on volumn (understanding LM objects)
      
      # model set up:
      
      # y ~ x   :::  y = constant + slope*x + error
      
      model1 <- lm(Volume ~ Girth, data=trees)
      
      model1
      
      
      class(model1)
      
      
      # summary() takes on new functionality with statistical objects. It
      # reports a concise summary of the statistical output of the model
      
      summary(model1)
      
      
      # plot() does too
      par(mfrow=c(2,2))
      plot(model1)
      dev.off()
      
      # plot() offers Model Diagonostics, which tell you how well your
      # model is following the assumptions that underpin regression
            # (1) linearity test,
            # (2) normality assump. test, 
            # (3) equal variance test (homosk.),
            # (4) locating outliers (influencial cases)
      
      
      # Understanding an "lm" object
      
      str(model1) # there is a lot inside...
      
      # works a lot like accessing variables in a data frame
      model1$coefficients 
      model1$residuals 
      model1$fitted.values 
      
      
      # Auxillary Functions
      
            # predict() -- model prediction
            
            # resid() -- molde errors 
            
            # vcov() -- variance-covariances
            
            # Goodness of Fit Statistics
            
                  # AIC()
                  # BIC()
      
      
      prediction <- predict(model1)
      residuals <- resid(model1)
      vcov(model1)
      AIC(model1)
      BIC(model1)
      
      
      # There is our "prediction" for each value of Girth given our model
      plot(trees$Girth,prediction,pch=16) 
      
      
      # This is the error between our prediction and the actual data. 
      plot(trees$Girth,residuals,pch=16) 
      
      # Is there a pattern here?
      
      
      # Visually Fitting our "best fit" line
      coefs <- model1$coefficients
      coefs
      plot(trees$Girth,trees$Volume,pch=16,col="grey50",cex=1.5) 
      abline(a = coefs[1],b = coefs[2],col="red",lwd=3) # fitted line
      
      
      
      # Adding Control variables
      
      model2 <- lm(Volume ~ Girth + Height, data=trees)
      
      summary(model2)
      
      
      # Adding Interaction Terms
      
      model3 <- lm(Volume ~ Girth*Height, data=trees)
      
      summary(model3)
      
      # Note that all lower orders are included in the model. 
      
      
      
# Generalized Linear Models ----------------------------------------
      
      # Broadly speaking, linear regression requires that your dependent 
      # variable be continuous. However, often when studying social phenomena 
      # or when collecting data from surveys, a granular interval variable
      # isn't available. 
      
      # There are many forms of "generalize linear models" which still models 
      # the relationship between x and y in a linear fashion, but then
      # translates that linearity into a "probability space". 
      
      # What is the probability of voting? What is the probability of choosing
      # option 3 on item 2 in the survey over option 2? What is the 
      # probability of 40 people arriving to this workshop? These are the 
      # kinds of questions (and data) generalized linear models are situated
      # to handle. 
      
      
      # Data:
            # The dataset is a cleaned up and modified version of the 1996 American
            # National Election studies as used in Hainmueller and Hiscox (2006). This
            # study investigated the determinants of individuals’ support for free trade
            # or protectionist policies. The outcome variable is a dummy 
            # protectionist—coded as 1 if a respondent expressed a preference for more 
            # protectionist policies, and coded as 0 if a respondent favored free 
            # trade.
                  
            # The explanatory variables:
            
            # - age: the incumbent’s age.
            # - female: a binary indicator for female respondents.
            # - TUmember: a binary indicator for trade union members.
            # - partyid: the respondent’s party identification: coded from 0 “strong
            # Democrat” to 6 “strong Republican”.
            # - ideology: the respondent’s ideology: coded 0 if conservative, 1 if
            # moderate, and 2 if liberal.
            # - schooling: years of full-time education completed.
            
      head(protect)
      
      # Distribution
      par(mfrow=c(1,2))
      hist(protect$schooling,col="darkslategray3",border="white",main="Schooling")
      hist(protect$protectionist,col="darkgrey",border="white",main="Protectionist Views")
      dev.off()
      
      # Bivariate relationship
      qplot(schooling,protectionist,data = protect)
      
      
      # Run the model
      model4 <- glm(protectionist~age+female+TUmember+partyid+ideology+schooling,
                    data=protect,family=binomial(link="logit"))
      summary(model4) 
      
      
      
      # Examining the predicted probabilities and marginal effects
      
      install.packages("margins")
      require(margins)
      
      
      m = margins(model4,data=protect,type = "response") # ave. marginal effect
      plot(m) 
      
      # Plot Predicted Probabilities 
      cplot(model4, x = "schooling", se.type = "shade",what="prediction",lwd=2)
      
      # Plot the marginal effects
      cplot(model4, x = "schooling", se.type = "shade",what="effect",lwd=2)
      
      
      # Or take the data and do your own thing with it...
      tmp <- cplot(model4, x = "schooling", what = "prediction", draw = FALSE)
      ggplot(tmp, aes(x = xvals, y = yvals)) + 
        geom_point(cex=3) +
        geom_line(lwd = 1) + 
        geom_ribbon(aes(ymin=lower, ymax=upper), alpha=0.2)+ 
        theme_bw() + labs(x="Years of Schooling",y="Probability of Supporting\nProtectionist Policies")
      
      
      
# Scaling --------------------------------------------------------------- 
      
      
      # Survey Response data: here we have four items (all ordinal) that get at
      # the same underlying concept
      
        head(responses)
        
        # We want to extract the underlying Dimensionality (that latent score) 
        # from these "error-laden" indicators.
      

    # Assessing Dimensionality --------------------------------
      
        # Standardizing the Scale
        resp_std <- scale(responses[,-1])
        
        # Correlation Plot
        require(corrplot)
        corrplot(cor(resp_std))
        
        # Singular Value Decomposition
        decomp <- svd(resp_std)
        plot(decomp$d,type="b")
        
        # Eigen Decomposition
        eigndecomp <- eigen(cor(resp_std))
        
        eigndecomp$values
        
        plot(1:4,eigndecomp$values,type="both")
      
      
    # Summated Rating Model -----------------------------------
      
        srm = rowMeans(resp_std)
        hist(srm) # latent score
        
        # Principal Component Analysis ----------------------------
        
        pca = princomp(resp_std)
        
        # Scree plot
        screeplot(pca,type = "line")
        
        pca_scale <- pca$scores[,1]
        hist(pca_scale)
        
      
    # Factor Analysis -----------------------------------------
      
        fac_anal = factanal(resp_std,factors = 1)
        fac_anal$loadings
        fac_anal$uniquenesses
        fac_anal$correlation
        
        # but no score...
        
        
        require(psych)
        fac_anal2 = fa(resp_std)
        fac_scale <- as.numeric(fac_anal2$scores)
        
        
    # Comparing the scales -------------------
        
        cor(cbind(srm,pca_scale,fac_scale))
        
        x = data.frame(type="srm",score=srm)
        x1 = data.frame(type="pca",score=pca_scale)
        x2 = data.frame(type="fa",score=fac_scale)
        X <- rbind(x,x1)
        X <- rbind(X,x2)
        
        ggplot(data=X,aes(x=score,fill=type)) + 
          geom_density(color="white",alpha=.3) + 
          theme_minimal()
