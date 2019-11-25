#Importing .xpt file
library(SASxport)
file <- read.xport(file.choose())

#Renaming col names using SQL
library(sqldf) #for writing sql queries in R
string_one <- "SELECT 
file.SEQN AS id , 
file.DIQ010 AS diabetes_status, 
file.DID040 AS diabetes_age , 
file.DIQ160 AS prediabetes_knowledge , 
file.DIQ170 AS health_risk_knowledge , 
file.DIQ172 AS risk_awareness, 
file.DIQ175A AS family_history ,  
file.DIQ175B AS overweight , 
file.DIQ175C AS age , 
file.DIQ175D AS poor_diet , 
file.DIQ175E AS race , 
file.DIQ175F AS baby_over_nine_pounds , 
file.DIQ175G AS no_exercise , 
file.DIQ175H AS high_blood_pressure , 
file.DIQ175I AS high_blood_sugar , 
file.DIQ175J AS high_cholestrol , 
file.DIQ175K AS hypoglycemic , 
file.DIQ175L AS extreme_hunger , 
file.DIQ175M AS numbness, 
file.DIQ175N AS blurred_vision , 
file.DIQ175O AS increased_fatigue , 
file.DIQ175P AS anyone_at_risk , 
file.DIQ175Q AS doctor_warning , 
file.DIQ175R AS other_risk , 
file.DIQ175S AS diabetes_gestational , 
file.DIQ175T AS frequent_urination ,
file.DIQ175U AS thirst , 
file.DIQ175V AS sugar_craving , 
file.DIQ175W AS medication , 
file.DIQ175X AS polycystic_ovarian_syndrome , 
file.DIQ180 AS blood_test_in_3yrs , 
file.DIQ050 AS current_insulin_intake , 
file.DID060 AS insulin_intake_duration ,
file.DIQ060U AS insulin_unit_measure , 
file.DIQ070 AS diabetic_pills_consumption , 
file.DIQ230 AS time_to_specialist , 
file.DIQ240 AS multiple_doctors_diabetes,
file.DID250 AS pastyear_doc_visit , 
file.DID260 AS glucose_check , 
file.DIQ260U AS glucose_unit_measure , 
file.DIQ275 AS pastyear_doc_check , 
file.DIQ280 AS last_A1C_level , 
file.DIQ291 AS A1C_recommended , 
file.DIQ300S AS recent_SBP , 
file.DIQ300D AS recent_DBP , 
file.DID310S AS SBP_recommended , 
file.DID310D AS DBP_recommended , 
file.DID320 AS recent_LDL_number , 
file.DID330 AS LDL_recommended , 
file.DID341 AS pastyear_doc_feetcheck , 
file.DID350 AS feet_check , 
file.DIQ350U AS feet_check_measure ,
file.DIQ360 AS dilated_pupils , 
file.DIQ080 AS retinopathy FROM file"
file <- sqldf(string_one, stringsAsFactors= FALSE)

#Verifying name change 
head(file)
tail(file)
str(file)

#Checking for duplicate entries- No duplicate entries in the data because length(unique(file$id)) and str(file) have the same number of rows.
length(unique(file$id))
str(file)

