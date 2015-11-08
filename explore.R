
train <- read.csv("train.csv")
require(ggplot2)
require(dplyr)
require(lubridate)
require(reshape2)

train$Store <- as.factor(train$Store)
train$DayOfWeek <- as.factor(train$DayOfWeek)
train$DayOfWeek <- as.factor(train$DayOfWeek)
train$Date <- ymd(train$Date)
train$Open <- as.factor(train$Open)
train$Promo <- as.factor(train$Promo)
train$Promo <- as.factor(train$Promo)
train$StateHoliday <- as.factor(train$StateHoliday)
train$SchoolHoliday <- as.factor(train$SchoolHoliday)


ggplot(train, aes(x=Sales, y=Customers, colour=DayOfWeek)) + geom_point()
ggplot(train, aes(x=Sales, y=Customers, colour=DayOfWeek)) + geom_point(shape=SchoolHoliday)
ggplot(train, aes(x=Sales, y=Customers, colour=DayOfWeek)) + geom_point(shape=SchoolHoliday)
ggplot(train, aes(x=Sales, y=Customers, colour=DayOfWeek, shape=SchoolHoliday)) + geom_point()
train %>% sample_frac(.1) %>%ggplot(aes(x=Sales, y=Customers, colour=DayOfWeek, shape=SchoolHoliday)) + geom_point()
train %>% sample_frac(.1) %>%ggplot(aes(x=Sales, y=Customers, colour=Promo)) + geom_point()


## later
w.train <- train %>% mutate(sale_per_cus = Sales / Customers)
w.train <- train %>% mutate(year = year(Date))

w.train <- train %>% mutate(month = month(Date, label=TRUE))
w.train <- w.train %>% mutate(year = year(Date))

my_month <- w.train %>% group_by(year,month) %>% summarise(monthly_sales = sum(Sales), monthly_cus = sum(Customers))
my_month <- my_month %>% mutate(monthly = ymd(paste(as.character(year),as.character(month), "01",sep="-")))

tmp.month <- my_month %>% select(monthly_sales:monthly)
tmp.month <- tmp.month[-1]
tmp.month$monthly <- as.character(tmp.month$monthly)
l.month <- melt(tmp.month)
ggplot(l.month, aes(x=monthly, y=value, group=variable, colour=variable))+geom_line(size=1)
