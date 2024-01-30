## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
# make sure that you have the corrent RTools installed.
# as you might need to build some packages from source
# if you don't have RTools installed, you can install it with:
# install.packages('installr'); install.Rtools() # not tested on windows
# or download it from here:
# https://cran.r-project.org/bin/windows/Rtools/
# in any case, make sure that you select the correct version, 
# otherwise the installation will fail.
# then you'll need devtools
# if (!require('devtools'))
  # install.packages('devtools')
# finally install the package
# devtools::install_github('VerkehrsbetriebeZuerich/catmaply')

## -----------------------------------------------------------------------------
#install.packages("catmaply")

## -----------------------------------------------------------------------------
library(catmaply)
library(dplyr)

## ----out.width='100%'---------------------------------------------------------
data("vbz")

df <- na.omit(vbz[[1]]) %>% 
  filter(.data$vehicle == "PO")

str(df)

## ----fig.height=8, out.width='100%', warning = FALSE--------------------------
catmaply(
    df,
    x = trip_seq,
    y = stop_seq,
    z = occ_category
  ) 

## ----fig.height=8, out.width='100%', warning = FALSE--------------------------
catmaply(
    df,
    x = trip_seq,
    y = stop_name,
    y_order = stop_seq,
    z = occ_category
  ) 

## ----fig.height=8, out.width='100%', warning = FALSE--------------------------
catmaply(
    df,
    x = trip_seq,
    y = stop_name,
    y_order = stop_seq,
    z = occ_category,
    legend_col = occ_cat_name
  ) 

## ----fig.height=8, out.width='100%', warning = FALSE--------------------------
catmaply(
    df,
    x = trip_seq,
    y = stop_name,
    y_order = stop_seq,
    z = occ_category,
    color_palette = viridis::magma,
    legend_col = occ_cat_name
  )

## ----fig.height=8, out.width='100%', warning = FALSE--------------------------
catmaply(
    df,
    x = trip_seq,
    y = stop_name,
    y_order = stop_seq,
    z = occ_category,
    color_palette = viridis::magma,
    legend_interactive = FALSE,
    legend_col = occ_cat_name
  )

## ----fig.height=8, out.width='100%', warning = FALSE--------------------------
df <- df%>%
  mutate(x_label = paste(
    formatC(trip_seq, width=3, flag="0"), 
    vehicle, 
    formatC(circulation_name, width=2, flag = "0"),
    sep="-")
  )

catmaply(
    df,
    x = x_label,
    x_order = trip_seq,
    y = stop_name,
    y_order = stop_seq,
    z = occupancy,
    categorical_color_range = TRUE,
    categorical_col = occ_category,
    color_palette = viridis::magma,
    legend_col = occ_cat_name
  )

## ----fig.height=8, out.width='100%', warning = FALSE--------------------------
catmaply(
    df,
    x = x_label,
    x_order = trip_seq,
    y = stop_name,
    y_order = stop_seq,
    z = occupancy,
    categorical_color_range = TRUE,
    categorical_col = occ_category,
    color_palette = viridis::magma,
    legend_interactive = FALSE,
    legend_col = occ_cat_name
  )

## ----fig.height=8, out.width='100%', warning = FALSE--------------------------
catmaply(
    df,
    x='x_label',
    x_order = 'trip_seq',
    x_tickangle = 80,
    y = "stop_name",
    y_order = "stop_seq",
    y_tickangle = -10,
    z = "occupancy",
    categorical_color_range = TRUE,
    categorical_col = 'occ_category',
    color_palette = viridis::magma,
    font_size = 10,
    font_color = '#6D65AB',
    font_family = "verdana",
    legend_col = occ_cat_name
    )

## ----fig.height=8, out.width='100%', warning = FALSE--------------------------
catmaply(
  df,
  x=x_label,
  x_order = trip_seq,
  x_tickangle = 80,
  y = stop_name,
  y_order = stop_seq,
  z = occupancy,
  categorical_color_range = TRUE,
  categorical_col = occ_category,
  color_palette = viridis::inferno,
  hover_template = paste(
    '<b>Trip</b>:', trip_seq,
    '<br><b>Stop Name</b>:', stop_name,
    '<br><b>Occupancy category</b>:', occ_cat_name,
    '<br><b>Occupancy</b>:', round(occupancy, 2),
    '<extra></extra>'
  ),
  legend_col = occ_cat_name
)

