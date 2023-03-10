# ---------------------------------
# libraries
# ---------------------------------
# install.packages(c("arm", "car", "codebook", "coefplot", "tidyverse", "utils"))
# install.packages(c("datasets", "devtools", "dplyr", "e1071", "foreign"))
# install.packages(c("ggplot2", "ggpubr", "ggthemes", "grid", "gridExtra", "plotrix"))
# install.packages(c("plyr", "psych", "RColorBrewer", "reshape", "rstatix"))
# install.packages(c("haven", "hrbrthemes", "MASS", "moments", "pastecs"))
# install.packages("Rcmdr")
library(arm)
library(car); library(codebook); library(coefplot)
library(datasets); library(devtools); library(dplyr)
library(e1071)
library(foreign)
library(ggplot2); library(ggpubr); library(ggtext); library(ggthemes); library(grid); library(gridExtra)
library(haven); library(hrbrthemes)
library(MASS); library(moments)
library(pastecs); library(plotrix); library(plyr); library(psych)
library(RColorBrewer); library(reshape); library(rstatix)
library(tidyverse)
library(utils)
library(Rcmdr) # do not load unless needed, messes with exporting plots

# ---------------------------------
#   set working directory
# ---------------------------------
setwd("/home/visnu/MEGA/projects/higherStudies/c_bangladesh/MSc BRACU completed/biotechnology/04_spring_2013/thesis_550_A/manuscript_files_t3ss/data"); getwd()

# ---------------------------------
#   list files in dir 
# ---------------------------------
dir()

# ---------------------------------
#   import data
# ---------------------------------
t3ss <- read.csv(file.choose(), header=T)
t3ssTmp <- read.csv(file.choose(), header=T)
t3ss <- read.delim(file.choose(), header = T)
t3ss <- read.spss(file.choose(), header = T)
t3ss <- read.dta(file.choose())


# ---------------------------------
#   others 
# ---------------------------------
attach(t3ss); names(t3ss); View(t3ss)
# attach(t3ssTmp); names(t3ssTmp); View(t3ssTmp)
# attach(t3ssMerged); names(t3ssMerged); View(t3ssMerged)
dim(t3ss)
str(t3ss)

# ---------------------------------
#   merging data sets 
# ---------------------------------
t3ssMerged <- merge(t3ss, t3ssTmp, by = "lab_id", all.x = T)


# -------------------------------
#   reorder
# -------------------------------
t2 <- t3ss[with(t3ss, order(-lab_id)),] # "-" for descending 
# t2 <- t3ss[with(t3ss, order(ID,Date,Time)),]


# -------------------------------
#   export data
# ---------------------------------
write.table(t3ssMerged, file = "tmp.csv", sep = ",", row.names = F)

# ---------------------------------
#   subsetting 
# ---------------------------------
t2 <- t3ss %>% select(lab_ID, age_mon, 
                      bcg, dpt_1st, dpt_2nd, dpt_3rd, hib_1st, hib_2nd, hib_3rd, 
                      pol_1st, pol_2nd, pol_3rd, measl, hepa_1st, hepa_2nd, hepa_3rd, 
                      rota, vibrio, vc_n_013, V_INABA, v_01_oga)

t3ssReg <- subset(t3ss, select = c(lab_id, cf_temp_fever_01))

# ---------------------------------
#   conditional variable 
# ---------------------------------
t3ss$reg_ial <- t3ss$lab_ial_01
t3ss$reg_toxin <- ifelse(t3ss$lab_set_01 == 1 | t3ss$lab_sen == 1 , 1, 0)
t3ss$reg_virB <- t3ss$lab_virB
t3ss$reg_ipaBCD_ipgC <- ifelse(t3ss$lab_ipaBCD_01 == 1 & t3ss$lab_ipgC == 1 , 1, 0)
t3ss$reg_ipgB1_spa15 <- ifelse(t3ss$lab_ipgB1_01 == 1 & t3ss$lab_spa15 == 1 , 1, 0)
t3ss$reg_ipgA_icsB <- ifelse(t3ss$lab_ipgA == 1 & t3ss$lab_icsB_01 == 1 , 1, 0)
t3ss$reg_ipgD_ipgE <- ifelse(t3ss$lab_ipgD_01 == 1 & t3ss$lab_ipgE == 1 , 1, 0)
t3ss$reg_ipgF <- t3ss$lab_ipgF_01
t3ss$reg_mxiH_mxiI <- ifelse(t3ss$lab_mxiH_01 == 1 & t3ss$lab_mxiI == 1 , 1, 0)
t3ss$reg_mxiK <- t3ss$lab_mxiK_01
t3ss$reg_mxiE <- t3ss$lab_mxiE_01
t3ss$reg_mxiC <- t3ss$lab_mxiC_01
t3ss$reg_spa47 <- t3ss$lab_spa47_01
t3ss$reg_spa32_spa24 <- ifelse(t3ss$lab_spa32_01 == 1 & t3ss$lab_spa24 == 1 , 1, 0)


