#Name: Kiki Takeuchi
#Date: 8/12/20
#Purpose: learn to use joins and functions

library(tidyverse)
url = 'https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv'
covid = read_csv(url)
head(covid)

region = data.frame(state = state.name, region = state.region)
head(region)

##Question 1
covid %>%
  right_join(region, by = "state") %>%
  group_by(region, date) %>%
  summarize(cases = sum(cases),
            deaths = sum(deaths)) %>%
  pivot_longer(cols = c('cases', 'deaths')) -> covid_region %>%
p1 = ggplot(covid_region, aes(x = date, y = value)) +
  geom_line(aes(col = region)) +
  facet_grid(name~region, scale = "free_y") +
  labs(title = "Cumulative Cases and Deaths per US Region",
       x = "Date",
       y = "Daily Cumulative Count",
       subtitle = "COVID-19 Data Source: NY-Times",
       caption = "Daily Exercise 07") +
  ggthemes::theme_fivethirtyeight() +
    theme(legend.position = "NA")
ggsave(p1, file = "img/day07.png")

