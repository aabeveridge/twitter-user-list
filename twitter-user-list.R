library(tidyverse)
library(ndjson)

##############################################################################################################################
# MassMine commands
# ./massmine --task=twitter-stream --geo=-171.791110603, 18.91619, -66.96466, 71.3577635769 --lang=en --output=us-stream.json
# ./massmine --task=twitter-user --user=[comma-list] --count=3600
##############################################################################################################################

# convert tweets json to data.frame/tibble
tweets <- stream_in('taco-tues.json') %>%
  as_tibble()

# arrange data.frame according to most tweets by user, descending order
tweets <- tweets %>%
  arrange(desc(user.statuses_count))

# explore results
tweets %>%
  select(user.screen_name, user.statuses_count)

# create a list of top 50 users to pass to MassMine's twitter-user task
user.list <- paste(as.character(tweets$user.screen_name[1:50]), collapse=", ")