# ---------------------------------
#     removing variables 
# ---------------------------------
t3ss$dis_cid <- NULL
t3ss$ho_mucoid <- NULL
t3ss$ho_bloody <- NULL
t3ss$ho_vomiting <- NULL
t3ss$ho_abd_pain <- NULL
t3ss$ho_re_str <- NULL
t3ss$ho_cough <- NULL
t3ss$ho_fever <- NULL
t3ss$ho_convul <- NULL
t3ss$ho_measles <- NULL

t3ss$cf_mod_sev_dis <- NULL
t3ss$cf_temp_fever <- NULL
t3ss$cf_eye_sunken <- NULL
t3ss$cf_dry_mouth <- NULL
t3ss$cf_skin_pinch_slow <- NULL
t3ss$cf_restless <- NULL
t3ss$cf_dh <- NULL
t3ss$cf_ped_ede <- NULL
t3ss$cf_rec_pro <- NULL


# ---------------------------------
#   recoding
# ---------------------------------
t3ss$lab_p140 <- recode(t3ss$lab_p140, "Positive" = 1, "Negative" = 0)
t3ss$lab_ipaH <- recode(t3ss$lab_ipaH, "Positive" = 1, "Negative" = 0)
t3ss$lab_ial_01 <- recode(t3ss$lab_ial_01, "Positive" = 1, "Negative" = 0)
t3ss$lab_set1A <- recode(t3ss$lab_set1A, "Positive" = 1, "Negative" = 0)
t3ss$lab_set1B <- recode(t3ss$lab_set1B, "Positive" = 1, "Negative" = 0)
t3ss$lab_set_01 <- recode(t3ss$lab_set_01, "Positive" = 1, "Negative" = 0)
t3ss$lab_sen <- recode(t3ss$lab_sen, "Positive" = 1, "Negative" = 0)
t3ss$lab_virB_01 <- recode(t3ss$lab_virB_01, "Positive" = 1, "Negative" = 0)
t3ss$lab_ipaBCD_01 <- recode(t3ss$lab_ipaBCD_01, "Positive" = 1, "Negative" = 0)
t3ss$lab_ipgC <- recode(t3ss$lab_ipgC, "Positive" = 1, "Negative" = 0)
t3ss$lab_ipgB1_01 <- recode(t3ss$lab_ipgB1_01, "Positive" = 1, "Negative" = 0)
t3ss$lab_ipgA <- recode(t3ss$lab_ipgA, "Positive" = 1, "Negative" = 0)
t3ss$lab_icsB_01 <- recode(t3ss$lab_icsB_01, "Positive" = 1, "Negative" = 0)
t3ss$lab_ipgD_01 <- recode(t3ss$lab_ipgD_01, "Positive" = 1, "Negative" = 0)
t3ss$lab_ipgE <- recode(t3ss$lab_ipgE, "Positive" = 1, "Negative" = 0)
t3ss$lab_ipgF_01 <- recode(t3ss$lab_ipgF_01, "Positive" = 1, "Negative" = 0)
t3ss$lab_mxiH_01 <- recode(t3ss$lab_mxiH_01, "Positive" = 1, "Negative" = 0)
t3ss$lab_mxiI <- recode(t3ss$lab_mxiI, "Positive" = 1, "Negative" = 0)
t3ss$lab_mxiK_01 <- recode(t3ss$lab_mxiK_01, "Positive" = 1, "Negative" = 0)
t3ss$lab_mxiE_01 <- recode(t3ss$lab_mxiE_01, "Positive" = 1, "Negative" = 0)
t3ss$lab_mxiC_01 <- recode(t3ss$lab_mxiC_01, "Positive" = 1, "Negative" = 0)
t3ss$lab_spa15 <- recode(t3ss$lab_spa15, "Positive" = 1, "Negative" = 0)
t3ss$lab_spa47_01 <- recode(t3ss$lab_spa47_01, "Positive" = 1, "Negative" = 0)
t3ss$lab_spa32_01 <- recode(t3ss$lab_spa32_01, "Positive" = 1, "Negative" = 0)
t3ss$lab_spa24 <- recode(t3ss$lab_spa24, "Positive" = 1, "Negative" = 0)
t3ss$lab_spa <- recode(t3ss$lab_spa, "Positive" = 1, "Negative" = 0)

