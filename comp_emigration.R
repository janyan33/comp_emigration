
################ Compare the per-capita occurrence of 4 emigration behaviors (no. of tansportees, no. of scouts, no. of RTRs, and no. of FTRs) between Leptothorax and Temnothorax ################   

dat2 <- read.csv("comp_emigration_fullR.csv", header=T)

library(nlme)
d7<-dat2[complete.cases(dat2$adult_transports_percapita), ]
m1 = lm(adult_transports_percapita ~ genus_group + latitude + workers + parasite, data = d7)
summary(m1)
m1 = lm(scout/workers ~ genus_group + latitude + workers + parasite, data = d7)
summary(m1)
m1 = lm(RTR/workers ~ genus_group + latitude + workers + parasite, data = d7)
summary(m1)
m1 = lm(FTR/workers ~ genus_group + latitude + workers + parasite, data = d7)
summary(m1)


################ Load data on the relative timing of recruitment acts during emigrations #####################  

l <- read.csv("l.csv", header=T) # Read Leptothorax data (excluding Harpagoxenus)
t <- read.csv("t.csv", header=T) # Read Temnothorax data
lgg <- read.csv("lgg.csv", header=T) # Read Leptothorax data (including Harpagoxenus)
Pratt <- read.csv("Pratt.csv", header=T) # Read T. curvispinosus timing data (Pratt)
Pratt <- subset(Pratt, select=c("Time", "Behavior", "colony_id"))

tl = subset(l, Behavior == "Transport")
tt = subset(t, Behavior == "Transport")
btl = subset(l, Behavior == "Brood transport")
btt = subset(t, Behavior == "Brood transport")
ftrl = subset(l, Behavior == "Tandem run")
ftrt = subset(t, Behavior == "Tandem run")
rtrl = subset(l, Behavior == "Reverse tandem run")
rtrt = subset(t, Behavior == "Reverse tandem run")

Pratt_tr<-subset(Pratt, Behavior == "FTR")
Pratt_rtr<-subset(Pratt, Behavior == "RTR")
Pratt_ta<-subset(Pratt, Behavior == "TA")
Pratt_tb<-subset(Pratt, Behavior == "TB")

tl = subset(tl, select=c("Time", "colony_id"))
tt = subset(tt, select=c("Time", "colony_id"))
btl = subset(btl, select=c("Time", "colony_id"))
btt = subset(btt, select=c("Time", "colony_id"))
ftrl = subset(ftrl, select=c("Time", "colony_id"))
ftrt = subset(ftrt, select=c("Time", "colony_id"))
rtrl = subset(rtrl, select=c("Time", "colony_id"))
rtrt = subset(rtrt, select=c("Time", "colony_id"))

Pratt_tr<-subset(Pratt_tr, select=c("Time", "colony_id"))
Pratt_rtr<-subset(Pratt_rtr, select=c("Time", "colony_id"))
Pratt_ta<-subset(Pratt_ta, select=c("Time", "colony_id"))
Pratt_tb<-subset(Pratt_tb, select=c("Time", "colony_id"))

################ Relative timing of recruitment acts in Leptothorax vs.Temnothorax ###############
library(gdata)
combg<-combine(tt,tl)
m1 <- lme(Time ~ source ,random=~1|colony_id,data=combg) # Are the relative times of adult transports different between Temnothorax and Leptothorax?
summary(m1)

combg<-combine(btt,btl)
m1 <- lme(Time ~ source ,random=~1|colony_id,data=combg) # Are the relative times of brood transports different between Temnothorax and Leptothorax?
summary(m1)

combg<-combine(ftrt,ftrl)
m1 <- lme(Time ~ source ,random=~1|colony_id,data=combg) # Are the relative times of FTRs different between Temnothorax and Leptothorax?
summary(m1)

combg<-combine(rtrt,rtrl)
m1 <- lme(Time ~ source ,random=~1|colony_id,data=combg) # Are the relative times of RTRs different between Temnothorax and Leptothorax?
summary(m1)


################ Relative timing of Temnothorax recruitment acts ##############
combg<-combine(ftrt,rtrt)
m1 <- lme(Time ~ source ,random=~1|colony_id,data=combg) # Are the relative times of FTRs precede RTRs in Temnothorax?
summary(m1)

combg<-combine(rtrt,btt)
m1 <- lme(Time ~ source ,random=~1|colony_id,data=combg) # Do the relative times of RTRs precede brood transports in Temnothorax?
summary(m1)

combg<-combine(btt,tt)
m1 <- lme(Time ~ source ,random=~1|colony_id,data=combg) # Do the relative times of brood transports precede adult transports in Temnothorax?
summary(m1)


