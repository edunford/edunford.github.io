####################################################
### An Introduction to Statistical Programming in R
### DAY 3 (April 5, 2016) 
### Eric Dunford (edunford@umd.edu)
####################################################
############      GRAPHICS       ###################
####################################################
############# GGPLOT Graphics ######################
####################################################

# install.packages("ggplot2")
# install.packages("gridExtra")
require(ggplot2)
require(gridExtra)
              


            # We'll use data that is store in the ggplot package. The data is
            # big, so we'll sample from it.
            data = diamonds %>% sample_n(1000)
            
            head(data) # Data on diamonds
            dim(data)
            
            
            # ggplot2 is a versatile and robust graphics language in R. With it,
            # we are able to make some impressive graphic manipulations. It 
            # operates as a graphics "language" where the additive functions do 
            # what it sounds like they should do (the package was made by the
            # same guy who designed the dplyr package.)
              
            # Two basic graphing approaches exist:
            
                # ggplot() # Which we build on
                # qplot()  # Which can serve as a "quick plot"
            
            
####            
####                      ****** qplot() ******
####
            
            # qplot() adapts instantly to the variable 
            
            # Bar Plots
            qplot(x=cut,data=data)
            
            # Histograms
            qplot(x=depth,data=data)
            
            # Scatter
            qplot(y=price,x=carat,data=data)
            
            # Box plots  (geom == "the style of plot I want")
            qplot(factor(cut), price, data = data, geom = "boxplot")
            
            # Jitter Plots
            qplot(factor(cut), price, data = data, geom = "jitter")
            
            # Violin plots
            qplot(factor(cut),price, data = data, geom = "violin")
            
            # Etc. 
            
            # There are many options contained within. Feel free to explore!
            ?qplot
            
            
            # For example, here we have color set by the cut, the size of the
            # points set by the depth. 
            qplot(y=price,x=carat,color=cut,size=depth,data=data)
            
                    # This breaks the groups up along a number of dimensions
            
            
            # We can also break groups up quickly into seperate plots with facets
            qplot(y=price,x=carat,facets=~cut,data=data)
            
            
            # Also note that ggplots can be stored as objects
            plot1 <- qplot(y=price,x=carat,data=data)
            plot1
    
                    
