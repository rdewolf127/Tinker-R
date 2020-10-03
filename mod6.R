
library(plotly)
library(gapminder)


p <- ggplot(gapminder, aes(gdpPercap, lifeExp, color = continent)) +
  geom_point(aes(size = pop, frame = year, ids = country)) +
  scale_x_log10()

p <- ggplotly(p)


Sys.setenv("plotly_username"="rmdewolf")
Sys.setenv("plotly_api_key"="6nn7rb18Ei9aVu3KvJD1")


chart_link = api_create(p, filename="mulitple-trace")
chart_link

#with a fit line for 1952
gm_1952 <- gapminder[gapminder$year == 1952,]
head(gm_1952)

p <- ggplot(gm_1952, aes(gdpPercap, lifeExp)) +
  geom_point(aes(size = pop, frame = year, ids = country)) +
  geom_smooth(method="loess", se=F)+
  scale_x_log10()

p <- ggplotly(p)


Sys.setenv("plotly_username"="rmdewolf")
Sys.setenv("plotly_api_key"="6nn7rb18Ei9aVu3KvJD1")


chart_link = api_create(p, filename="mulitple-trace")
chart_link

if(!require(devtools)) install.packages("devtools")
devtools::install_github("kassambara/ggpubr")

library("ggpubr")

cor.test(gm_1952$gdpPercap, gm_1952$lifeExp, method=c("pearson", "kendall", "spearman"))

gm_1952_no_kw <- gm_1952[gm_1952$country != 'Kuwait',]
head(gm_1952_no_kw)

cor.test(gm_1952_no_kw$gdpPercap, gm_1952_no_kw$lifeExp, method=c("pearson", "kendall", "spearman"))

#with a fit line for 2007
gm_2007 <- gapminder[gapminder$year == 2007,]
head(gm_2007)

p <- ggplot(gm_2007, aes(gdpPercap, lifeExp)) +
  geom_point(aes(size = pop, frame = year, ids = country)) +
  geom_smooth(method="loess", se=F)+
  scale_x_log10()

p <- ggplotly(p)


Sys.setenv("plotly_username"="rmdewolf")
Sys.setenv("plotly_api_key"="6nn7rb18Ei9aVu3KvJD1")


chart_link = api_create(p, filename="mulitple-trace")
chart_link

cor.test(gm_2007$gdpPercap, gm_2007$lifeExp, method=c("pearson", "kendall", "spearman"))

#put into matrix by country
a <- ggplot(gm_1952, aes(gdpPercap, lifeExp)) + geom_point(aes(color = continent)) + 
  scale_y_continuous("gdpPercap")+
  scale_x_continuous("lifeExp")+
  theme_bw() + labs(subtitle="GDP Per Capita vs. Life Expectancy") + facet_wrap( ~ continent)+
  geom_point(aes(frame = year)) +
  scale_x_log10()

a <- ggplot(gm_1952, aes(gdpPercap, lifeExp, color = continent)) +
  geom_point(aes(size = pop, frame = year, ids = country)) +
  scale_x_log10()+ facet_wrap( ~ continent)+geom_smooth(method="loess", se=F)

a <- ggplotly(a)


Sys.setenv("plotly_username"="rmdewolf")
Sys.setenv("plotly_api_key"="6nn7rb18Ei9aVu3KvJD1")


chart_link = api_create(a, filename="mulitple-trace-continent")
chart_link

#put into matrix by country
a <- ggplot(gm_2007, aes(gdpPercap, lifeExp)) + geom_point(aes(color = continent)) + 
  scale_y_continuous("gdpPercap")+
  scale_x_continuous("lifeExp")+
  theme_bw() + labs(subtitle="GDP Per Capita vs. Life Expectancy") + facet_wrap( ~ continent)+
  geom_point(aes(frame = year)) +
  scale_x_log10()

a <- ggplot(gm_2007, aes(gdpPercap, lifeExp, color = continent)) +
  geom_point(aes(size = pop, frame = year, ids = country)) +
  scale_x_log10()+ facet_wrap( ~ continent)+geom_smooth(method="loess", se=F)

a <- ggplotly(a)


Sys.setenv("plotly_username"="rmdewolf")
Sys.setenv("plotly_api_key"="6nn7rb18Ei9aVu3KvJD1")


chart_link = api_create(a, filename="mulitple-trace-continent")
chart_link

world <- map_data("world")

exp <- select(gm_2007, country, gdpPercap)


exp$region <- tolower(exp$country)

arr <- select(exp, region, gdpPercap)

gg <- ggplot()
gg <- gg + geom_map(data=world, map=world,
                    aes(x=long, y=lat, map_id=region),
                    fill="#ffffff", color="#ffffff", size=0.15)
gg <- gg + geom_map(data=arr, map=world,
                    aes(fill=gdpPercap, map_id=region),
                    color="#ffffff", size=0.15)
gg <- gg + scale_fill_continuous(low='thistle2', high='darkred', 
                                 guide='colorbar')
gg <- gg + labs(x=NULL, y=NULL)
gg <- gg + coord_map("albers", lat0 = 39, lat1 = 45) 
gg <- gg + theme(panel.border = element_blank())
gg <- gg + theme(panel.background = element_blank())
gg <- gg + theme(axis.ticks = element_blank())
gg <- gg + theme(axis.text = element_blank())
gg

a <- ggplotly(gg)


Sys.setenv("plotly_username"="rmdewolf")
Sys.setenv("plotly_api_key"="6nn7rb18Ei9aVu3KvJD1")


chart_link = api_create(a, filename="mulitple-trace-continent")
chart_link