t3ss$ho_mucoid_01 <- recode(t3ss$ho_mucoid_01, "Yes" = 1, "No" = 0)
t3ss$ho_bloody_01 <- recode(t3ss$ho_bloody_01, "Yes" = 1, "No" = 0)
t3ss$ho_vomiting_01 <- recode(t3ss$ho_vomiting_01, "Yes" = 1, "No" = 0)
t3ss$ho_abd_pain_01 <- recode(t3ss$ho_abd_pain_01, "Yes" = 1, "No" = 0)
t3ss$ho_re_str_01 <- recode(t3ss$ho_re_str_01, "Yes" = 1, "No" = 0)
t3ss$ho_cough_01 <- recode(t3ss$ho_cough_01, "Yes" = 1, "No" = 0)
t3ss$ho_fever_01 <- recode(t3ss$ho_fever_01, "Yes" = 1, "No" = 0)
t3ss$ho_convul_01 <- recode(t3ss$ho_convul_01, "Yes" = 1, "No" = 0)
t3ss$ho_measles_01 <- recode(t3ss$ho_measles_01, "Yes" = 1, "No" = 0)

t3ss$cf_mod_sev_dis_01 <- recode(t3ss$cf_mod_sev_dis_01, "Yes" = 1, "No" = 0)
t3ss$cf_temp_fever_01 = recode(t3ss$cf_temp_fever_01, "Yes" = 1, "No" = 0)
t3ss$cf_eye_sunken_01 <- recode(t3ss$cf_eye_sunken_01, "Yes" = 1, "No" = 0)
t3ss$cf_dry_mouth_01 <- recode(t3ss$cf_dry_mouth_01, "Yes" = 1, "No" = 0)
t3ss$cf_skin_pinch_slow_01 <- recode(t3ss$cf_skin_pinch_slow_01, "Yes" = 1, "No" = 0)
t3ss$cf_restless_01 <- recode(t3ss$cf_restless_01, "Yes" = 1, "No" = 0)
t3ss$cf_dh_01 <- recode(t3ss$cf_dh_01, "Yes" = 1, "No" = 0)
t3ss$cf_ped_ede_01 <- recode(t3ss$cf_ped_ede_01, "Yes" = 1, "No" = 0)
t3ss$cf_rec_pro_01 <- recode(t3ss$cf_rec_pro_01, "Yes" = 1, "No" = 0)

# ---------------------------------
#     normality check
# ---------------------------------
qqnorm(t3ss$age_mon, pch = 1, frame = F); qqline(t3ss$age_mon, col = "skyblue4", lwd = 1); shapiro.test(t3ss$age_mon) # NN

# -------------------------------
#   Wilcoxon test - two sided 
# -------------------------------
# exact = T, may produce errors if there are ties in ranks of observations 
wilcox.test(t3ss$age_mon ~ t3ss$ho_abd_pain_01, mu = 0, alt = "two.sided", conf.int = T, conf.level = 0.95, paired = F, exact = F, correct = T) 
wilcox.test(t3ss$age_mon ~ t3ss$ho_mucoid_01, mu = 0, alt = "two.sided", conf.int = T, conf.level = 0.95, paired = F, exact = F, correct = T) 
wilcox.test(t3ss$age_mon ~ t3ss$ho_bloody_01, mu = 0, alt = "two.sided", conf.int = T, conf.level = 0.95, paired = F, exact = F, correct = T) # p<0.05
wilcox.test(t3ss$age_mon ~ t3ss$ho_re_str_01, mu = 0, alt = "two.sided", conf.int = T, conf.level = 0.95, paired = F, exact = F, correct = T) # p<0.05
wilcox.test(t3ss$age_mon ~ t3ss$cf_dh_01, mu = 0, alt = "two.sided", conf.int = T, conf.level = 0.95, paired = F, exact = F, correct = T) # p<0.05
wilcox.test(t3ss$age_mon ~ t3ss$ho_cough_01, mu = 0, alt = "two.sided", conf.int = T, conf.level = 0.95, paired = F, exact = F, correct = T) 
wilcox.test(t3ss$age_mon ~ t3ss$cf_mod_sev_dis, mu = 0, alt = "two.sided", conf.int = T, conf.level = 0.95, paired = F, exact = F, correct = T) 
wilcox.test(t3ss$age_mon ~ t3ss$cf_temp_fever_01, mu = 0, alt = "two.sided", conf.int = T, conf.level = 0.95, paired = F, exact = F, correct = T) # p<0.05

