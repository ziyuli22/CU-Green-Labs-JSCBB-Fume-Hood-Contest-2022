#Clears everything from the work space
rm(list=ls(all=TRUE))

#reading the file
raffle <- read.delim("https://raw.githubusercontent.com/ziyuli22/CU-Green-Labs-JSCBB-Fume-Hood-Contest-2022/main/JSCBB_Contest_2022_Raffle.txt", header = TRUE, sep = "\t")
#compute probabilities of each entry
calc_prob <- raffle$Tickets/sum(raffle$Tickets)

set.seed(1234) #setting seed

###Run only the following to draw a new winner###
winner <- raffle[sample(nrow(raffle), 1, prob = calc_prob), ]
cat("The winning ticket is", winner$Type, winner$ID,"belonging to the", 
    winner$Lab, "Lab. They had", winner$Tickets, "smiley stickers on this contest card.")
###Run only the above to draw a new winner###


###DO NOT RUN##
#test to see this works properly with an example
test <- raffle[sample(nrow(raffle), 100000, prob = calc_prob,replace = TRUE), ]
#we know that the ID = 605 has 0 tickets, so this entry should not win even once, check this
test[test$ID == 605,] #outputs nothing, no rows has this drawn. This is good
#we know that the ID = 604 has 9 tickets, with probability 9/all tickets. Let's check this
nrow(test[test$ID == 604,])/100000
raffle[raffle$ID == 604,]$Tickets/sum(raffle$Tickets) #this roughly checks out, they are almost equal
