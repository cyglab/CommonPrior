rm(list=ls())   # 

library(lme4) 
library(lmerTest) 
 
data <- read.csv("Y:\\Working\\MyPaper\\趋中效应行为202010_DSF\\Experiment1\\DataAnalysis\\20230826\\lmmPSEaTe.csv")
names(data) <-c("sub","Contxt","Dur","PSE","aTe")


mod1 <- lmer(PSE ~ Dur + Contxt + (1|sub) + (0 + Dur + Contxt|sub), data=data, REML=T)
            
summary(mod1)
anova(mod1)
dataClass = predict(mod1)

write.csv(dataClass,file = "Y:\\Working\\MyPaper\\趋中效应行为202010_DSF\\Experiment1\\DataAnalysis\\20230826\\PSEpre.csv", row.names = F)


               