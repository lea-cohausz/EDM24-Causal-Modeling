############################################################################
################## EDM '24 Tutorial: Causal Modeling #######################
############################################################################

############################# Manual Modeling ##############################

# to model manually: https://www.dagitty.net/dags.html or install it here
# install.packages("dagitty")

# load dagitty
library(dagitty)

# specify network
example_dag <- dagitty("dag{
                   math_aptitude -> course_c
                   math_aptitude -> high_school_math}
                   ")
plot(example_dag)

# making the graph pretty
coordinates(example_dag) <- list(
  x = c(math_aptitude = 0, high_school_math = 0, course_c = 0),
  y = c(math_aptitude = 0, high_school_math = -1, course_c = 1)
)

plot(example_dag)


############################ Structure Learning ############################
# install.packages("bnlearn")

# load package
library(bnlearn)

# load data, if you get an error, manually set the working directory
# setwd("where/my/data/is/located)
data <- read.csv("data_for_the_tutorial.csv")
data <- as.data.frame(unclass(data),stringsAsFactors=TRUE)

# use bnlearn's pc-stable to learn the structure from data
bn.pc <- pc.stable(data)
plot(bn.pc)

# use bnlearn's hill climber to learn the structure from data
bn.hc <- hc(data, score = "bic")
plot(bn.hc)

# removing math_aptitude and testing again
data$math_aptitude <- NULL
bn.hc <- hc(data, score = "bic")
plot(bn.hc)

# explicitly providing background knowledge
blacklist_data <- data.frame(
  FROM = c(), 
  TO = c(),
  stringsAsFactors = FALSE
)

bn.hc <- hc(data, blacklist = blacklist_data)
plot(bn.hc)