#Changing data types
#Changing data types of columns to factors
file$diabetes_status <- as.factor(file$diabetes_status)
file$prediabetes_knowledge <- as.factor(file$prediabetes_knowledge)
file$health_risk_knowledge <- as.factor(file$health_risk_knowledge)
file$risk_awareness <- as.factor(file$risk_awareness)
file$family_history <- as.factor(file$family_history)
file$overweight <- as.factor(file$overweight)
file$poor_diet <- as.factor(file$poor_diet)
file$race <- as.factor(file$race)
file$baby_over_nine_pounds <- as.factor(file$baby_over_nine_pounds)
file$no_exercise <- as.factor(file$no_exercise)
file$high_blood_pressure <- as.factor(file$high_blood_pressure)
file$high_blood_sugar <- as.factor(file$high_blood_sugar)
file$hypoglycemic <- as.factor(file$hypoglycemic)
file$doctor_warning <- as.factor(file$doctor_warning)
file$insulin_intake_duration <- as.factor(file$insulin_intake_duration)
file$extreme_hunger <- as.factor(file$extreme_hunger)
file$numbness <- as.factor(file$numbness)
file$blurred_vision <- as.factor(file$blurred_vision)
file$increased_fatigue <- as.factor(file$increased_fatigue)
file$doctor_warning <- as.factor(file$doctor_warning)
file$other_risk <- as.factor(file$other_risk)
file$diabetes_gestational <- as.factor(file$diabetes_gestational)
file$frequent_urination <- as.factor(file$frequent_urination )
file$sugar_craving <- as.factor(file$sugar_craving)
file$thirst <- as.factor(file$thirst)
file$medication <- as.factor(file$medication)
file$polycystic_ovarian_syndrome <- as.factor(file$polycystic_ovarian_syndrome)
file$blood_test_in_3yrs <- as.factor(file$blood_test_in_3yrs)
file$current_insulin_intake <- as.factor(file$current_insulin_intake)
file$diabetic_pills_consumption <- as.factor(file$diabetic_pills_consumption)
file$high_cholestrol <- as.factor(file$high_cholestrol)
file$insulin_unit_measure <- as.factor(file$insulin_unit_measure)
file$glucose_check <- as.factor(file$glucose_check)
file$glucose_unit_measure <- as.factor(file$glucose_unit_measure)
file$feet_check <- as.factor(file$feet_check)
file$feet_check_measure <- as.factor(file$feet_check_measure)
file$dilated_pupils <- as.factor(file$dilated_pupils)
file$retinopathy <- as.factor(file$retinopathy)
file$multiple_doctors_diabetes <- as.factor(file$multiple_doctors_diabetes)
file$time_to_specialist <- as.factor(file$time_to_specialist)
file$anyone_at_risk <- as.factor(file$anyone_at_risk)
file$age <- as.factor(file$age)



#recent_SBP, recent_DBP, SBP_recommended, DBP_recommended, recent_LDL_number, LDL_recommended as numeric
file$recent_DBP <- as.numeric(file$recent_DBP)
file$recent_SBP <- as.numeric(file$recent_SBP)
file$SBP_recommended <- as.numeric(file$SBP_recommended)
file$DBP_recommended <- as.numeric(file$DBP_recommended)
file$recent_LDL_number <- as.numeric(file$recent_LDL_number)
file$LDL_recommended <- as.numeric(file$LDL_recommended)
file$last_A1C_level <-
  as.numeric(file$last_A1C_level)
file$pastyear_doc_feetcheck <-
  as.numeric(file$pastyear_doc_feetcheck)
file$A1C_recommended <- as.numeric(file$A1C_recommended)
file$diabetes_age <- as.numeric(file$diabetes_age)
file$pastyear_doc_check <- as.numeric(file$pastyear_doc_check)


#Verification of data type change
head(file)
tail(file)
str(file)

#Counts of factors- I had to do this before treating missing values because one-hot encoding splits variables based on factor levels and changes the names of the variables, making it hard to obtain accurate counts. I have selected the following variables because they were the only few that had more than one factor level.
file%>%
  count(diabetes_status)
file%>%
  count(prediabetes_knowledge)
file%>%
  count(risk_awareness)
file%>%
  count(health_risk_knowledge)
file%>%
  count(blood_test_in_3yrs)
file%>%
  count(current_insulin_intake)
file%>%
  count(diabetic_pills_consumption)
file%>%
  count(time_to_specialist)
file%>%
  count(multiple_doctors_diabetes)
file%>%
  count(last_A1C_level)
file%>%
  count(retinopathy)
file%>%
  count(pastyear_doc_check)
file%>%
  count(dilated_pupils)
file%>%
  count(feet_check)
file%>%
  count(glucose_check)
file%>%
  count(insulin_intake_duration)
file%>%
  count(family_history)

##Treating Missing Values
#Calculating Percentage of NA values in dataframe
x <- sum(is.na(file))/prod(dim(file))*100
a <-"percent of rows are missing values."
paste(as.character(x), a)

#No. of NAs per column- It is important to see which columns have the least and most NA values.
sapply(file, function(x) sum(is.na(x)))

#One hot encoding the categoric variable. NOTE: the conversion to data.table changes numeric variables to character variables. 
library(data.table)
library(mltools)
file1 <- as.data.table(file)
dat_onehot1 = one_hot(dt=file1, cols="auto", sparsify= TRUE, naCols= TRUE)
head(dat_onehot1)
tail(dat_onehot1)
str(dat_onehot1)

