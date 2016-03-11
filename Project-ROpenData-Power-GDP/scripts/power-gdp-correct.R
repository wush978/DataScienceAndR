power.df3 <-
  power.df2 %>%
  mutate(id2 = translation.gdp[id]) %>%
  filter(!is.na(id2)) %>%
  group_by(year, id2) %>%
  summarise(power = sum(power), name = paste(name, collapse = ","))

gdp.df3 <- 
  gdp.df2 %>%
  mutate(id2 = translation.gdp[id]) %>%
  group_by(year, id2) %>%
  summarise(gdp = sum(gdp))

power.gdp <- inner_join(power.df3, gdp.df3, c("year", "id2")) %>%
  mutate(eff = gdp / power) %>%
  as.data.frame()
