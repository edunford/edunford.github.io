# An Introduction to Statistical Programming in R
# Applied Example 2: Basic Modeling
# Session 2 - October 12, 2017
# Eric Dunford (edunford@umd.edu)

require(tidyverse)

              
# ---------------------------- Diagnostics and Linear Models -----------------------------------

             
          # Simulating the Data Generating Process
              
                  set.seed(235) # For replication of random vars
                  
                  x <- rnorm(100,10,.4) # random variable
                  e <- rnorm(100,0,1) # assumption-following error
                  
                  y <-  1 + 2*x + e # y is a linear function of x + error
                  
                  
                  data = data.frame(y,x)
                  head(data)
                  summary(data)
                  
                  # visualize
                  ggplot(data,aes(x,y)) + 
                    geom_point() + 
                    geom_smooth(method="loess")
              
                  
####                  
####                  *** Initial Diagnostics ***
####                  
                  
                  # Correlation
                  cor(y,x)
                  
                  # Correlation Tests
                  cor.test(y,x,method = "pearson")
                  cor.test(y,x,method = "kendal")
                  
                  # Normal Distribution Test (Shapiro)
                  shapiro.test(y) # NULL == "normally distributed"
                  shapiro.test(x) # NULL == "normally distributed"
                  
                  # Difference in means (t-test)
                  t.test(y,x) # NULL == "no meaningful difference in means"
                  
                  # Difference Variance Test
                  var.test(y,x)  # NULL == "no meaningful difference in var"
                  
                  # Differences in distributions (Kolmogorov And Smirnov)
                  ks.test(y,x) # NULL == "drawn from the same distribution"
                  
                  # Other useful test:
                  # chisq.test() # for categorical variables
                  # wilcox.test() # a t-test for two variables that aren't normal
                  
              
                  
####                  
####                       *** Linear Model ***
####                  
                  
                  
                  
              # The modeling framework in R straightforward:
                  # takes a formula (any with a tilde, e.g. "y~x")
                  # takes data
                  
                  
              model1 = lm(y~x,data=data)
              
              # The model output is only so informative
              model1
              
              # so use "summary" function
              summary(model1) 
                  # Significant, and we recover the true coefficient. 
              
              
              
              # Model Diagnostics, which offer
                        # (1) linearity test,
                        # (2) normality assump. test, 
                        # (3) equal variance test (homosk.),
                        # (4) locating outliers (influential cases)
              plot(model1)
                  
              
                        
            # Drawing out useful values
                        
                  m1.sum = summary(model1)
                        
                  # Summary and model output contain different info
                  str(model1)
                  str(m1.sum)
                  
                        
                  # Coefficients
                  model1$coefficients
                  m1.sum$coefficients
                    
                      # Specifically,
                      m1.sum$coefficients[,4] # P-values
                      m1.sum$coefficients[,3] # T-Stats
                      m1.sum$coefficients[,2] # Std. Err
                      m1.sum$coefficients[,1] # coefs
                  
                        
                  
                  # Original data
                  model.matrix(model1) # X matrix
                  model1$model # Original Data
                      
                  
                  
                  # Prediction (Y-hats)
                  model1$fitted.values
                  yhat = predict(model1)
                  qplot(x,yhat)
                  
                        # OR Build it yourself!
                        X  = model.matrix(model1) 
                        B = model1$coefficients
                        yhat2 = X%*%B
                        qplot(yhat,yhat2)
                        
                        
                  
                  
                  # Residuals
                  res1 = m1.sum$residuals
                  res2 = data$y - yhat
                  identical(round(res1,2),round(res2,2))
                  qplot(res1,res2)
                  
                  
                  
                  
                  # Variance-Covariance Matrix
                  vcov(m1.sum)
                  m1.sum$cov.unscaled
                  
                  
                  # Stats
                  m1.sum$fstatistic
                  m1.sum$r.squared
                  # Goodness of Fit Stats: the lower the better
                  AIC(model1) 
                  BIC(model1) 
                  
       
                             
####             
####                *** HETEROSKEDASTICITY ***
####       
                  
                          
            # Some Useful Packages for dealing with heteroskedasticity standard errors
            install.packages("sandwich")
            install.packages("lmtest")
            install.packages("miceadds")
            require(sandwich)
            require(lmtest)
            require(miceadds) # for clustered standard errors lm.cluster/glm.cluster

           
            summary(model1)
            
            vcov(model1) # Standard Errors
            vcovHC(model1) # White-Adjust Std. Errors
            
            
            # "coeftest()" from the lmtest package presents estimates as we're use to 
            # reading them
            
            coeftest(model1)
            
            # Here we can insert the adjusted covariance matrix to get robust standard errors
            coeftest(model1,vcov. = vcovHC(model1)) 
            
###
###                 *** MODEL PRESENTATION ***
###
            
            install.packages('stargazer')
            require(stargazer)
            # To produce publishable quality tables in latex
            
            stargazer(model1) # Latex
            
            stargazer(model1,type='text') 
            
            stargazer(model1,type='html') 
            
            # Customize..
            stargazer(model1,type='text',
                      title="Main Model",
                      dep.var.caption = "Main DV",
                      se = list( diag(vcovHC(model1))),
                      notes="Robust Standard Errors")
            
            # Descriptives
            stargazer(data,type='latex')
                
                
                