t3ss %>% group_by(ho_bloody_01) %>% get_summary_stats(age_mon, type = "median_iqr")
t3ss %>% group_by(ho_re_str_01) %>% get_summary_stats(age_mon, type = "median_iqr")
t3ss %>% group_by(cf_dh_01) %>% get_summary_stats(age_mon, type = "median_iqr")
t3ss %>% group_by(cf_temp_fever_01) %>% get_summary_stats(age_mon, type = "median_iqr")

# ---------------------------------
# two-way contingency table
# ---------------------------------
continTable <- table(t3ss$ho_abd_pain_01, t3ss$lab_ial_01)
continTable <- table(t3ss$ho_mucoid_01, t3ss$lab_set_01)
continTable <- table(t3ss$ho_bloody_01, t3ss$lab_set_01)
continTable <- table(t3ss$ho_re_str_01, t3ss$lab_set_01)
continTable <- table(t3ss$ho_mucoid_01, t3ss$lab_sen); continTable
continTable <- table(t3ss$ho_bloody_01, t3ss$lab_sen); continTable
continTable <- table(t3ss$ho_re_str_01, t3ss$lab_sen); continTable
continTable <- table(t3ss$lab_ipaBCD_01, t3ss$ho_abd_pain_01)
continTable <- table(t3ss$lab_set_01, t3ss$cf_temp_fever_01)
continTable <- table(t3ss$lab_set_01, t3ss$cf_dh)
continTable <- table(t3ss$lab_spa24, t3ss$ho_re_str_01)
continTable <- table(t3ss$lab_set_01, t3ss$ho_cough_01)
continTable <- table(t3ss$lab_ipgD_01, t3ss$ho_cough_01)
continTable <- table(t3ss$lab_set_01, t3ss$cf_mod_sev_dis)

rownames(continTable) <- c("no_pain", "abd_pain")
rownames(continTable) <- c("non_mucoid", "mucoid")
rownames(continTable) <- c("non_bloody", "bloody"); continTable
rownames(continTable) <- c("no_straining", "straining"); continTable

colnames(continTable) <- c("No", "Yes"); continTable

# relative frequencies percentage 
prop.table(continTable)*100
prop.table(continTable, 1)*100 # conditional, row-wise
prop.table(continTable, 2)*100 # conditional, column-

# -------------------------------
#   Chi-square test of independence
# ---------------------------------
chisq.test(continTable)
chisq.test(continTable)$observed
chisq.test(continTable)$expected

# Monte Carlo simulation as expected freq <5
chisq.test(continTable, simulate.p.value = T, B = 10000) 

# -------------------------------
#   Fisher's Exact test
# -------------------------------
fisher.test(continTable)


