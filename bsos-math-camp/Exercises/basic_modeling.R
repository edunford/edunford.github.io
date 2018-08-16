# **********************************************
# A Crash Course in Statistical Programming in R
# Eric Dunford | edunford@umd.edu | GVPT
# **********************************************
# Applied Example 4: A Brief Dabbling with Modeling in R
# BSOS 2018 Math Camp
# **********************************************

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


