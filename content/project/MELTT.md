+++
# Date this page was created.
date = 2016-04-27T00:00:00

# Project title.
title = "MELTT: Merging Event Data by Location Time and Type"

# Project summary to display on homepage.
summary = "We formalize a framework for merging and disambiguating event data based on spatiotemporal co-occurrence and secondary event characteristics in the R package, `meltt`. The package accounts for intrinsic 'fuzziness' in the coding of events, varying event taxonomies, and different geo-precision codes. The procedure and methodology seeks to assist researchers in bringing together disparate geospatial, temporally disaggregated event data."

# Optional image to display on homepage (relative to `static/img/` folder).
image_preview = "project-images/meltt-steps.jpg"

# Tags: can be used for filtering projects.
# Example: `tags = ["machine-learning", "deep-learning"]`
tags = ["Integrating Event Data",'R Package','MELTT','Conflict Event Data']

# Optional external URL for project (replaces project detail page).
external_link = "" #"https://github.com/css-konstanz/meltt"

# Does the project detail page use math formatting?
math = false

# Optional featured image (relative to `static/img/` folder).
[header]
image = "project-images/meltt-steps.jpg"
caption = ""

+++

The growing volume of sophisticated event-level data collection, with improving geographic and temporal coverage, offers prospects for conducting novel analyses. In instances where multiple related datasets are available, researchers tend to rely on one at a time, ignoring the potential value of the multiple datasets in providing more comprehensive, precise, and valid measurement of empirical phenomena. If multiple datasets are used, integration is typically limited to manual efforts for select cases. My co-authors and I develop the conceptual and methodological foundations for automated, transparent and reproducible integration and disambiguation of multiple event datasets.

In a recent paper, we formally present the methodology, validate it with synthetic test data, and demonstrate its application using conflict event data for Africa, drawing on four leading sources (UCDP-GED, ACLED, SCAD, GTD). We show that whether analyses rely on one or multiple datasets can affect substantive findings with regard to key explanatory variables, thus highlighting the critical importance of systematic data integration. 

To make the method accessible to all researchers, [Karsten Donnay](http://www.karstendonnay.net/) and I have developed an `R` package, which allows for easy implementation. The [meltt](https://cran.r-project.org/web/packages/meltt/index.html) package is now available on CRAN. Also, the project and code is up on Github where we provide a [basic walkthrough](https://github.com/css-konstanz/meltt) of the package's functionality.