####                
####                *** OUT OF SAMPLE Predictions ***
####
                
          # Out of sample predictions have a simple premise, can we use some of 
          # the data to fit our model, and then use the other portion of the 
          # data to see how well that fit performs. This is a really useful way
          # to test model fit.
          
          # Here let's create a "training" and "test" dataset using the
          # IRIS data.
          
          data = iris 
          head(data)
          
          set.seed(5556)
          train.loc = sample(1:nrow(data),.8*nrow(data)) # Let's extract 80% of the data to train
          train.set = data[train.loc,]
          test.set = data[-train.loc,]
          
          mod1 <- lm(Petal.Length ~ Sepal.Length + Sepal.Width, data=train.set)
          summary(mod1)
          
          # Using the model, predict the values for the test set
          preds = predict(mod1,test.set)
          
          # Let's compare the "actual" the values in the test set to the
          # predicted values
          compare = data.frame(actual=test.set$Petal.Length,prediction=preds)    
          cor(compare) # Highly correlated! (.95) Which is a good sign of model fit
          
          # Minimum-Maximum Accuracy
          mean(apply(compare,1,min)/apply(compare,1,max))
          
          # Absolute Error Deviation
          mean((abs(compare$prediction-compare$actual))/compare$actual)
          
          # Squared Error Deviation
          mean(((compare$prediction-compare$actual)^2)/compare$actual)
          
          
####          
####            *** K-Fold Validation ***
####       
          
          # The logic behind a K - fold validation is simple: break your data up
          # into K number of random "portions" are drawn. Specifically, Each
          # fold is removed, in turn, while the remaining data is used to re-fit
          # the regression model and to predict at the deleted observations. If
          # the prediction accuracy doesn't change a whole lot, then we have a
          # good model.
          
          # Specifically, we want to make sure that the prediction sample
          # doesn't vary to much, and that the fits don't differ that much
          # either.
          
          install.packages("DAAG")
          require(DAAG)
          
          val_results = suppressWarnings(cv.lm(data=data,form.lm=Petal.Length ~ Sepal.Length + Sepal.Width,
                                               m=5,printit=FALSE))   
          
          str(val_results)
          attr(val_results,"ms") # Mean Squared errors (we want these to be small)
                  
                  
        
          # So, let's compare some fits!
          form.full = Petal.Length ~ Sepal.Length + Sepal.Width  # FUll Model
          form.simple = Petal.Length ~ Sepal.Length # Simple Model
          
          # 5 folds
          results_full = suppressWarnings(cv.lm(data=data,form.lm=form.full,m=5,printit=FALSE))   
          results_simple = suppressWarnings(cv.lm(data=data,form.lm=form.simple,m=5,printit=FALSE))   
          
          attr(results_full,"ms")
          attr(results_simple,"ms")
                  
          # Clearly the full model performs better! So we have good evidence
          # that including Sepal.Width brings something to the table!
          

          
          
          
          
# ----------------------- Generalized Linear Models -----------------------------------         

          
####            
#### Binary Outcomes (Bernoulli-Distributions)
####
              
          
          # First, let's again simulate the data generating process. 
          
                set.seed(1988)
                x1 <- rnorm(500,.1,1) 
                x2 <- round(runif(500,0,3))
                # e <- rnorm(500,0,1) 
                z <- .2 + -.8*x1 + .2*x2 # Latent Linear combination
                pr = exp(z)/(exp(z) + 1) # Logit-Link
                # pr = pnorm(z) # Gausian-Link
                y <- rbinom(length(pr),1,pr) # Fit to a binomial distribution
                
                data = data.frame(y,x1,x2)
            
               
                
                # The probability of observing y == 1 and y == 0
                mean(pr); 1 - mean(pr)
                prop.table(table(y))
                
                data = data.frame(y,x1,x2)
                
                qplot(x1,y) + geom_smooth(se = F) + theme_bw()
                qplot(x2,y) + geom_smooth(se = F) + theme_bw()
                
                
                  
          # As usual, we need to decide on our link function of choice. I'll
          # proceed using the logit, but probit is quite simple to implement. 
          
              # Logit Link Function
              model1 = glm(y~x1+x2,data=data,family=binomial(link="logit"))
              summary(model1)     
              
              # Probit Link Function
              model2 = glm(y~x1+x2,data=data,family=binomial(link="probit"))
              summary(model2)
          
          
          # Extraction of meaningful values follows the same logic as the linear model
          
          m1.sum = summary(model1)
          
          # Coefficients
          model1$coefficients
          coefficients(model1)
          m1.sum$coefficients
          
          # Data 
          model1$data
          
          # Variance-Covariance Matrix
          m1.sum$cov.scaled
          vcov(model1)
          
          # Predictions
          mean(predict(model1,type="response"))
          1-mean(predict(model1,type="response"))
 
    
              
                       
