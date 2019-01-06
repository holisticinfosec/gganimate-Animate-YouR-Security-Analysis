library(ggplot2)
library(gganimate)
library(tibble)

data <- read.csv("SDL.csv")
sdl_data <- as_data_frame(data)

options(scipen=10000)

sdlp <- ggplot(sdl_data, aes(bugs, regressions, size = code, colour = apps)) +
  geom_point(alpha = 0.7) +
  scale_colour_manual(values = rainbow(n=142)) +
  scale_size(range = c(2, 12)) +
  scale_x_log10() +
  facet_wrap(~OS) +
  theme(legend.position = 'none') +
  labs(title = 'Year: {frame_time}', x = 'Bugs', y = 'Regressions', 
       subtitle = "Ten Years of SDL") +
  transition_time(year)
sdlp + anim_save("SDL.gif")