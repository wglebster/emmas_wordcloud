library(tidytext)
library(dplyr)
library(RColorBrewer)
library(wordcloud2)
library(wordcloud)
library(text2vec)
#libraries to save(export) generated wordclouds 
library(webshot)
library(htmlwidgets)

#create vector of text
word_vec <- c("et, et, et, et, et, et, et, et, et, et, et, et, et, et, et, et, et, et, et, et, et, et, et, et, odio, pellentesque, diam, volutpat, commodo, sed, odio, pellentesque, diam, volutpat, commodo, sed, odio, pellentesque, diam, volutpat, commodo, sed, odio, pellentesque, diam, volutpat, commodo, sed, odio, pellentesque, diam, volutpat, commodo, sed, odio, pellentesque, diam, volutpat, commodo, sed, odio, pellentesque, diam, volutpat, commodo, sed, odio, pellentesque, diam, volutpat, commodo, sed, odio, pellentesque, diam, volutpat, commodo, sed, odio, pellentesque, diam, volutpat, commodo, sed, egestas, egestas, fringilla, phasellus, faucibus, scelerisque, eleifend, donec, pretium, vulputate, sapien, nec, sagittis, aliquam, malesuada, bibendum, arcu, vitae, elementum, curabitur, vitae, nunc, sed, velit, dignissim, sodales, ut, eu, sem, integer, vitae, justo, eget, magna, fermentum, iaculis, eu, non, diam, phasellus, vestibulum, lorem, sed, risus, egestas, egestas, fringilla, phasellus, faucibus, scelerisque, eleifend, donec, pretium, vulputate, sapien, nec, sagittis, aliquam, malesuada, bibendum, arcu, vitae, elementum, curabitur, vitae, nunc, sed, velit, dignissim, sodales, ut, eu, sem, integer, vitae, justo, eget, magna, fermentum, iaculis, eu, non, diam, phasellus, vestibulum, lorem, sed, risus, egestas, egestas, fringilla, phasellus, faucibus, scelerisque, eleifend, donec, pretium, vulputate, sapien, nec, sagittis, aliquam, malesuada, bibendum, arcu, vitae, elementum, curabitur, vitae, nunc, sed, velit, dignissim, sodales, ut, eu, sem, integer, vitae, justo, eget, magna, fermentum, iaculis, eu, non, diam, phasellus, vestibulum, lorem, sed, risus, egestas, egestas, fringilla, phasellus, faucibus, scelerisque, eleifend, donec, pretium, vulputate, sapien, nec, sagittis, aliquam, malesuada, bibendum, arcu, vitae, elementum, curabitur, vitae, nunc, sed, velit, dignissim, sodales, ut, eu, sem, integer, vitae, justo, eget, magna, fermentum, iaculis, eu, non, diam, phasellus, vestibulum, lorem, sed, risus")

#create dataframe with one column for all words
text <- tibble(words = word_vec, 
               id = 1)

#manipulate dataframe by unnesting words one word per row, count number of times each word appears
#in the vector
words_df <- text %>%
  unnest_tokens(word, words, to_lower = FALSE) %>%
  group_by(word) %>%
  summarise(count = n()) %>%
  arrange(desc(count))
words_df

#generate firs wordcloud with almost default settings, size = 1 is not default.
wordcloud4 <- wordcloud2(data = words_df, 
                         size = 1)
wordcloud4

# create a custom colour palette.
color2 <- c("red", "green", "blue", "purple", "yellow", "orange")

#create second wordcloud using custom color and ensuring that color is applied to each word in the 
#cloud using rep_len().
wordcloud5 <- wordcloud2(data = words_df, 
                         size = 1, 
                         color = rep_len(color2, nrow(words_df)))
wordcloud5

##export wordcloud

saveWidget(wordcloud5, "tmp.html", selfcontained = FALSE)
webshot("tmp.html", "wordcloud.png", delay = 5, vwidth = 480, vheight = 480)

