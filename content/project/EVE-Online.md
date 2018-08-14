+++
# Date this page was created.
date = 2016-04-27T00:00:00

# Project title.
title = "Live Simulated Environments"

# Project summary to display on homepage.
summary = "We use use a massive multiplayer online game, Eve Online, to examine collective and individual level behavior cross-nationally at a highly granular level."

# Optional image to display on homepage (relative to `static/img/` folder).
image_preview = "project-images/eve-online.jpg"

# Tags: can be used for filtering projects.
# Example: `tags = ["machine-learning", "deep-learning"]`
tags = ["Video Game Data",'Collective Behavior','EVE Online']

# Optional external URL for project (replaces project detail page).
external_link = "" 

# Does the project detail page use math formatting?
math = false

# Optional featured image (relative to `static/img/` folder).
[header]
image = "project-images/eve-online.jpg"
caption = "Image of live-game play (copywrite CCP Games)"

+++

Recent work in economics and communication have demonstrated the value of virtual worlds in analyzing social and collective behavior. Online video games provide useful “petri dishes” for the study of human behavior (Castronova and Falk, 2009; Williams, 2010) by oﬀering researchers highly granular event data (second-by-second) of player actions, a wealth of structural breaks ideal for natural experiments (when rules of the game are changed or new servers are activated), and clear ways to operationalize individual-level capacity, motivations, and resources (Williams et al., 2011; Huang et al., 2009; Kahn and Williams, 2015; Keegan et al., 2010). Such data is “live” in the sense that it employs human agents that react to the virtual world in heterogeneous ways.

Live simulated environments oﬀer a rare opportunity to examine individual and group-level behavior in a way that was previously impossible. First, these data oﬀer a perfect record of all activity. As all player information is recorded, one can observe a player’s entrance and exit from groups, evolution of behavior over time, and degree of cooperation and conﬂict. Second, group dynamics can be recomposed. Individual-level interactions of members in a group can be perfectly tracked and mapped. As a result, group networks can be reconstructed, and exact measurements of cohesion and interaction can be captured over time. Third, changes in the environment can be leveraged for causal identiﬁcation. Specifically, when rules are changed in the game, this produces a structural break that can yield discontinuities in individual and group-level behavior. In addition, matching techniques can be employed to ease causal identiﬁcation.

My co-authors (David Waguespack and Johanna Birnir) and I use a massive multiplayer online game, [Eve Online (EVE)](https://www.eveonline.com/). EVE was created in 2003 by [CCP Games](https://www.ccpgames.com/) and plays out in an interstellar backdrop where individuals mine resources, barter and trade, compete over territory, and wage large-scale conﬂicts. The game has a total user-base of 600,000+ individuals, spanning 163 countries, 65 of which have more than 5,000 users. In the game, users ﬂy around in ships that are purchased and created by acquiring resources during game play. The game is stylistically modeled as a “sandbox”, which is a style of game in which minimal limitations are placed on the user. This allows individuals to roam, interact, cheat, trick, and shape the virtual universe. 

EVE functions as a live simulated environment given four underlying assumptions that underpin its game play. 

- **The environment is market-based**: Resources in the game need to be mobilized. Capacity in the virtual world is deﬁned by an agent’s ability to gain suﬃcient funds to buy “ships,” generate incentives to coordinate players, and project power. Extraction and exchange require goods to be brought to market, which which can be looted when transported or may lack buyers when brought to market. Thus, the market-based system generates uncertainty, risk, and requires strategic calculation in order to gain resources. Moreover, it makes the loss of resources costly, as gaining back losses takes considerable time and energy.

- **The game pivots off collective action**: The game requires players to coordinate their activity, to pool resources, and to monitor each other for free riding and other infractions. Players enter into corporations, which have a distinct hierarchies and leadership structures. In addition, corporations can join into alliances, which yield considerable inﬂuence on the dynamics in the game. The underlying need for players in diﬀerent countries, time zones, and backgrounds to coordinate oﬀers a rare but valuable microcosm of collective activity.

- **The environment offers a realistic approximation of risk**: Assets take time to acquire and can be permanently destroyed. Poor decisions, mismanagement, and adverse random occurrences (bad luck) can result in the lose of valuable resources. Extraction and acquisition of resources in the game takes considerable time, and thus loss of these resources carries meaning for players. This reality is reﬂected in the in-game adage: “don’t ﬂy what you can’t aﬀord to lose.” Players often need to transport large quantities of resources, or utilize expensive weapons in decisive battles that open them up to risk. This risk conditions how players play, and the decisions they make.

- **The environment pivots off territorial control**: Territory can only be acquired and maintained given suﬃcient capacity and manpower. This means that alliances between corporations must be maintained in order to retain territory—as the alliance’s military capacity is only good as the sum of all member corporation’s capabilities. The reality of territorial control requires agreements and negotiations between groups; it requires that players mobilize and come online when the alliance faces a challenger; and it requires that resources be suﬃciently distributed between partner corporations.

We use these data to examine a range of political science and business management questions.  