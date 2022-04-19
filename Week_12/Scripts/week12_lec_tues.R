#### Today we are learning how to work with stringr and word related data ####
#### Created by: Vivian Vy Le ####
#### Updated on: 2022-04-19 ####

#### Load libraries ####
library(here)
library(tidyverse)
library(tidytext)
library(wordcloud2)
library(janeaustenr)

#### learning how to use stringr ####
words <- "This is a string"
words
words_vector <- c("Apples", "Bananas","Oranges")
words_vector

paste("High temp", "Low pH")
paste("High temp", "Low pH", sep = "-")
paste0("High temp", "Low pH")

shapes <- c("Square", "Circle", "Triangle")
paste("My favorite shape is a", shapes)

two_cities <- c("best", "worst")
paste("It was the", two_cities, "of times.")

shapes #vector of shapes
str_length(shapes) #how many letters are in each word?

seq_data<-c("ATCCCGTC")
str_sub(seq_data, start = 2, end = 4) # extract the 2nd to 4th AA
### [1] "TCC"

str_sub(seq_data, start = 3, end = 3) <- "A" # add an A in the 3rd position
seq_data
#[1] ATACCGTCATACCGTC

str_dup(seq_data, times = c(2, 3)) # times is the number of times to duplicate each string
#[1] ATACCGTCATACCGTCATACCGTC

### whitespace
badtreatments<-c("High", " High", "High ", "Low", "Low")
badtreatments
#[1] "High"  " High" "High " "Low"   "Low"

#remove white space
str_trim(badtreatments)
#[1] "High" "High" "High" "Low"  "Low"

#removes the white space from the left
str_trim(badtreatments, side = "left")
#[1] "High"  "High"  "High " "Low"   "Low"

#add a white space to the right side after the 5th character
str_pad(badtreatments, 5, side = "right")

#add a 1 to the right side after the 5th character
str_pad(badtreatments, 5, side = "right", pad = "1")

#### Locale sensitive
#makes everything upper case
x<-"I love R!"
str_to_upper(x)

#makes everything lower case
str_to_lower(x)

#make it title case
str_to_title(x)


#### Pattern matching
data<-c("AAA", "TATA", "CTAG", "GCTT")
str_view(data, pattern = "A")

# detect a specific pattern
str_detect(data, pattern = "A")
str_detect(data, pattern = "AT")

# locate a pattern
str_locate(data, pattern = "AT")


#### regex: metacharacters
#escape in R = two backlashes
vals<-c("a.b", "b.c","c.d")
str_replace(vals, "\\.", " ")

vals<-c("a.b.c", "b.c.d","c.d.e")
#string, pattern, replace
str_replace(vals, "\\.", " ")
#this only replace for the first instance only and not the rest of the data

#string, pattern, replace
str_replace_all(vals, "\\.", " ")


#sequences
#subset the vector to only keep strings with digits
val2<-c("test 123", "test 456", "test")
str_subset(val2, "\\d")

#character class
#count the number of lowercase vowels in each string
str_count(val2, "[aeiou]")

#count any digit
str_count(val2, "[0-9]")


##example: find the phone numbers
strings<-c("550-153-7578",
           "banana",
           "435.114.7586",
           "home: 672-442-6739")
phone <- "([2-9][0-9]{2})[- .]([0-9]{3})[- .]([0-9]{4})"
str_detect(strings, phone)
test<-str_subset(strings, phone)

### think pair share 
test %>%
  str_replace_all("\\.", "-") %>%
  str_replace_all("[a-z]", "") %>%
  str_replace_all("[:]", "") %>%
  str_trim()

#another way to do it
#test %>%
#str_replace_all(pattern = "\\.", replacement = "-") %>% # replace periods with -
#str_replace_all(pattern = "[a-zA-Z]|\\:", replacement = "") %>% # remove all the things we don't want
#str_trim() # trim the white space

#### tidytext
head(austen_books())


original_books <-austen_books() %>%
  group_by(book) %>%
  mutate(line = row_number(),
         chapter = cumsum(str_detect(text, regex("^chapter[\\divxlc]",
                                                 ignore_case = TRUE)))) %>%
  ungroup()
head(original_books)

tidy_books <- original_books %>%
  unnest_tokens(output = word, input = text)
head(tidy_books)
head(get_stopwords()) #remove common words/unnecessary words

cleaned_books<-tidy_books %>%
  anti_join(get_stopwords())
head(cleaned_books)

cleaned_books %>%
  count(word, sort = TRUE)

sent_word_counts <- tidy_books %>%
  inner_join(get_sentiments()) %>%
  count(word, sentiment, sort = TRUE)

sent_word_counts %>%
  filter(n >150) %>%
  mutate(n = ifelse(sentiment == "negative", -n, n)) %>%
  mutate(word = reorder (word, n)) %>%
  ggplot(aes(word, n, fill = sentiment) +
           geom_col() +
           coord_flip() +
           labs(y = "Contribution to sentiment")
         