####
####        *** Marginal Effects/Predicted Probabilities ***
####              
          
          # R is getting better about predicted probabilities and marginal 
          # effects. Specifically, here is a package that will calculate 
          # marginal effects for a logit model while simultaneously calculating
          # robust or clustered standard errors. 
          
          # install.packages("mfx")
          require(mfx)
              
          me = logitmfx(formula=y~x1+x2, data=data,atmean = F,robust = T)
          me
          # when "atmean" == F, we retrieve the average partial effect (observed
          # value); robust == T (White/robust standard errors); clustervar1 ==
          # "var.name" (clustered) standard errors
          
    
                
####          
####            "MARGINS" plots in R 
####         
          
          
          install.packages("devtools") # To install developing code NOT on cran
          devtools::install_github("leeper/margins")
          require(margins)
          
          m = margins(model1,data=data)
          plot(m)
          summary(m)
          
          # Plot Predicted Probabilities 
          cplot(model1, x = "x1", se.type = "shade",what="prediction")
          cplot(model1, x = "x2", se.type = "shade",what="prediction")
          
          # Plot Marginal Effects
          cplot(model1, x = "x1", se.type = "shade",what="effect",type="response",
                col="darkgrey",lwd=4,se.fill ="#97C3FB")
          cplot(model1, x= "x2", se.type = "shade",what="effect",type="response",
                col="darkgrey",lwd=4,se.fill ="#97C3FB",n=3)
          cplot(model1, x= "x1",dx = "x2", se.type = "shade",what="effect",
                col="darkgrey",lwd=4,se.fill ="#97C3FB",scatter=T)
          
          # 3D plots of the marginal effects?
          persp(model1,xvar="x1",yvar="y")
          persp(model1,xvar="x2",yvar="y")
          
          # Or a density image 
          image(model1,xvar="x1",yvar="y")
          
          
          # OR take the data and do your own thing with it in ggplot
          tmp <- cplot(model1, x = "x1", what = "effect", draw = FALSE)
          ggplot(tmp, aes(x = xvals, y = yvals)) + 
            geom_line(lwd = 2) + 
            geom_ribbon(aes(ymin=lower, ymax=upper), alpha=0.2)+ 
            theme_bw() + labs(x="Predictor",y="Marginal Effect on Y")
         
              
####
####                      **** OTHER GENERALIZATIONS ****
####              
          
          ###        
          ###  POISSON Distributed data 
          ###    
              
              # Simulate DGP
              set.seed(1998)
              x <- runif(100,0,5)
              lambda = exp(1 + .3*x)
              y <- rpois(100,lambda)
              count = data.frame(y,x)
              
              qplot(x,y,data=data)
              
              cmod = glm(formula = y ~ x,data=count,family = poisson(link = log))
              summary(cmod)
              
              # Predicted Probs and Marg. Effects.
              cplot(cmod,x="x",what="effect")
              cplot(cmod,x="x",what="prediction")
              
              
          ###
          ### Ordered Logit/Probit
          ###
              
              head(mtcars) # head data
              
              # The Ordered Logistic/Probit function is in the "MASS" package
              require(MASS)
              
              DF = mtcars %>% dplyr::select(gear,cyl)
              DF$gear = as.numeric(as.factor(DF$gear))-1
              
              # predict the number of gears using the number of cylanders
              omod = polr(factor(gear)~cyl,data=DF,method = "logistic")
              summary(omod)
          
              
              
          ###
          ### Multinomial Logit
          ### 
              
              # Use the "nnet" package
              # install.packages("nnet")
              require(nnet)
              
              # Back to the diamonds data. Let's see if we can't predict cut quality using carat. 
              head(diamonds)
              
              mmod = multinom(cut~carat,data=diamonds)
              summary(mmod)
              
          ###    
          ### Hierarchical Models
          ### 
              
              install.packages("lme4")
              install.packages("arm")
              require(lme4)
              require(arm)
              
              ?sleepstudy # Reaction time given sleep deprivation
              df = sleepstudy
              
              ggplot(df,aes(Days,Reaction)) +
                geom_point()
              
              h.model <- lmer(Reaction ~ Days + (1 + Days | Subject), df)
              
              summary(h.model) # General Summary
              
              # Extracting fixed and random effects
              fixef(h.model)
              se.fixef(h.model)
              
              ranef(h.model)
              se.ranef(h.model)
              
              # Simple Plot of the effects
              ran = ranef(h.model)[[1]]
              fixed = fixef(h.model)
             
               # Fixed effect reported as deviations
              ran[,1] = (ran[,1] + fixed[1])
              ran[,2] = (ran[,2] + fixed[2])
              
              # Visualize
              ggplot(df,aes(Days,Reaction)) +
                geom_point() +
                geom_abline(intercept = ran[,1],slope=ran[,2],color="red") +
                geom_abline(intercept = fixed[1],slope=fixed[2],color="blue",lwd=2) 
                
              # For Generalized linear models use the function glmer()

