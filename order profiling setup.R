# setup
#install.packages("tidyverse")
#install.packages("readxl")
suppressPackageStartupMessages({
  library(dplyr)
  library(ggplot2)
  library(readxl)
})

# load and prepare the data
order_data <- read_excel(
  "Order_Profiling_Data.xls.xlsx",
  sheet = "Order Data",
  col_types = c("numeric", "text", "numeric", "text", "numeric")
)

# clean up column names (remove spaces)
order_data <- order_data |>
  rename(
    OrderNumber  = `Order Number`,
    PartNumber   = `Part Number`,
    QtyShipped   = `Qty Shipped`,
    ProductType  = `Product Type`,
    PiecesCarton = `Pieces per Carton`
  )

# explore
# structure and preview
glimpse(order_data)
head(order_data)
nrow(order_data)


# profile 1: demand profile (aka item activity profile)

# 1)total shipped per SKU, ranked high to low
demand_profile <- order_data |>
  group_by(PartNumber) |>
  summarize(TotalQty = sum(QtyShipped, na.rm = TRUE), .groups = "drop") |>
  arrange(desc(TotalQty)) |>
  mutate(
    SKU_Rank     = row_number(),
    CumQty       = cumsum(TotalQty),
    PctTotalSKUs = SKU_Rank / n(),
    PctTotalQty  = CumQty / sum(TotalQty)
  )

# 2)demand profile plot
ggplot(demand_profile, aes(x = PctTotalSKUs, y = PctTotalQty)) +
  geom_line(color = "steelblue", linewidth = 1.1) +
  geom_hline(yintercept = 0.80, linetype = "dashed", color = "orange") +
  labs(
    title = "Demand Profile (Item Activity Profile)",
    x = "Percent of Total SKUs",
    y = "Percent of Total Quantity Ordered"
  ) +
  scale_x_continuous(labels = scales::percent_format(accuracy = 1)) +
  scale_y_continuous(labels = scales::percent_format(accuracy = 1)) +
  theme_minimal()

# 3)SKUs needed for 80% of demand
sku_80 <- demand_profile |>
  filter(PctTotalQty >= 0.80) |>
  slice(1)

sku_80_count <- sku_80$SKU_Rank
sku_80_pct   <- 100 * sku_80$PctTotalSKUs
sku_80_count
sku_80_pct


# profile 2: lines-per-order profile

# count lines in each order
lines_per_order <- order_data |>
  group_by(OrderNumber) |>
  summarize(LinesPerOrder = n(), .groups = "drop")

# convert to distribution
# x = lines per order, y = % of orders
lines_profile <- lines_per_order |>
  count(LinesPerOrder, name = "NumOrders") |>
  arrange(LinesPerOrder) |>
  mutate(PctOrders = NumOrders / sum(NumOrders))

ggplot(lines_profile, aes(x = factor(LinesPerOrder), y = PctOrders)) +
  geom_col(fill = "steelblue") +
  labs(
    title = "Lines per Order Profile",
    x = "Lines per Order",
    y = "Percent of Orders"
  ) +
  scale_y_continuous(labels = scales::percent_format(accuracy = 1)) +
  theme_minimal()


# profile 3: item family profile

# each order can include a product family at most once in this table
order_family <- order_data |>
  distinct(OrderNumber, ProductType)

item_family_profile <- order_family |>
  count(ProductType, name = "NumOrders") |>
  mutate(PctOrders = NumOrders / n_distinct(order_data$OrderNumber)) |>
  arrange(desc(PctOrders))

ggplot(item_family_profile,
       aes(x = reorder(ProductType, -PctOrders), y = PctOrders)) +
  geom_col(fill = "orange") +
  labs(
    title = "Item Family Profile",
    x = "Product Type",
    y = "Percent of Orders"
  ) +
  scale_y_continuous(labels = scales::percent_format(accuracy = 1)) +
  theme_minimal()


# profile 4: unit load profile

# unit load percent by line = qty shipped / pieces per carton
unit_load_lines <- order_data |>
  mutate(UnitLoadPct = QtyShipped / PiecesCarton) |>
  mutate(
    UnitLoadBin = case_when(
      UnitLoadPct <= 0 ~ "0%",
      UnitLoadPct <= 0.25 ~ "1-25%",
      UnitLoadPct <= 0.50 ~ "26-50%",
      UnitLoadPct <= 0.75 ~ "51-75%",
      UnitLoadPct < 1 ~ "76-99%",
      UnitLoadPct == 1 ~ "100%",
      UnitLoadPct <= 2 ~ "101-200%",
      TRUE ~ ">200%"
    )
  )

unit_load_profile <- unit_load_lines |>
  count(UnitLoadBin, name = "NumLines") |>
  mutate(PctLines = NumLines / sum(NumLines)) |>
  mutate(UnitLoadBin = factor(
    UnitLoadBin,
    levels = c("0%", "1-25%", "26-50%", "51-75%", "76-99%", "100%", "101-200%", ">200%")
  )) |>
  arrange(UnitLoadBin)

ggplot(unit_load_profile, aes(x = UnitLoadBin, y = PctLines)) +
  geom_col(fill = "green") +
  labs(
    title = "Unit Load Profile",
    x = "Percent of Unit Load",
    y = "Percent of Lines"
  ) +
  scale_y_continuous(labels = scales::percent_format(accuracy = 1)) +
  theme_minimal()


# summary tables 
lines_profile
item_family_profile
unit_load_profile
