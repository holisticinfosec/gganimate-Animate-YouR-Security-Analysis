library(dplyr)
library(ggplot2)
library(gganimate)

cldprvdr_data <- read.csv("CloudProvidersCSF.csv") %>%
  mutate(control = factor(control, levels = c("Identify", "Protect", "Detect", "Respond", "Recover")))

control_color <- c(
  "Identify" = "#1a9fde",
  "Protect" = "#e10b1f", 
  "Detect" = "#565656", 
  "Respond" = "#727272", 
  "Recover" = "#499533" 
)

cp_animated <- ggplot(cldprvdr_data, aes(x = control, y = result, fill = control)) +
  geom_hline(yintercept = 0.05, colour = "#D3D3D3", linetype = "dashed") +
  geom_bar(position = "dodge", stat = "identity") +
  #geom_text(aes(label = scales::percent(result), 
  #              y = result + 0.01),
  #          position = position_dodge(width = 0.9), 
  #          vjust = -0.5, size = 6, color = "black") +
  labs(title = "2018 CSF attestation per month: {closest_state}",
       subtitle = "Cyber Security Framework (CSF) results per Cloud Provider",
       caption = "CSF function areas: Identify, Protect, Detect, Respond, Recover",
       x = "", y = "") +
  theme_light(base_size = 16) +
  guides(fill = FALSE) +
  facet_grid(cldprvdr ~ .) +
  scale_y_continuous(labels = scales::percent, limits = c(0, 1)) +
  scale_fill_manual(values = control_color) +
  transition_states(month, 1,3, wrap = FALSE) +
  ease_aes('quadratic-in-out')
cp_animated + anim_save("CloudProvidersCSF.gif")