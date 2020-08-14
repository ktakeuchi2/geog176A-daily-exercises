#Name: Kiki Takeuchi
#Date: 8/11/20
#Purpose of script: To analyze covid data in the US

library(tidyverse)
url = 'https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv'
covid = read_csv(url)
head(covid)

## Question 1:
covid %>%
  filter (date == max(date)) %>%
  group_by(state) %>%
  summarize(cases = sum(cases, na.rm = TRUE)) %>%
  ungroup() %>%
  slice_max(cases, n = 6) %>%
  pull(state) ->
  top_states
gg = covid %>%
  filter(state %in% top_states) %>%
  group_by(state, date) %>%
  summarize(cases = sum(cases)) %>%
  ungroup() %>%
  ggplot(aes(x = date, y = cases, color = state)) +
  geom_line(size = 1) +
  facet_wrap(~state) +
  ggthemes::theme_fivethirtyeight() +
  theme(legend.position = 'NA') +
  labs(title = "Cumulative Case Counts",
       subtitle = "Data Source: NY-Times",
       x = "Date",
       y = "Number of Cases",
       caption = "Daily Exercise 06")
ggsave(gg, file = "img/day06_question01.png")


## Question 2:
gg = covid %>%
  group_by(date) %>%
  summarize(cases = sum(cases)) %>%
  ggplot(aes(x = date, y = cases)) +
  geom_col(color = "blue") +
  geom_line(color = "blue") +
  labs(title = "National Cumulative COVID Case Counts",
       x = "Date",
       y = "Number of Cases",
       caption = "Daily Exercise 06") +
  ggthemes::theme_fivethirtyeight()
ggsave(gg, file = "img/day06_question02.png")

