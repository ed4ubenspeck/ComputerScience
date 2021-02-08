library(tidyverse)
library(GGally)
library(reshape)

data <- read_csv("C:/Users/edaub/Downloads/DataCollection.csv")

data_sum <- data %>%
  group_by(`Content Area`) %>%
  summarize(avg = mean(`POINTS EARNED`))

data_student <- data %>%
  group_by(`LAST NAME`) %>%
  summarize(avg = mean(`POINTS EARNED`))

data_reshape <- data %>%
  select(last_name = `LAST NAME`,
         first_name = `FIRST NAME`,
         content = `Content Area`,
         points = `POINTS EARNED`,
         total_points = `POINTS POSSIBLE`) %>%
  mutate(prop = points/total_points) %>%
  cast(first_name + last_name ~ content, mean)

# average score by question type
ggplot(data, aes(x = `Content Area`,
                     `POINTS EARNED`)) + 
  geom_boxplot()

# scores by student
ggparcoord(data_reshape,
           columns = 3:7, groupColumn = 2) + 
  labs(title = "")
    

# avg scores on assessment type
data_assessment <- data %>%
  group_by(a)


