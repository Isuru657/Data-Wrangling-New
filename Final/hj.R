library(RODBC)
myconn<-odbcConnect("isuru","aabeysekara","aabeysekara@qbs181")
IC_Demo<-sqlQuery(myconn,"select * from Demographics")
print(IC_Demo)
IC_Demo
file <- read.csv(file.choose())
library(dplyr)
unique(file$BPAlerts)
str(file)
str(IC_Demo)
file <- file%>%
  mutate(BP_Status=case_when(
    file$BPAlerts=="Hypo1"~"1",
    file$BPAlerts=="Normal"~"1",
    file$BPAlerts=="Hypo2"~"0",
    file$BPAlerts=="HTN1"~"0",
    file$BPAlerts=="HTN2"~"0",
    file$BPAlerts=="HTN3"~"0",
    TRUE~ "Null"
  ))
s <-"SELECT * FROM IC_Demo INNER JOIN file ON IC_Demo.contactid=file.ID"
library(sqldf)
join <- sqldf(s)
head(join)
str(join)
join%>%
  mutate(week=week(mdy(join$tri_enrollmentcompletedate)))%>%
  count(week)%>%
  arrange(desc(n))
join <- join%>%
  mutate(tri_enrollmentcompletedate=mdy(tri_enrollmentcompletedate),
         week=week(tri_enrollmentcompletedate),
         year=year(tri_enrollmentcompletedate),
         week_yr=paste(as.character(week), as.character(year), sep=","))
join%>%
  group_by(week_yr)%>%
  count(nrow(join))%>%
  arrange(desc(n))

w <- c("17,2016", "18,2016", "19,2016", "20,2016", "21,2016", "22,2016", "23,2016", "24,2016", "25,2016", "26,2016", "27,2016", "28,2016")
new_dat <- join%>%
  filter(week_yr%in%w)%>%
  group_by(contactid, week_yr)%>%
  summarize(sval=mean(SystolicValue, na.rm= TRUE),
            dval=mean(Diastolicvalue, na.rm= TRUE),
            Bp=mean(as.numeric(BP_Status), na.rm= TRUE))

new_dat%>%
  filter(week_yr=="17,2016")%>%
  ggplot(., aes(x=contactid, y=Bp))+
  geom_col()
new_dat%>%
  filter(week_yr=="28,2016")%>%
  ggplot(., aes(x=contactid, y=Bp))+
  geom_col()

#Manual inspection shows that there are 7 people like that.

#2
IC_Conditions <- sqlQuery(myconn, "SELECT * FROM Conditions")
IC_Text <- sqlQuery(myconn, "SELECT * FROM TextMessages")
str(IC_Conditions)
str(IC_Text)
str(IC_Demo)
s1 <- "SELECT * FROM IC_Demo INNER JOIN (SELECT * FROM IC_Conditions INNER JOIN IC_Text ON IC_Conditions.tri_patientid=IC_Text.tri_contactId) AS merge ON IC_Demo.contactid=merge.tri_contactId"
merge_one <- sqldf(s1)
s2 <- "SELECT contactId, MAX(TextSentDate), * FROM merge_one GROUP BY contactid"
merge_two <- sqldf(s2)

#3
merge_three <- inner_join(IC_Conditions, IC_Text, by=c("tri_patientid"="tri_contactId"))
merge_four <- inner_join(IC_Demo, merge_three, by=c("contactid"="tri_patientid"))
library(lubridate)
merge_four$TextSentDate <- mdy(merge_four$TextSentDate)
library(dplyr)
merge_four%>% 
  group_by(contactid) %>%
  slice(which.max(TextSentDate))
  
