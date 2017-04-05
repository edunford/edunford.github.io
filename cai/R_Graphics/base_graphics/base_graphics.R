####################################################
### An Introduction to Statistical Programming in R
### DAY 3 (April 5, 2016) 
### Eric Dunford (edunford@umd.edu)
####################################################
############      GRAPHICS       ###################
####################################################
############### Base Graphics ######################
####################################################

          setwd("") # set working directory to where your data is located
          load("base_plots.Rdata")
          
          
          head(fake)
          
# Histograms ----------------------------------------

          hist(fake$outcome)
          
          
          ?hist # look at the documentation
          
          
        # Breaks (breaks) -----
          
          hist(fake$outcome,breaks = 10)
          
          hist(fake$outcome,breaks = 1000)
          
          hist(fake$outcome,breaks = 100)
          
          
        # color (col) ------
          
          hist(fake$outcome,breaks = 100,
               col="blue") # takes *some* names
          
          hist(fake$outcome,breaks = 100,
               col="black") 
          
          hist(fake$outcome,breaks = 100,
               col="#265299") # takes hex colors (type "hex color" in google)
          
          hist(fake$outcome,breaks = 100,
               col="#ffae3d") # takes hex colors
          
          
        # border colors around the bins (border) -------
          
          hist(fake$outcome,breaks = 100,
               col="#ffae3d",border="green")
          
          hist(fake$outcome,breaks = 100,
               col="#ffae3d",border="#265299")
          
          hist(fake$outcome,breaks = 100,
               col="#ffae3d",border="white")
          
          
        # labels --------
            
          # title ==>  "main="
          # x label ==>  "xlab="
          # y label ==>  "ylab="
          
          hist(fake$outcome,breaks = 100,
               col="#ffae3d",border="white",
               main = "",xlab="",ylab="") # no title or labels
          
          
          hist(fake$outcome,breaks = 100,
               col="#ffae3d",border="white",
               main = "Important Histogram",
               xlab="Outcome Variable",ylab="Freq.")
          
          
        # Freq/Density --------
          
          hist(fake$outcome,breaks = 100,
               col="#ffae3d",border="white",
               main = "Important Histogram",
               xlab="Outcome Variable",
               freq=F) 
          
          hist(fake$outcome,breaks = 100,
               col="#ffae3d",border="white",
               main = "Important Histogram",
               xlab="Outcome Variable",
               freq=T) # default 
          
          
          
        # Overlaying Histograms
          
          hist(fake$outcome,breaks = 100,
               col="#ffae3d",border="white",
               main = "Important Histogram",
               xlab="")
          
          hist(fake$predictor,breaks=50,
               col="black",
               add=T) # add
          
          
        # Arranging Multiple Plots
          
          par(mfrow=c(2,1))
          hist(fake$outcome,breaks = 100,
               col="#ffae3d",border="white")
          
          hist(fake$predictor,breaks=50,
               col="lightblue",border="white") 
          
          
          par(mfrow=c(1,3))
          hist(fake$outcome,breaks = 100,
               col="#ffae3d",border="white")
          
          hist(fake$predictor,breaks=50,
               col="lightblue",border="white") 
          
          hist(fake$control,breaks=50,
               col="wheat",border="white") 
          
          
          # the setting stick around after we're done so we can
          
          # (a) change back to original settings.
          par(mfrow=c(1,1)) 
          
          # (b) turn off the plotting device
          dev.off()
          
          # (c) click the broom in R Studio
          
          
          
          
