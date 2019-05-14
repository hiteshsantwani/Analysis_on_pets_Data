install.packages("ggplot2")
library('ggplot2')

df = read.csv('pets.csv', header=TRUE, sep=",")

p <- ggplot(df, aes(df$Kind, df$Age))
p + geom_boxplot(aes(colour = df$Kind))



returnPets <- function(x) {
  
  result <- df[which(df$OwnerID == x), ]
  
  return(result[, "Name"])
}


# invoking the function 
x <- 4378
y <- returnPets(x)
y