#Changing continuous variables back into a numeric data type.
dat_onehot1 <- as.data.frame(dat_onehot1)
dat_onehot1$recent_DBP <- as.numeric(dat_onehot1$recent_DBP)
dat_onehot1$recent_SBP <- as.numeric(dat_onehot1$recent_SBP)
dat_onehot1$SBP_recommended <- as.numeric(dat_onehot1$SBP_recommended)
dat_onehot1$DBP_recommended <- as.numeric(dat_onehot1$DBP_recommended)
dat_onehot1$recent_LDL_number <- as.numeric(dat_onehot1$recent_LDL_number)
dat_onehot1$LDL_recommended <- as.numeric(dat_onehot1$LDL_recommended)
dat_onehot1$last_A1C_level <- as.numeric(dat_onehot1$last_A1C_level)
dat_onehot1$pastyear_doc_check <- as.numeric(dat_onehot1$pastyear_doc_check)
dat_onehot1$pastyear_doc_feetcheck <-
  as.numeric(dat_onehot1$pastyear_doc_feetcheck)
dat_onehot1$A1C_recommended <- as.numeric(dat_onehot1$A1C_recommended)
dat_onehot1$diabetes_age <- as.numeric(dat_onehot1$diabetes_age)
dat_onehot1$pastyear_doc_check <- as.numeric(dat_onehot1$pastyear_doc_check)

#Replacing with na- Most of the numeric variables above are not truly continuous because responses such as "Refused to Answer" or "Missing" makes it categoric. Since such responses mean that observations are unavailable to us, I replaced such values with NA values.
install.packages("naniar")
library(naniar)
unique(dat_onehot1$LDL_recommended)
dat_onehot1 <- dat_onehot1%>%
  replace_with_na(replace= list(recent_DBP=c(9999, 7777),
                                recent_SBP=c(9999, 7777, 5555, 6666),
                                SBP_recommended=c(7777, 6666, 9999),
                                DBP_recommended=c(6666, 7777),
                                recent_LDL_number=c(7777, 9999),
                                LDL_recommended=c(6666, 7777, 9999)),
                  last_A1C_level=c(777, 999),
                  A1C_recommended=c(77, 99),
                  pastyear_doc_check=c(7777, 9999),
                  diabetes_age=c(777, 999),
                  pastyear_doc_feetcheck=c(7777, 9999))

#Mean imputation- The variables are now numeric, and can their means can be imputed so that the NA values are treated. This is better than removing the NA values which will reduce the size of the dataframe. NA values are more than 80 percent of the dataframe.
dat_onehot1[sapply(dat_onehot1, is.numeric)] <- lapply(dat_onehot1[sapply(dat_onehot1, is.numeric)], function(x) ifelse(is.na(x), mean(x, na.rm = TRUE), x))
head(dat_onehot1)

##Plausibility check- Checking for extreme values and outliers

#Checking distribution of variables
dat_onehot1%>%
  map(summary)
str(dat_onehot1)

#Outlier detection 
outlier_values <- boxplot.stats(file$last_A1C_level)$out  
boxplot(file$last_A1C, main="Outlier check for Last_A1C_level", boxwex=0.1)
mtext(paste("Outliers: ", paste(outlier_values, collapse=", ")), cex=0.6)

outlier_values <- boxplot.stats(file$recent_SBP)$out
boxplot(file$recent_SBP, main="Outlier check for recent_SBP", boxwex=0.1)
mtext(paste("Outliers: ", paste(outlier_values, collapse=", ")), cex=0.6)

outlier_values <- boxplot.stats(file$recent_DBP)$out  
boxplot(file$recent_DBP, main="Outlier Check for recent_DBP", boxwex=0.1)
mtext(paste("Outliers: ", paste(outlier_values, collapse=", ")), cex=0.6)

outlier_values <- boxplot.stats(file$recent_LDL)$out 
boxplot(file$recent_LDL, main="Outlier Check for recent_LDL", boxwex=0.1)
mtext(paste("Outliers: ", paste(outlier_values, collapse=", ")), cex=0.6)

#I did not take into account all numeric variables. I only looked at variables that indicated a patient's current health to check for patients with serious conditions or those that are extremely healthy.