# Scatter Plots  --------------------------------
          
          plot(x=fake$predictor,y=fake$outcome)
          plot(x=fake$control,y=fake$outcome)
          
          
          # Like hist(), for plot() you just have to know what is going on
          # underneith the hood.
          ?plot
          
                # pch = point type
                # cex = point size
                # col = point/line color
                # lty = line type
                # lwd = line width
                # xlab = label on the x axis
                # ylab = label on the y axis
                # main = plot title
          
          
      # point types (pch) 
      # (http://www.sthda.com/english/wiki/r-plot-pch-symbols-the-different-point-shapes-available-in-r)
          
          plot(fake$predictor,fake$outcome,pch=0)
          plot(fake$predictor,fake$outcome,pch=2)
          plot(fake$predictor,fake$outcome,pch=14)
          plot(fake$predictor,fake$outcome,pch=16)
          plot(fake$predictor,fake$outcome,pch="A")
          plot(fake$predictor,fake$outcome,pch=18)
        
          
      # point size (cex) 
          
          plot(fake$predictor,fake$outcome,pch=18,cex=.5)
          plot(fake$predictor,fake$outcome,pch=18,cex=3)
          plot(fake$predictor,fake$outcome,pch=18,cex=1.5)
          
          
      # color (col)
          
          plot(fake$predictor,fake$outcome,pch=18,cex=1.5,
               col="#265299")
          
          
      # lines (type)
          
          plot(fake$predictor,fake$outcome,pch=18,cex=1.5,
               col="#265299",type="l") # lines
          
          plot(fake$predictor,fake$outcome,pch=18,cex=1.5,
               col="#265299",type="p") # points (default)
          
          plot(fake$predictor,fake$outcome,pch=18,cex=1.5,
               col="#265299",type="b") # both 
          
          
      # line width (lwd)
          
          plot(fake$predictor,fake$outcome,pch=18,cex=1.5,
               col="#265299",type="b",lwd=.5) 
          
          plot(fake$predictor,fake$outcome,pch=18,cex=1.5,
               col="#265299",type="b",lwd=3) 
          
          
      # Labels (main, xlab, ylab)
          plot(fake$predictor,fake$outcome,pch=18,cex=1.5,
               col="#265299",main="Scatter Plot",
               ylab="Outcome",xlab="Predictor")
          
          
      # axis ranges (xlim, ylim)
          
          plot(fake$predictor,fake$outcome,pch=18,cex=1.5,
               col="#265299",main="Scatter Plot",
               ylab="Outcome",xlab="Predictor",
               xlim=c(-5,5))
          
          
          plot(fake$predictor,fake$outcome,pch=18,cex=1.5,
               col="#265299",main="Scatter Plot",
               ylab="Outcome",xlab="Predictor",
               xlim=c(-5,5),
               ylim=c(-10,10))
          
      
          
          
      # Grouping Data
          
          # color by group
          plot(fake$predictor,fake$outcome,
               pch=18,
               col=fake$group)
          
          # size by group
          plot(fake$predictor,fake$outcome,
               pch=18,
               col=fake$group,
               cex=as.numeric(fake$group))
          
          # point type by group
          plot(fake$predictor,fake$outcome,
               col="#265299",
               pch=as.numeric(fake$group))
          
          
          
          
      # Overlaying points
          
          
          # Subset data
          fake_sub <- subset(fake,outcome>=0 & predictor>=0)
          
          
          plot(fake$predictor,fake$outcome,pch=18,cex=1.5,
               col="#265299",main="Scatter Plot",
               ylab="Outcome",xlab="Predictor",
               xlim=c(-5,5),
               ylim=c(-10,10))
          
          points(fake_sub$predictor,fake_sub$outcome,
                 col="red",pch=18,cex=2)
          
          abline(h=0,v=0,lty=2,lwd=2)
          
          text(x=3,y=5,label="positive",font=2)
      
          
          
              
    # Legends ------------------------
          
          # Like an overlay, legends
          
          plot(fake$predictor,fake$outcome,pch=18,cex=1.5,
               col="#265299",main="Scatter Plot",
               ylab="Outcome",xlab="Predictor",
               xlim=c(-5,5),
               ylim=c(-10,10))
          legend("topright", legend = "point",
                 col = "#265299",pch=18)
          
          # orientation
          
                # center
                # left
                # right
                # top
                # topright
                # topleft
                # bottom
                # bottomright
                # bottomleft
                
              
          legend("left", legend = "point",
                 col = "#265299",pch=18)
          legend("bottom", legend = "point",
                 col = "#265299",pch=18)
          legend(x=-2,y=-1, legend = "point",
                 col = "#265299",pch=18)
          
          
          
      plot(fake$predictor,fake$outcome,pch=18,cex=1.5,
           col=fake$group,main="Scatter Plot",
           ylab="Outcome",xlab="Predictor",
           xlim=c(-5,5),
           ylim=c(-10,10))
      legend("topright", legend = levels(fake$group),
             col = c(1:3),pch=18,box.col ="white",cex=1.5)
      
          
      
    # Quick Scatters to View Relationships -----------------
          
          pairs(fake)
          
          pairs(fake,col=fake$group)
          
        
