library(ggplot2)
library(gganimate)

incidents <- read.csv("incidents.csv")
incidents$Month <- format(ISOdate(2004,1:12,1),"%B")[incidents$Month]

p <- ggplot(incidents, aes(Day, Inc_Cnt, group = Month)) + 
  geom_line(aes(colour=Month)) + 
  geom_segment(aes(xend = 31, yend = Inc_Cnt), linetype = 2, colour = 'blue') + 
  geom_point(size = 2) + 
  geom_text(aes(x = 31.1, label = Month), hjust = 0, colour = 'brown') + 
  transition_reveal(Month, Day) + 
  coord_cartesian(clip = 'off') + 
  labs(title = 'Incident Counts by Day - AUG through DEC', y = 'Incident Count') + 
  theme_minimal() + 
  theme(plot.margin = margin(5.5, 40, 5.5, 5.5)) +
  theme(legend.position='none')
p + anim_save("incidentTS.gif")