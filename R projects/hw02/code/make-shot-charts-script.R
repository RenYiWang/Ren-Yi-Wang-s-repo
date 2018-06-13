# ===================================================================
# Title: make-shots-charts-script
# Description: create shot charts
# Input(s): .jpg for nba court
# Output(s): .pdf files for shot charts
# Author(s): Ren Yi Wang
# Date: 03-06-2018
# ===================================================================
library(jpeg)
library(grid)
library(ggplot2)

# 4) Shot Charts

# court image (to be used as background of plot)
court_file <- "../images/nba-court.jpg"

# create raster object
court_image <- rasterGrob(
  readJPEG(court_file),
  width = unit(1, "npc"),
  height = unit(1, "npc"))

# 4.1) Shot charts of each player

# Create shot charts (with court backgrounds) for each player
# , and save the plots in PDF format, with dimensions
# width = 6.5 and height = 5 inches, inside the folder images/
# shot chart with court background
iguodala_shot_chart <- ggplot(data = iguodala) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Andre Iguodala (2016 season)') +
  theme_minimal()
ggsave('../images/andre-iguodala-shot-chart.pdf',
       plot = iguodala_shot_chart,
       width = 6.5, height = 5, units = 'in')

green_shot_chart<- ggplot(data = green) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Draymond Green (2016 season)') +
  theme_minimal()
ggsave('../images/draymond-green-shot-chart.pdf',
       plot = green_shot_chart,
       width = 6.5, height = 5, units = 'in')

durant_shot_chart<- ggplot(data = durant) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Kevin Durant (2016 season)') +
  theme_minimal()
ggsave('../images/kevin-durant-shot-chart.pdf',
       plot = green_shot_chart,
       width = 6.5, height = 5, units = 'in')

thompson_shot_chart <- ggplot(data = thompson) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Klay Thompson (2016 season)') +
  theme_minimal()
ggsave('../images/klay-thompson-shot-chart.pdf',
       plot = thompson_shot_chart,
       width = 6.5, height = 5, units = 'in')

curry_shot_chart <- ggplot(data = curry) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Stephen Curry (2016 season)') +
  theme_minimal()
ggsave('../images/stephen-curry-shot-chart.pdf',
       plot = curry_shot_chart,
       width = 6.5, height = 5, units = 'in')

# 4.2) Facetted Shot Chart
gsw_shot_charts <- ggplot(data = gsw) +
  facet_wrap(~ name) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag), alpha = 0.7) +
  ylim(-50, 420) +
  ggtitle('Shot Charts: GSW (2016 season)') +
  theme_minimal()
ggsave('../images/gsw-shot-charts.pdf',
       plot = gsw_shot_charts,
       width = 8, height = 7, units = 'in')
