## ----fig.height=8, out.width='100%', warning = FALSE--------------------------
catmaply(
  df,
  x=x_label,
  x_order = trip_seq,
  x_tickangle = 80,
  y = stop_name,
  y_order = stop_seq,
  z = occupancy,
  categorical_color_range = TRUE,
  categorical_col = occ_category,
  color_palette = viridis::inferno,
  hover_template = paste(
    '<br><b>Trip</b>:', trip_seq,
    '<br><b>Stop Name</b>:', stop_name,
    '<br><b>Occupancy category</b>:', occ_cat_name,
    '<br><b>Occupancy</b>:', round(occupancy, 2),
    '<extra></extra>'
  ),
  legend_col = occ_cat_name,
  legend = FALSE
)

## ----fig.height=8, out.width='100%', warning = FALSE--------------------------
catmaply(
  df,
  x=x_label,
  x_order = trip_seq,
  x_tickangle = 80,
  y = stop_name,
  y_order = stop_seq,
  z = occupancy,
  categorical_color_range = TRUE,
  categorical_col = occ_category,
  color_palette = viridis::inferno,
  hover_hide = TRUE,
  legend_col = occ_cat_name,
  legend = FALSE
)

## ----fig.height=8, out.width='100%', warning = FALSE--------------------------
catmaply(
  df,
  x=x_label,
  x_order = trip_seq,
  x_tickangle = 80,
  y = stop_name,
  y_order = stop_seq,
  z = occupancy,
  categorical_color_range = TRUE,
  categorical_col = occ_category,
  color_palette = viridis::inferno,
  hover_hide = TRUE,
  legend_col = occ_cat_name,
  legend = TRUE
)

## ----fig.height=8, out.width='100%', warning = FALSE--------------------------
df <- df %>%
  na.omit() %>%
  dplyr::group_by(
    trip_seq
  ) %>%
  dplyr::mutate(
    departure_date_time = min(na.omit(lubridate::ymd_hms(paste("2020-08-01", departure_time))))
  ) %>%
  dplyr::ungroup()

catmaply(
  df,
  x=departure_date_time,
  y = stop_name,
  y_order = stop_seq,
  z = occupancy,
  categorical_color_range = TRUE,
  categorical_col = occ_category,
  color_palette = viridis::inferno,
  hover_template = paste(
    '<br><b>Trip</b>:', trip_seq,
    '<br><b>Stop Name</b>:', stop_name,
    '<br><b>Occupancy category</b>:', occ_cat_name,
    '<br><b>Occupancy</b>:', round(occupancy, 2),
    '<extra></extra>'
  )
)

## ----fig.height=8, out.width='100%', warning = FALSE--------------------------

catmaply(
  df,
  x=departure_date_time,
  y = stop_name,
  y_order = stop_seq,
  z = occupancy,
  categorical_color_range = TRUE,
  categorical_col = occ_category,
  color_palette = viridis::inferno,
  hover_template = paste(
    '<br><b>Trip</b>:', trip_seq,
    '<br><b>Stop Name</b>:', stop_name,
    '<br><b>Occupancy category</b>:', occ_cat_name,
    '<br><b>Occupancy</b>:', round(occupancy, 2),
    '<extra></extra>'
  ),
  tickformatstops=list(
    list(dtickrange = list(NULL, 1000), value = "%H:%M:%S.%L"),
    list(dtickrange = list(1000, 60000), value = "%H:%M:%S"),
    list(dtickrange = list(60000, 3600000), value = "%H:%M"),
    list(dtickrange = list(3600000, 86400000), value = "%H:%M"),
    list(dtickrange = list(86400000, 604800000), value = "%H:%M"),
    list(dtickrange = list(604800000, "M1"), value = "%H:%M"),
    list(dtickrange = list("M1", "M12"), value = "%H:%M"),
    list(dtickrange = list("M12", NULL), value = "%H:%M")
  )
)

## ----fig.height=8, out.width='100%', warning = FALSE--------------------------

catmaply(
  df,
  x=x_label,
  x_order = trip_seq,
  y = stop_name,
  y_order = stop_seq,
  z = occupancy,
  categorical_color_range = TRUE,
  categorical_col = occ_category,
  color_palette = viridis::inferno,
  hover_template = paste(
    '<br><b>Trip</b>:', trip_seq,
    '<br><b>Stop Name</b>:', stop_name,
    '<br><b>Occupancy category</b>:', occ_cat_name,
    '<br><b>Occupancy</b>:', round(occupancy, 2),
    '<extra></extra>'
  ),
  rangeslider = FALSE, # to prevent warning
  legend_interactive = FALSE, # to prevent warning
  slider = TRUE # activate slider
)