################ Relative timing of Leptothorax recruitment acts ################
combg<-combine(ftrl,rtrl)
m1 <- lme(Time ~ source ,random=~1|colony_id,data=combg)  # Do the relative times of FTRs precede RTRs in Leptothorax?
summary(m1)

combg<-combine(rtrl,btl)
m1 <- lme(Time ~ source ,random=~1|colony_id,data=combg) # Do the relative times of RTRs precede brood transports in Leptothorax?
summary(m1)

combg<-combine(btl,tl)
m1 <- lme(Time ~ source ,random=~1|colony_id,data=combg) # Do the relative times of brood transports precede adult transports in Leptothorax?
summary(m1)


################ Relative timing of T. curvispinosus (from Pratt et. al. 2005) recruitment acts 
combg<-combine(Pratt_tr,Pratt_rtr)
m1 <- lme(Time ~ source ,random=~1|colony_id,data=combg)  # Do the relative times of FTRs precede RTRs in T. curvispinosus?
summary(m1)

combg<-combine(Pratt_rtr,Pratt_tb)
m1 <- lme(Time ~ source ,random=~1|colony_id,data=combg) # Do the relative times of RTRs precede brood transports in T. curvispinosus?
summary(m1)

combg<-combine(Pratt_tb,Pratt_ta)
m1 <- lme(Time ~ source ,random=~1|colony_id,data=combg) # Do the relative times of brood transports precede adult transports in T. curvispinosus?
summary(m1)


################ Relative timing of recruitment acts in Temnothorax (this study) T. curvispinosus (Pratt 2005)   
combg<-combine(Pratt_ta,tt)
m1 <- lme(Time ~ source ,random=~1|colony_id,data=combg) # Are the relative times of adult transports different between Temnothorax (this study) T. curvispinosus (Pratt 2005)?
summary(m1)

combg<-combine(Pratt_tb,btt)
m1 <- lme(Time ~ source ,random=~1|colony_id,data=combg) # Are the relative times of brood transports different between Temnothorax (this study) T. curvispinosus (Pratt 2005)?
summary(m1)

combg<-combine(Pratt_tr,ftrt)
m1 <- lme(Time ~ source ,random=~1|colony_id,data=combg) # Are the relative times of FTRs different between Temnothorax (this study) T. curvispinosus (Pratt 2005)?
summary(m1)

combg<-combine(Pratt_rtr,rtrt)
m1 <- lme(Time ~ source ,random=~1|colony_id,data=combg) # Are the relative times of RTRs different between Temnothorax (this study) T. curvispinosus (Pratt 2005)?
summary(m1)


ks.test(tt$Time, tl$Time) # Do the distributions of the relative timing of adult transports differ between the Temnothorax and Leptothorax colonies in this study?  

lggt = subset(lgg, Behavior == "Transport")
ks.test(tt$Time, lggt$Time) 

ks.test(Pratt_ta$Time, tt$Time) 
ks.test(Pratt_ta$Time, tl$Time)



###################### obtain per-capita values for the three T. curvispinosus emigrations from Pratt's data (used in Figure 1) #################

Pratt <- read.csv("T.curvispinosus emigrations Pratt.csv", header=T)
Pratt <- subset(Pratt, Treatment == "Forced")
Pratt <- subset(Pratt, Nest == "Mediocre")
Pratt <- subset(Pratt, Distance == 15)

library(pracma)
transport_pc<-NULL
q<-1
for (i in unique(Pratt$Index)) {
  
  colony = subset(Pratt, Index == i)
  
  transport_pc[q]<-nrow(subset(colony, Behavior == "BC"))/(nlevels(as.factor(colony$Ant)) + nrow(subset(colony, Behavior == "BC" & Ant == "****"))) # estimate colony size as described in the methods (No. of unique individuals + unmarked transportees)
  
  q<-q+1
}

transport_pc<-as.data.frame(transport_pc)


library(pracma)
FTR_pc<-NULL
q<-1
for (i in unique(Pratt$Index)) {
  
  colony = subset(Pratt, Index == i)

  FTR_pc[q]<-nrow(subset(colony, Behavior == "FTR"))/(nlevels(as.factor(colony$Ant)) + nrow(subset(colony, Behavior == "BC" & Ant == "****")))
  
  q<-q+1
  
}

FTR_pc<-as.data.frame(FTR_pc)

library(pracma)
RTR_pc<-NULL
q<-1
for (i in unique(Pratt$Index)) {
  
  colony = subset(Pratt, Index == i)

  RTR_pc[q]<-nrow(subset(colony, Behavior == "RTR"))/(nlevels(as.factor(colony$Ant)) + nrow(subset(colony, Behavior == "BC" & Ant == "****")))
  
  q<-q+1
  
}

RTR_pc<-as.data.frame(RTR_pc)