# -------------------------------
#   Binary logistic regression - unadjusted
# -------------------------------
t3ssRegUnadj <- glm(ho_re_str_01 ~ lab_sen, family = "binomial", data = t3ss); summary(t3ssRegUnadj)
# final models - unadjusted 
t3ssRegUnadj <- glm(cf_temp_fever_01 ~ reg_toxin, family = "binomial", data = t3ss); summary(t3ssRegUnadj) 
t3ssRegUnadj <- glm(ho_bloody_01 ~ reg_toxin, family = "binomial", data = t3ss) 
t3ssRegUnadj <- glm(ho_bloody_01 ~ reg_ipgA_icsB, family = "binomial", data = t3ss); summary(t3ssRegUnadj)  
t3ssRegUnadj <- glm(ho_cough_01 ~ reg_toxin, family = "binomial", data = t3ss)
t3ssRegUnadj <- glm(ho_mucoid_01 ~ reg_toxin, family = "binomial", data = t3ss)
t3ssRegUnadj <- glm(ho_mucoid_01 ~ reg_mxiC, family = "binomial", data = t3ss); summary(t3ssRegUnadj) 
t3ssRegUnadj <- glm(ho_re_str_01 ~ reg_toxin, family = "binomial", data = t3ss)
t3ssRegUnadj <- glm(ho_re_str_01 ~ reg_ipgA_icsB, family = "binomial", data = t3ss); summary(t3ssRegUnadj) 
t3ssRegUnadj <- glm(ho_re_str_01 ~ reg_mxiC, family = "binomial", data = t3ss); summary(t3ssRegUnadj) 
t3ssRegUnadj <- glm(ho_re_str_01 ~ reg_ipgB1_spa15, family = "binomial", data = t3ss); summary(t3ssRegUnadj) 


# OR & 95% CI
round(exp(cbind(coef(t3ssRegUnadj), confint(t3ssRegUnadj))), 3)


# -------------------------------
#   Binary logistic regression - adjusted
# -------------------------------

# t3ssRegAdj <- glm(cf_temp_fever_01 ~ reg_ial + reg_toxin + reg_virB +
#                     reg_ipaBCD_ipgC + reg_ipgB1_spa15 + reg_ipgA_icsB +
#                     reg_ipgD_ipgE + reg_ipgF + reg_mxiH_mxiI +
#                     reg_mxiK + reg_mxiE + reg_mxiC +
#                     reg_spa47 + reg_spa32_spa24,
#                   family = "binomial",
#                   data = t3ss); summary(t3ssRegAdj) # Warning message:
# # glm.fit: fitted probabilities numerically 0 or 1 occurred

# # working combinations
# t3ssRegAdj <- glm(ho_bloody_01 ~ reg_ial + reg_toxin + lab_sen + reg_virB +
#                     reg_ipaBCD_ipgC + reg_ipgB1_spa15 + reg_ipgA_icsB +
#                     reg_ipgD_ipgE + reg_ipgF + reg_mxiH_mxiI + reg_mxiK +
#                     reg_mxiE + reg_mxiC + reg_spa47,
#                   family = "binomial" (link="logit"),
#                   data = t3ss); summary(t3ssRegAdj)