## ----fig.height=8, out.width='100%', warning = FALSE--------------------------
catmaply(
  df,
  x=x_label,
  x_order = trip_seq,
  y = stop_name,
  y_order = stop_seq,
  z = occupancy,
  categorical_color_range = TRUE,
  categorical_col = occ_category,
  color_palette = viridis::inferno,
  hover_template = paste(
    '<br><b>Trip</b>:', trip_seq,
    '<br><b>Stop Name</b>:', stop_name,
    '<br><b>Occupancy category</b>:', occ_cat_name,
    '<br><b>Occupancy</b>:', round(occupancy, 2),
    '<extra></extra>'
  ),
  rangeslider = FALSE, # to prevent warning
  legend_interactive = FALSE, # to prevent warning
  slider = TRUE, # activate slider,
  slider_currentvalue_prefix = "Trip: "
)

## ----fig.height=8, out.width='100%', warning = FALSE--------------------------
catmaply(
  df,
  x=x_label,
  x_order = trip_seq,
  y = stop_name,
  y_order = stop_seq,
  z = occupancy,
  categorical_color_range = TRUE,
  categorical_col = occ_category,
  color_palette = viridis::inferno,
  hover_template = paste(
    '<br><b>Trip</b>:', trip_seq,
    '<br><b>Stop Name</b>:', stop_name,
    '<br><b>Occupancy category</b>:', occ_cat_name,
    '<br><b>Occupancy</b>:', round(occupancy, 2),
    '<extra></extra>'
  ),
  rangeslider = FALSE, # to prevent warning
  legend_interactive = FALSE, # to prevent warning
  slider = TRUE, # activate slider,
  slider_currentvalue_visible = FALSE,
  slider_step_visible = FALSE,
  slider_tick_visible = FALSE
)

## ----fig.height=8, out.width='100%', warning = FALSE--------------------------
catmaply(
  df,
  x=x_label,
  x_order = trip_seq,
  y = stop_name,
  y_order = stop_seq,
  z = occupancy,
  categorical_color_range = TRUE,
  categorical_col = occ_category,
  color_palette = viridis::inferno,
  hover_template = paste(
    '<br><b>Trip</b>:', trip_seq,
    '<br><b>Stop Name</b>:', stop_name,
    '<br><b>Occupancy category</b>:', occ_cat_name,
    '<br><b>Occupancy</b>:', round(occupancy, 2),
    '<extra></extra>'
  ),
  rangeslider = FALSE, # to prevent warning
  legend_interactive = FALSE, # to prevent warning
  slider = TRUE, # activate slider,
  slider_currentvalue_visible = FALSE,
  slider_steps=list(
    slider_start=1,
    slider_range=15,
    slider_shift=10,
    slider_step_name="x" # same name as x axis (must be character)
  )
)

## ----fig.height=8, out.width='100%', warning = FALSE--------------------------
catmaply(
  df,
  x=x_label,
  x_order = trip_seq,
  y = stop_name,
  y_order = stop_seq,
  z = occupancy,
  categorical_color_range = TRUE,
  categorical_col = occ_category,
  color_palette = viridis::inferno,
  hover_template = paste(
    '<br><b>Trip</b>:', trip_seq,
    '<br><b>Stop Name</b>:', stop_name,
    '<br><b>Occupancy category</b>:', occ_cat_name,
    '<br><b>Occupancy</b>:', round(occupancy, 2),
    '<extra></extra>'
  ),
  rangeslider = FALSE, # to prevent warning
  legend_interactive = FALSE, # to prevent warning
  slider = TRUE, # activate slider,
  slider_currentvalue_visible = FALSE,
  slider_steps = list(
    list(name="Very important step one", range=c(12, 37)), 
    list(name="Very important step two", range=c(87, 111))
  )
)

## ----fig.height=8, out.width='100%', warning = FALSE--------------------------
catmaply(
  df,
  x=x_label,
  x_order = trip_seq,
  y = stop_name,
  y_order = stop_seq,
  z = occupancy,
  text = occ_category,
  text_color="#000",
  text_size=12,
  text_font_family="Open Sans",
  categorical_color_range = TRUE,
  categorical_col = occ_category,
  color_palette = viridis::plasma,
  hover_template = paste(
    '<br><b>Trip</b>:', trip_seq,
    '<br><b>Stop Name</b>:', stop_name,
    '<br><b>Occupancy category</b>:', occ_cat_name,
    '<br><b>Occupancy</b>:', round(occupancy, 2),
    '<extra></extra>'
  ),
  rangeslider = FALSE, # to prevent warning
  legend_interactive = FALSE, # to prevent warning
  slider = TRUE, # activate slider,
  slider_currentvalue_visible = FALSE,
  slider_steps=list(
    slider_start=1,
    slider_range=15,
    slider_shift=10,
    slider_step_name="x" # same name as x axis (must be character)
  )
)

## -----------------------------------------------------------------------------
sessionInfo()

