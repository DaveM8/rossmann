require(dplyr)
require(lubridate)
require(reshape2)
require(ggplot2)

rossmann <- read.csv("train.csv")

w.rossmann <-
    rossmann %>%
        select(Store:SchoolHoliday) %>%
            transmute(store = as.factor(Store),
                      day.of.week = as.factor(DayOfWeek),
                      date = ymd(Date),
                      sales = Sales,
                      customers = Customers,
                      open = as.factor(Open),
                      promo = as.factor(Promo),
                      state.holiday = as.factor(StateHoliday),
                      school.holiday = as.factor(SchoolHoliday))

## split the data into training testing and valadation set
## train = 65%
## test = 25%
## val = 10%
 
stores <-
    w.rossmann %>%
        group_by(store) %>%
            summarise(avg_sales = mean(sales),
                      max_sales = max(sales),
                      min_sales = min(sales),
                      med_sales = median(sales),
                      avg_cust = mean(customers),
                      max_cust = max(customers),
                      min_cust = min(customers),
                      med_cust = median(customers),
                      count_open_days = sum(as.integer(open)),
                      count_promo_days = sum(as.integer(promo)))
