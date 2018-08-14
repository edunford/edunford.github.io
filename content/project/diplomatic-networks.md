+++
# Date this page was created.
date = 2015-02-13T00:00:00

# Project title.
title = "Mapping Diplomatic Networks"

# Project summary to display on homepage.
summary = "In this project, we examine structural breaks in diplomatic meeting patterns as predictors for shifts in foreign policy."

# Optional image to display on homepage (relative to `static/img/` folder).
image_preview = "project-images/iran_map.gif"

# Tags: can be used for filtering projects.
# Example: `tags = ["machine-learning", "deep-learning"]`
tags = ["Networks","Diplomatic Meetings","Event Data"]

# Optional external URL for project (replaces project detail page).
external_link = ""

# Does the project detail page use math formatting?
math = false

# Optional featured image (relative to `static/img/` folder).
[header]
image = "project-images/iran_map.gif"
caption = "Diplomatic meetings between Iran and other states over time."

+++
After a century of research on international crisis, we still have trouble anticipating conflict between states. This partly due to the difficulty in measuring the intentions and foreign policy strategies of states. To fill this gap, a coauthor and I turn to an untapped source: the structural patterns of diplomatic meetings. These meetings are pre-organized, public engagements between the foreign policy elites of two states. We systematically scrape and machine code records of all self-reported diplomatic exchanges for 80 states cross-nationally to reconstruct a state’s ego-centric network of diplomacy over time. By leveraging structural breaks in the meeting patterns between states, we provide an efficient, scaleable method of examining state behavior in almost real time.

As a proof of concept, in a recent paper we perform this procedure on Iran and Russia, and show that structural breaks appear in Iran’s diplomatic behavior in the months after sanctions are lifted, and in Russia a year before the Ukraine crisis and again when Russia begins its military campaign in Syria.