####
####                        **** ggplot() ****
####            
            
            # The more versatile way to use ggplot is to "build" with it. 
            
            # ggplot() takes two fundamental arguments: data and aesthetics "aes()"
            # (which are values contained in the data) 
            
            ggplot(data,aes(x=carat,y=price)) # basic plotting window
            
            # we then "add" the functional value that we want to the open graph
            
            ggplot(data,aes(x=carat,y=price)) + geom_point()
            
            
            
            # Everything can then be added on including unique "themes" that
            # alter the aesthetics of the graphic
            
            ggplot(data,aes(x=carat,y=price)) + geom_point() + theme_bw()
            ggplot(data,aes(x=carat,y=price)) + geom_point() + theme_classic()
            ggplot(data,aes(x=carat,y=price)) + geom_point() + theme_dark()
            ggplot(data,aes(x=carat,y=price)) + geom_point() + theme_light()
            ggplot(data,aes(x=carat,y=price)) + geom_point() + theme_linedraw()
            ggplot(data,aes(x=carat,y=price)) + geom_point() + theme_minimal()
            ggplot(data,aes(x=carat,y=price)) + geom_point() + theme_void()
            # etc. .... 
            
                # any additive function also works with "qplot()"
                qplot(x=carat,data=data) + theme_bw()
            
          
            
            # Labeling takes on the same form
            ggplot(data,aes(x=carat,y=price)) + geom_point() + theme_bw() + 
              labs(x = "Carats",y = "Money I'll Never Have",title="My Diamond Plot")


            # OR
            ggplot(data,aes(x=carat,y=price)) + geom_point() + theme_bw() + 
            xlab("Carats") + ylab("Money I'll Never Have") + ggtitle("My Diamond Plot")
            
            # Note that since we can save a graphic as an object, we can easily
            # build off it by using the same additive framework.
            p <- ggplot(data,aes(x=carat,y=price)) + geom_point() + theme_bw()
            p
            p <- p + labs(x = "Carats",y = "Money I'll Never Have",title="My Diamond Plot")
            p
            
            
            
            # We can have tight control over the coloring of the graphic,
            # especially when we "group" the data
            
            ggplot(data,aes(x=carat,y=price,group=cut,color=cut)) + geom_point() + theme_bw() 
            
            p2 <- ggplot(data,aes(x=carat,y=price,group=cut,color=cut)) + geom_point() + theme_bw() +
              scale_colour_manual(name='', values=c('Fair'='grey', 'Good'='red', 
                                                          'Very Good'='blue', 'Premium'='yellow', 
                                                          'Ideal'='black'))
            p2
            
            
            # We can also quickly break the data up via facet_grid() and facet_wrap()
            p2 + facet_grid(facets = ~cut)
            
            p2 + facet_wrap(facets = ~cut,nrow = 3,ncol=2)
           
            
            
            # As per usual, we can easily control the "dimensions" of the plot
            p + xlim(0,5) + ylim(0,50e3)
            
            # Flip the coordinate planes
            p + coord_flip() 
            
            
            # In addition there are a lot of useful functions that map onto
            # existing graphics
            p + geom_smooth() # Lowess Reg Line with bootstrapped CIs (more on this tomorrow)
            p + geom_hex()
            p + geom_hline(yintercept = 10e3,color="red",lwd=4)
            
            
            
      # The "theme" function really lets you alter any micro details. 
            
            # Angling the axis values
            p + theme(axis.text.x=element_text(angle=45), axis.text.y=element_text(angle=90))
            
            # Altering the back panel 
            p + theme(panel.background = element_rect(fill = 'steelblue'),
                      panel.grid.major = element_line(colour = "#EB7B1D", size=3),
                      panel.grid.minor = element_line(colour = "blue", size=1))
            
            # Reseting the margins and the backdrop
            p + theme(plot.background=element_rect(fill="lightgrey"), 
                      plot.margin = unit(c(2, 4, 1, 3), "cm")) 
            
            # Dropping or repositioning legends
            p2
            p2 + theme(legend.position="none")
            p2 + theme(legend.position="bottom")
            
            
            # All in all, if you can think it, you can probably change it. This makes the 
            
            p2 + theme_bw() + theme(panel.border = element_blank(),
                                    axis.line.y = element_line(colour = "black"),
                                    axis.line.x = element_line(colour = "black"),
                                    panel.grid.major = element_blank(),
                                    panel.grid.minor = element_blank(),
                                    axis.ticks.length=unit(-0.20, "cm"), 
                                    axis.text.x = element_text(margin=unit(c(0.5,0.5,0.5,0.5), "cm")), 
                                    axis.text.y = element_text(margin=unit(c(0.5,0.5,0.5,0.5), "cm")),
                                    plot.margin = unit(c(1,1,1,1), "cm"),
                                    axis.text=element_text(family = "serif"),
                                    axis.title=element_text(family = "serif"),
                                    legend.position="bottom",
                                    legend.key = element_blank(),
                                    legend.text = element_text(family = "serif")) 
            
            
####
####                      **** Griding Plots **** 
####        
            
            # With the gridExtra package, we can easily stack plots.
            head(data)
            p = qplot(factor(cut),carat,data=data,geom="violin") + theme_bw() + 
              geom_jitter(width = .2,col="darkgrey")
            p2 = ggplot(data,aes(x=carat,fill=cut)) + geom_bar() + theme_bw() + 
              theme(legend.position="none")
            p3 = qplot(carat,price,data=data) + theme_bw() + geom_smooth()
            
            grid.arrange(p,p2,p3,ncol=1)
            grid.arrange(p,p2,p3,nrow=1)
            
            
            
# Saving GGPLOTs ------------------------------------
            
        # ggsave()
            ggsave(filename = "~/Desktop/myplot2.pdf",
                   plot=p,width = 6,height = 4)
            
            
        # pdf() & dev.off()
            pdf(filename = "~/Desktop/myplot2.pdf",width = 6,height = 4)
            p
            dev.off()
            
        # from R Studio
            
            
            
            
# Practice ---------------------------------------------------
            
            
        # (1) generate a new sample of the diamonds data and create a boxplot 
        # using qplot() with "price" y-axis and "clarity" in the x. Change the
        # theme to classic. Add a title. Save as .png using ggsave.
            
            
            
            
        # (2) generate 3 plots: a histogram of carat (change the binwidth and 
        # color, add title), a histogram of depth (change the binwidth and 
        # color, add title), and a scatter of carat and depth broken up by cut.
        # Grid all three plots together using grid.arrange()
            
            
            
            