# t3ssRegAdj <- glm(ho_bloody_01 ~ reg_ial + reg_toxin + reg_virB + lab_sen + 
#                     reg_ipaBCD_ipgC + reg_ipgB1_spa15 + reg_ipgA_icsB +
#                     reg_ipgD_ipgE + reg_ipgF + reg_mxiH_mxiI + reg_mxiK +
#                     reg_mxiE + reg_spa47 + reg_spa32_spa24,
#                   family = "binomial" (link="logit"), 
#                   data = t3ss); summary(t3ssRegAdj)
# 
# t3ssRegAdj <- glm(ho_bloody_01 ~ reg_ial + reg_toxin + reg_virB + lab_sen + 
#                     reg_ipaBCD_ipgC + reg_ipgB1_spa15 + reg_ipgA_icsB +
#                     reg_ipgD_ipgE + reg_ipgF + reg_mxiH_mxiI + reg_mxiK +
#                     reg_mxiC + reg_spa47 + reg_spa32_spa24,
#                   family = "binomial" (link="logit"), 
#                   data = t3ss); summary(t3ssRegAdj)
# 
# t3ssRegAdj <- glm(ho_cough_01 ~ reg_ial + reg_toxin + reg_virB + lab_sen + 
#                     reg_ipaBCD_ipgC + reg_ipgB1_spa15 + reg_ipgA_icsB +
#                     reg_ipgD_ipgE + reg_mxiH_mxiI + reg_mxiK +
#                     reg_mxiE + reg_mxiC + reg_spa47 + reg_spa32_spa24,
#                   family = "binomial" (link="logit"),
#                   data = t3ss); summary(t3ssRegAdj)
# 
# t3ssRegAdj <- glm(ho_cough_01 ~ reg_ial + reg_toxin + reg_virB + lab_sen + 
#                     reg_ipaBCD_ipgC + reg_ipgA_icsB +
#                     reg_ipgD_ipgE + reg_ipgF + reg_mxiH_mxiI + reg_mxiK +
#                     reg_mxiE + reg_mxiC + reg_spa47 + reg_spa32_spa24,
#                   family = "binomial" (link="logit"),
#                   data = t3ss); summary(t3ssRegAdj)
# 
# t3ssRegAdj <- glm(ho_mucoid_01 ~ reg_ial + reg_toxin + reg_virB + lab_sen + 
#                     reg_ipaBCD_ipgC + reg_ipgB1_spa15 + reg_ipgA_icsB +
#                     reg_ipgD_ipgE + reg_ipgF + reg_mxiH_mxiI + reg_mxiK +
#                     reg_mxiC + reg_spa47 + reg_spa32_spa24,
#                   family = "binomial" (link="logit"),
#                   data = t3ss); summary(t3ssRegAdj)
# 
# t3ssRegAdj <- glm(ho_mucoid_01 ~ reg_ial + reg_toxin + reg_virB + lab_sen + 
#                     reg_ipaBCD_ipgC + reg_ipgB1_spa15 + reg_ipgA_icsB +
#                     reg_ipgD_ipgE + reg_ipgF + reg_mxiH_mxiI + reg_mxiK +
#                     reg_mxiE + reg_spa47 + reg_spa32_spa24,
#                   family = "binomial" (link="logit"),
#                   data = t3ss); summary(t3ssRegAdj)
# 
# t3ssRegAdj <- glm(ho_mucoid_01 ~ reg_ial + reg_toxin + reg_virB + lab_sen + 
#                     reg_ipaBCD_ipgC + reg_ipgB1_spa15 + reg_ipgA_icsB +
#                     reg_ipgD_ipgE + reg_ipgF + reg_mxiH_mxiI + reg_mxiK +
#                     reg_mxiE + reg_mxiC + reg_spa47,
#                   family = "binomial" (link="logit"),
#                   data = t3ss); summary(t3ssRegAdj)
# 
# t3ssRegAdj <- glm(ho_re_str_01 ~ reg_ial + reg_toxin + reg_virB + lab_sen + 
#                     reg_ipaBCD_ipgC + reg_ipgB1_spa15 + reg_ipgA_icsB +
#                     reg_ipgD_ipgE + reg_ipgF + reg_mxiH_mxiI + reg_mxiK +
#                     reg_mxiC + reg_spa47 + reg_spa32_spa24,
#                   family = "binomial" (link="logit"),
#                   data = t3ss); summary(t3ssRegAdj)
# 
# t3ssRegAdj <- glm(ho_re_str_01 ~ reg_ial + reg_toxin + reg_virB + lab_sen + 
#                     reg_ipaBCD_ipgC + reg_ipgB1_spa15 + reg_ipgA_icsB +
#                     reg_ipgD_ipgE + reg_ipgF + reg_mxiH_mxiI + reg_mxiK +
#                     reg_mxiE + reg_spa47 + reg_spa32_spa24,
#                   family = "binomial" (link="logit"),
#                   data = t3ss); summary(t3ssRegAdj)
# 
# t3ssRegAdj <- glm(ho_re_str_01 ~ reg_ial + reg_toxin + reg_virB + lab_sen +
#                     reg_ipaBCD_ipgC + reg_ipgB1_spa15 + reg_ipgA_icsB +
#                     reg_ipgD_ipgE + reg_ipgF + reg_mxiH_mxiI + reg_mxiK +
#                     reg_mxiE + reg_mxiC + reg_spa47,
#                   family = "binomial" (link="logit"),
#                   data = t3ss); summary(t3ssRegAdj)
# 
# summary(t3ssRegAdj)

#   final models
t3ssRegAdj1 <- glm(ho_bloody_01 ~ lab_set_01 + reg_ipgA_icsB, 
                   family = "binomial" (link="logit"), data = t3ss); summary(t3ssRegAdj1)  
t3ssRegAdj2 <- glm(ho_mucoid_01 ~ reg_toxin + reg_mxiC,
                   family = "binomial" (link="logit"), data = t3ss); summary(t3ssRegAdj2) 
t3ssRegAdj3 <- glm(ho_re_str_01 ~ reg_toxin + reg_ipgA_icsB + reg_mxiC + reg_ipgB1_spa15, 
                   family = "binomial" (link="logit"), data = t3ss); summary(t3ssRegAdj3) 

