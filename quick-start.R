library(spanishoddata)
spod_set_data_dir("data")
library(flowmapper)
library(tidyverse)
library(sf)
library(mapSpain)

# Flows for 2022-01-01 between districts
od <- spod_get("od", zones = "distr", dates = "2022-01-01")

# Aggregate OD flows
od_total <- od |>
  group_by(o = id_origin, d = id_destination) |>
  summarise(value = sum(n_trips, na.rm = TRUE), .groups = "drop") |>
  collect() |>
  mutate(o = as.character(o), d = as.character(d))

# District zones (v2)
districts <- spod_get_zones("distr", ver = 2)

# Madrid municipality polygon

# District zones (v2)
districts_v2 <- spod_get_zones("distr", ver = 2)

# Madrid zones from existing zone names (fallback to ID prefix if needed)
zones_madrid <- districts_v2 |>
  filter(grepl("^Madrid\\b", name, ignore.case = TRUE))

# Nodes table (centroids)
nodes_madrid <- zones_madrid |>
  st_centroid() |>
  st_coordinates() |>
  as.data.frame() |>
  mutate(name = zones_madrid$id) |>
  rename(x = X, y = Y)

# Flows restricted to Madrid zones
od_madrid <- od_total |>
  filter(o %in% zones_madrid$id, d %in% zones_madrid$id)

# Base map
p_base <- ggplot() +
  geom_sf(data = zones_madrid, fill = NA, col = "grey60", linewidth = 0.3) +
  theme_classic(base_size = 16) +
  theme(
    axis.line = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    axis.title = element_blank(),
    panel.background = element_rect(fill = "transparent"),
    plot.background = element_rect(fill = "transparent", color = NA),
    panel.grid = element_blank()
  ) +
  guides(fill = "none")

# Flow map for Madrid
p_madrid <- p_base |>
  add_flowmap(
    od = od_madrid,
    nodes = nodes_madrid,
    node_radius_factor = 1,
    edge_width_factor = 0.6,
    arrow_point_angle = 45,
    node_buffer_factor = 1.5,
    outline_col = "grey80",
    add_legend = "bottom",
    legend_col = "gray20",
    legend_gradient = TRUE,
    k_node = 10
  ) +
  scale_fill_gradient(
    low = "#FABB29",
    high = "#AB061F",
    labels = scales::comma_format()
  )

# Plot
p_madrid

# Optional save
ggsave(
  "flows_madrid_2022-01-01.png",
  p_madrid,
  width = 8,
  height = 6,
  dpi = 300
)
