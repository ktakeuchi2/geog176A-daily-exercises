#Name: Kiki Takeuchi
#Date: 8/11/20
#Purpose of script: To analyze covid data in the US


library(tidyverse)
url = 'https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv'
covid = read_csv(url)
head(covid)

## Question 1:
gg = covid %>%
  filter(date == max(date)) %>%
  group_by(state) %>%
  summarize(cases = sum(cases, na.rm = TRUE)) %>%
  ungroup() %>%
  slice_max(cases, n=6) %>%
  pull(state) ->
  top_states

gg = covid %>%
  filter(state %in% top_states) %>%
  group_by(state, date) %>%
  summarize(cases = sum(cases)) %>%
  ungroup() %>%
  ggplot(aes(x = date, y = cases, color = state)) +
  geom_line() +
  labs(title = "Timeline of the Number of Covid Cases in Top 6 States",
       x = "Date",
       y = "Number of Cases",
       subtitle = "Data Source: NY Times",
       caption = "Daily Exercise 06") +
  facet_wrap(-state) +
  theme_minimal()

ggsave(gg, file = "img/assignment06_question01.png")


## Question 2:
gg = covid %>%
  group_by(date) %>%
  summarize(cases = sum(cases)) %>%
  ungroup() %>%
  ggplot(aes(x = date, y = cases)) +
  geom_col(color = "blue") +
  labs(title = "National Cumulative COVID Case Counts",
      x = "Date",
      y = "Number of Cases",
      caption = "Daily Exercise 06") +
  theme_minimal()

ggsave(gg, file = "img/assignment06_question02.png")