# OR & 95% CI
round(exp(cbind(coef(t3ssRegAdj), confint(t3ssRegAdj))), 3)


# -------------------------------
#   Coefficient plotting - multiple
# -------------------------------
# Thanks to https://github.com/dsparks

# renaming variables for plot 
set <- lab_set_01
ipgA_icsB <- reg_ipgA_icsB
mxiC <- reg_mxiC
ipgB1_spa15 <- reg_ipgB1_spa15

t3ssRegAdj1 <- glm(ho_bloody_01 ~ set + ipgA_icsB, family = "binomial" (link="logit"), data = t3ss) 
t3ssRegAdj2 <- glm(ho_mucoid_01 ~ set + mxiC, family = "binomial" (link="logit"), data = t3ss)
t3ssRegAdj3 <- glm(ho_re_str_01 ~ set + ipgA_icsB + mxiC + ipgB1_spa15, family = "binomial" (link="logit"), data = t3ss)

# Put model estimates into temporary data.frames 
model1Frame <- data.frame(Variable = rownames(summary(t3ssRegAdj1)$coef),
                          Coefficient = summary(t3ssRegAdj1)$coef[, 1],
                          SE = summary(t3ssRegAdj1)$coef[, 2],
                          modelName = "Bloody stool")
model2Frame <- data.frame(Variable = rownames(summary(t3ssRegAdj2)$coef),
                          Coefficient = summary(t3ssRegAdj2)$coef[, 1],
                          SE = summary(t3ssRegAdj2)$coef[, 2],
                          modelName = "Mucoid stool")
model3Frame <- data.frame(Variable = rownames(summary(t3ssRegAdj3)$coef),
                          Coefficient = summary(t3ssRegAdj3)$coef[, 1],
                          SE = summary(t3ssRegAdj3)$coef[, 2],
                          modelName = "Rectal straining")

# Combine these data.frames 
allModelFrame <- data.frame(rbind(model1Frame, model2Frame, model3Frame))  # etc.

# Widths of your confidence intervals 
interval1 <- -qnorm((1-0.9)/2) # 90% multiplier
interval2 <- -qnorm((1-0.95)/2) # 95% multiplier

# Plot 
mPlots <- ggplot(allModelFrame, aes(colour = modelName)) + 
  geom_hline(yintercept = 0, colour = gray(1/2), lty = 3) + 
  geom_linerange(aes(x = Variable, 
                     ymin = Coefficient - SE*interval1, 
                     ymax = Coefficient + SE*interval1), 
                 lwd = 1, position = position_dodge(width = 1/2)) + 
  geom_pointrange(aes(x = Variable, 
                      y = Coefficient, 
                      ymin = Coefficient - SE*interval2, 
                      ymax = Coefficient + SE*interval2), 
                  lwd = 1/2, position = position_dodge(width = 1/2),
                  shape = 21, fill = "WHITE") + 
  coord_flip() + 
  theme_bw() 
# + ggtitle("Comparing several models")

mPlots + theme(axis.text.y = element_text(face = "italic"))

# print(mPlots)  # The trick is position_dodge()


# -------------------------------
#   coefficient plotting - individual 
# -------------------------------

