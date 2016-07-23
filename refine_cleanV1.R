library(tidyr)
library(dplyr)
library(dummies)

clean <- read.csv('refine_original.csv')

#This block was to clean up the names to make them have the correct spelling and to put them in lower case
clean$company <- tolower(clean$company)
clean$company <- gsub('fillips|phillips|phllips|phlips|phillps', 'philips', clean$company)
clean$company <- gsub('akz0|ak zo', 'akzo', clean$company)
clean$company <- gsub('unilver', 'unilever', clean$company)

#This is where I separated the Product Code and Number into its own columns
clean <- separate(clean, Product.code...number, c("product_code", "product_number"))

#I added a product_type column here by mutating the code and the subbing the codes for what they mean.
clean <- mutate(clean, product_type = product_code)

clean$product_type <- gsub("p", "Smartphone", clean$product_type)
clean$product_type <- gsub("v", "TV", clean$product_type)
clean$product_type <- gsub("x", "Laptop", clean$product_type)
clean$product_type <- gsub("q", "Tablet", clean$product_type)

#This line of code was to combine the three location columns into one easy to read column.
clean <- unite(clean, full_address, address:country, sep = ",")

#Here is where I used the dummy package, with it I used the dummy.data.frame to create a table of dummy variables based of the company and product type columns.
clean2 <- clean

clean2 <- dummy.data.frame(clean2, names = c("company", "product_type"), sep = "_")
clean <- bind_cols(clean, clean2)

glimpse(clean)

write.csv(clean, file = "refine_clean.csv")