# Bar Plots ----------------------------------
          
          table(fake$group)
          
          barplot(table(fake$group))
          
          # All the same features persist
          barplot(table(fake$group),
                  col=c("lightblue","blue","darkblue"),
                  border="white")
          
          
          # change orientation
          barplot(table(fake$group),
                  col=c("lightblue","blue","darkblue"),
                  border="white",horiz=T)
          
          
          
          # change category names
          barplot(table(fake$group),names.arg = c("a","b","c"),
                  col=c("lightblue","blue","darkblue"),
                  border="white",horiz=T)
          

# Box Plots -----------------------------------------
          
          boxplot(fake$predictor~fake$group)
          
          
# Pie Charts ----------------------------------------
          
          pie(table(fake$group))
          
          pie(table(fake$group),clockwise = T)
          
          pie(table(fake$group),init.angle = 123)
          pie(table(fake$group),init.angle = -75)
          
          
          pie(table(fake$group),clockwise = T,
              col = c("lightblue","steelblue","darkblue"),
              border="white",labels = c("A","B","C"),lty = 5,
              main = "Groupings")
          
          
# Density Plots ----------------------------------------
          
          d <- density(fake$outcome)
          d
          
          plot(d)
          
          plot(d,col="orange",lwd=4)
          
          # overlay a polygon (to fill in the space below)
          polygon(d,col="lightgrey")
          
          
          # overlay two density plots
          d1 <- density(fake$outcome)
          d2 <- density(fake$predictor)
          d3 <- density(fake$control)
          
          plot(d1,col="orange",lwd=3,ylim=c(0,1),lty="solid") 
          lines(d2,col="green",lwd=3,lty="dashed") 
          lines(d3,col="pink",lwd=3,lty="dotted")
        


# Saving plots
          
          # Extablish the path and format
          pdf(file = "~/Desktop/my_plot.pdf",width=4,height=5)
          
          # Render plot
          plot(fake$predictor,fake$outcome,pch=18,cex=1.5,
               col="#265299",main="Scatter Plot",
               ylab="Outcome",xlab="Predictor",
               xlim=c(-5,5),
               ylim=c(-10,10))
          
          points(fake_sub$predictor,fake_sub$outcome,
                 col="red",pch=18,cex=2)
          
          abline(h=0,v=0,lty=2,lwd=2)
          
          text(x=3,y=5,label="positive",font=2)
          
          # Turn off device
          dev.off() 
          
          
          
          # Many file types
              # png()
              # jpeg()
              # tiff()
          
          
          # Work with illustrator?
          cairo_pdf(file = "~/Desktop/my_plot.pdf",width=4,height=5)
          plot(fake$predictor,fake$outcome,pch=18,cex=1.5,
               col="#265299",main="Scatter Plot",
               ylab="Outcome",xlab="Predictor",
               xlim=c(-5,5),
               ylim=c(-10,10))
          dev.off() 
          
          
          
          
          
          
          
# Practice -----------------------------------------------------
          
      # Bed Bugs Complaints in New York City --- The following data provides a 
      # comprehensive of beg bug complaints in the city of New York by month 
      # from May 2014 to Jan. 2017. The data breaks each type of infestation up
      # into an individual column.
          
      head(bed_bugs)
          
          
      # (1) Plot the total number of bed bug infestations by month using "type='b'"
          
          
          
      # (2) Plot a histogram of the total number of apartment infestations;
      # change the bin width, color, and labels.
          
          
          
      # (3) Plot lobby, basement, laundry, and other infestations as
      # lines; make sure each has a new color.

          
          
      # (4) create a legend for #3
      
          
              
      # (5) create a title and label axises for #4
          
          
          
      # (6) save #5 as cairo_pdf() on desktop
    
          
          