coefplot3 <- coefplot(t3ssRegAdj3, innerCI = 0, outerCI = 1.96, intercept = F,
                      title = "",
                      xlab = "Regression coefficient at 95% CI",
                      ylab = "Predictor genes",
                      decreasing = T,
                      col = "skyblue2",
                      newNames = c(reg_toxin = "set & sen", 
                                   reg_ipgA_icsB = "ipgA & icsB", 
                                   reg_mxiC = "mxiC",
                                   reg_ipgB1_spa15 = "ipgB1 & spa15")) +
  theme(axis.line = element_line(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank()) + 
  geom_point(pch = 21)



# -------------------------------
#   barplots - 3 in 1
# -------------------------------
seroDf <- data.frame(seroNames = c("1b", "1c", "2a", "2b", "3a", "4", "6a"), 
                     seroCount = c(5, 9, 16, 15, 8, 3, 5), 
                     seroPrcnt = c(8.20, 14.75, 26.23, 24.59, 13.14, 4.92, 8.20)); 
seroDf$seroNames <- factor(seroDf$seroNames, levels = c("6a", "4", "3a", "2b", "2a", "1c", "1b"))

cfDf <- data.frame(cfNames = c("Bloody stool", "Mucoid stool", "Rectal straining", "Fever", "Cough"), 
                   cfCount = c(49, 50, 45, 22, 25), 
                   cfPrcnt = c(80.33, 81.97, 73.77, 36.07, 40.98)); 
                    # "Severe disease", "Abdominal pain", "Vomiting", "Dehydration", "Convulsion"
                    # 55, 52, 28, 13, 2
                    # 90.16, 85.24, 45.90, 21.31, 3.28
cfDf$cfNames <- factor(cfDf$cfNames, levels = c("Cough", "Fever", "Rectal straining", "Mucoid stool", "Bloody stool"))
                    # "Convulsion", "Dehydration", "Vomiting", "Abdominal pain", "Severe disease"

gnDf <- data.frame(gnNames = c("p140", 
                               "ipaH", "ial", "set", "sen", "virB", "ipaBCD", "ipgC", "ipgB1", "ipgA", "icsB",
                               "ipgD", "ipgE", "ipgF", "mxiH", "mxiI", "mxiK", "mxiE", "mxiC", "spa15", "spa47", 
                               "spa32", "spa24"),
                   gnCount = c(48, 
                               61, 54, 34, 38, 50, 55, 52, 44, 50, 27, 
                               48, 52, 47, 49, 49, 43, 40, 22, 49, 49, 
                               46, 43), 
                   gnPrcnt = c(78.69, 
                               100, 88.52, 55.74, 62.30, 81.97, 90.16, 85.25, 72.13, 81.97, 44.26, 
                               78.69, 85.25, 77.05, 80.33, 80.33, 70.49, 65.57, 36.07, 80.33, 80.33, 
                               75.41, 70.49))
gnDf$gnNames <- factor(gnDf$gnNames, 
                       levels = c("spa24","spa32", "spa47", "spa15", 
                                  "mxiC", "mxiE", "mxiK", "mxiI", "mxiH", 
                                  "ipgF", "ipgE", "ipgD", "icsB", "ipgA", "ipgB1", "ipgC", "ipaBCD", "virB", 
                                  "sen", "set", "ial", "ipaH", "p140"))

bpSero <- ggplot(data = seroDf, aes(x = seroNames, y = seroPrcnt)) +
  geom_bar(stat = "identity", width = 0.75, fill = "#c8c8c8") +
  geom_text(aes(label = seroPrcnt), hjust = 1.12, vjust = 0.5, colour = "#333333") + 
  theme_minimal() +
  theme(legend.position="none") +
  xlab("Serotypes") +
  ylab("Percentage (%)") +
  coord_flip() +
  scale_y_continuous(breaks = seq(0, 30, 10), limits = c(0, 27)) 

bpCf <- ggplot(data = cfDf, aes(x = cfNames, y = cfPrcnt)) +
  geom_bar(stat = "identity", width = 0.75, fill = "#ee9ca7") +
  geom_text(aes(label = cfPrcnt), hjust = 1.12, vjust = 0.5, colour = "#333333") + 
  theme_minimal() + 
  theme(legend.position="none") +
  xlab("Clinical features") +
  ylab("Percentage (%)") +
  coord_flip() +
  scale_y_continuous(breaks = seq(0, 100, 10), limits = c(0, 82))

bpGn <- ggplot(data = gnDf, aes(x = gnNames, y = gnPrcnt)) +
  geom_bar(stat = "identity", width = 0.77, fill = "#92c6f3") +
  geom_text(aes(label = gnPrcnt), hjust = 1.08, vjust = 0.5, colour = "#333333") + 
  # scale_color_grey() +
  theme_minimal() +
  # theme_classic() +
  # scale_fill_grey() +
  # scale_fill_brewer(palette="Blues") +
  # scale_color_manual(values=seroColor) + 
  theme(legend.position="none") +
  # labs(title = "Frequencies of different serotypes") +
  xlab("Genes and Plasmid (p140)") +
  ylab("Percentage (%)") +
  coord_flip() +
  scale_y_continuous(breaks = seq(0, 100, 10), limits = c(0, 100)) + 
  theme(axis.text.y = element_text(face = "italic"))

grid.arrange(bpSero, bpCf, bpGn, 
             widths = c(1, 1.63), 
             layout_matrix = cbind(c(1,2), c(3,3))) 

