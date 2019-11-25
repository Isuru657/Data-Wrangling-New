#Loading all necessary packages
library(RODBC)
library(dplyr)
library(tidyverse)
library(lubridate)
library(ggplot2)
library(dplyr)

#1.	Create a new column “Enrollment group” in the table Phonecall
#a)	Insert EnrollmentGroup=Clinical Alert :code is 125060000
#b)	Insert EnrollmentGroup =Health Coaching :code is 125060001
#c)	Insert EnrollmentGroup =Technixal Question: Code is 125060002
#d)	Insert EnrollmentGroup =Administrative: Code  is 125060003
#e)	Insert EnrollmentGroup =Other: Code  is 125060004
#f)	Insert EnrollmentGroup =Lack of engagement : Code  is 125060005
#For this question, I created a new categorical variable using the levels of an existing categorical variable. 

myconn<-odbcConnect("isuru","username","password")
IC_Demo<-sqlQuery(myconn,"select * from Demographics")
print(IC_Demo)
Phonecall <- sqlQuery(myconn, "select * from Phonecall")
Phonecall_Encounter <- sqlQuery(myconn, "Select * from Phonecall_encounter")
Phonecall_Encounter$Enrollment_Group <- factor(case_when(Phonecall_Encounter$EncounterCode==125060000~"Clinical Alert",
                                                         Phonecall_Encounter$EncounterCode==125060001~"Health Coaching",
                                                         Phonecall_Encounter$EncounterCode==125060002~"Technical Question",
                                                         Phonecall_Encounter$EncounterCode==125060003~"Administrative",
                                                         Phonecall_Encounter$EncounterCode==125060004~"Other",
                                                         Phonecall_Encounter$EncounterCode==125060005~"Lack of engagement",
                                                         TRUE ~ "Unidentified encounter"))

#2.	Obtain the # of records for each enrollment group
number <- Phonecall_Encounter%>%
  count(Enrollment_Group)

#3.	Merge the Phone call encounter table with Call duration table.
merge <- left_join(x=Phonecall, y=Phonecall_Encounter, by=c("tri_CustomerIDEntityReference"="CustomerId"))
merge

#4.	Find out the # of records for different call outcomes and call type. Use 1-Inbound and 2-Outbound, for call types; use 1-No response,2-Left voice mail and 3 successful. Please also find the call duration for each of the enrollment groups 
levels(merge$CallOutcome) <- c("No response", "Left Voice Mail", "Successful", "NULL")
merge$CallType <- factor(merge$CallType)
levels(merge$CallType) <- c("Inbound", "Outbound")
merge%>%
  count(merge$CallOutcome)
merge%>%
  count(factor(merge$CallType))
#Average call duration per enrollment group
merge%>%
  group_by(Enrollment_Group)%>%
  summarize(mean=mean(CallDuration, na.rm= TRUE))
#Total call duration per enrollment group
merge%>%
  group_by(Enrollment_Group)%>%
  summarize(sum=sum(CallDuration, na.rm= TRUE))

#5.	Merge the tables Demographics, Conditions and TextMessages. Find the # of texts/per week, by the type of sender. Draw a visual using ggplot to obtain # of texts and color it by the type of sender
dem <- sqlQuery(myconn, "SELECT * FROM Demographics")
con <- sqlQuery(myconn, "SELECT * FROM Conditions")
txt <- sqlQuery(myconn, "SELECT * FROM TextMessages")
merg1 <- left_join(x=dem, y=con, by=c("contactid"="tri_patientid"))
merg2 <- left_join(x=merg1, y=txt, by=c("contactid"="tri_contactId"))
merg2
merg2%>%
  mutate(week=factor(week(mdy(merg2$TextSentDate))))%>%
  count(week, SenderName)%>%
  ggplot(., aes(x=week, y=n, fill=SenderName))+
  geom_col(position="stack")+
  coord_flip()+
  xlab("Week")+
  ylab("Count")+
  ggtitle("Number of texts per week by Sender Name")

#6.	Obtain the count of texts based on the chronic condition over a period of time (say per week). Draw a visual using ggplot to obtain the counts
merg2%>%
  mutate(week=factor(week(mdy(merg2$TextSentDate))))%>%
  count(week, tri_name)%>%
  ggplot(., aes(x=week, y=n, fill=tri_name))+
  geom_col(position="stack")+
  coord_flip()+
  xlab("Week")+
  ylab("Count")+
  ggtitle("Number of texts per week by Condition")