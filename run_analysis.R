

#install.packages("dplyr")

##=============================Code to download the files. ncomment and rerun if needed===============
# setwd("c:/users/chris/datasciencecoursera/GettingCleaningData/RunAnalysis")
# 
# #Download file and unzip
# td <- "c:/users/chris/datasciencecoursera/GettingCleaningData/RunAnalysis" 
# tf <- tempfile(tmpdir=td, fileext=".zip")
# download.file("http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", tf) 
# dateDownloaded <- date()
# unzip(tf,  exdir=td,overwrite=TRUE) 
# fpath <- file.path(td)

library(dplyr)

#Get descritive data
setwd("c:/users/chris/datasciencecoursera/GettingCleaningData/RunAnalysis/UCI HAR Dataset")
features <- read.table("features.txt")
activity_labels <- read.table("activity_labels.txt")

##=============== Training Dataset===================
setwd("c:/users/chris/datasciencecoursera/GettingCleaningData/RunAnalysis/UCI HAR Dataset/train")
TrainLabels <- read.table("y_train.txt")
TrainData <- read.table("x_train.txt")
SubjectTrain <- read.table("subject_train.txt")

#re-label the actvities (this is step 3)
activity_labels<-rename(activity_labels,activityid=V1)
SubjectTrain<-rename(SubjectTrain,subjectid=V1)
TrainLabels<-rename(TrainLabels,labelid=V1)

#merge columns
train1<-cbind(SubjectTrain,TrainLabels,TrainData)
#head(train1,1)

#Add in Activity labels
mergedTrainingData = merge(activity_labels,train1,by.x="activityid",by.y="labelid",all=TRUE)



## ====================Test Dataset================================
setwd("c:/users/chris/datasciencecoursera/GettingCleaningData/RunAnalysis/UCI HAR Dataset/test")
TestLabels <- read.table("y_test.txt")
TestData <- read.table("x_test.txt")
SubjectTest <- read.table("subject_test.txt")

#re-label the actvities (this is step 3)
SubjectTest<-rename(SubjectTest,subjectid=V1)
TestLabels<-rename(TestLabels,labelid=V1)

#merge columns
test1<-cbind(SubjectTest,TestLabels,TestData)
#head(test1,1)

#Add in Activity labels
mergedTestData = merge(activity_labels,test1,by.x="activityid",by.y="labelid",all=TRUE)



## =================Union the 2 sets together================
union1<-rbind(mergedTrainingData,mergedTestData)
#head(union,1)



#Select just the mean and sd deviation 
# these are the cols and col numbers we will need
# 1 tBodyAcc-mean()-X
# 2 tBodyAcc-mean()-Y
# 3 tBodyAcc-mean()-Z
# 4 tBodyAcc-std()-X
# 5 tBodyAcc-std()-Y
# 6 tBodyAcc-std()-Z
# 41 tGravityAcc-mean()-X
# 42 tGravityAcc-mean()-Y
# 43 tGravityAcc-mean()-Z
# 44 tGravityAcc-std()-X
# 45 tGravityAcc-std()-Y
# 46 tGravityAcc-std()-Z
# 81 tBodyAccJerk-mean()-X
# 82 tBodyAccJerk-mean()-Y
# 83 tBodyAccJerk-mean()-Z
# 84 tBodyAccJerk-std()-X
# 85 tBodyAccJerk-std()-Y
# 86 tBodyAccJerk-std()-Z
# 121 tBodyGyro-mean()-X
# 122 tBodyGyro-mean()-Y
# 123 tBodyGyro-mean()-Z
# 124 tBodyGyro-std()-X
# 125 tBodyGyro-std()-Y
# 126 tBodyGyro-std()-Z
# 161 tBodyGyroJerk-mean()-X
# 162 tBodyGyroJerk-mean()-Y
# 163 tBodyGyroJerk-mean()-Z
# 164 tBodyGyroJerk-std()-X
# 165 tBodyGyroJerk-std()-Y
# 166 tBodyGyroJerk-std()-Z
# 201 tBodyAccMag-mean()
# 202 tBodyAccMag-std()
# 214 tGravityAccMag-mean()
# 215 tGravityAccMag-std()
# 227 tBodyAccJerkMag-mean()
# 228 tBodyAccJerkMag-std()
# 240 tBodyGyroMag-mean()
# 241 tBodyGyroMag-std()
# 253 tBodyGyroJerkMag-mean()
# 254 tBodyGyroJerkMag-std()
# 266 fBodyAcc-mean()-X
# 267 fBodyAcc-mean()-Y
# 268 fBodyAcc-mean()-Z
# 269 fBodyAcc-std()-X
# 270 fBodyAcc-std()-Y
# 271 fBodyAcc-std()-Z
# 294 fBodyAcc-meanFreq()-X
# 295 fBodyAcc-meanFreq()-Y
# 296 fBodyAcc-meanFreq()-Z
# 345 fBodyAccJerk-mean()-X
# 346 fBodyAccJerk-mean()-Y
# 347 fBodyAccJerk-mean()-Z
# 348 fBodyAccJerk-std()-X
# 349 fBodyAccJerk-std()-Y
# 350 fBodyAccJerk-std()-Z
# 424 fBodyGyro-mean()-X
# 425 fBodyGyro-mean()-Y
# 426 fBodyGyro-mean()-Z
# 427 fBodyGyro-std()-X
# 428 fBodyGyro-std()-Y
# 429 fBodyGyro-std()-Z
# 503 fBodyAccMag-mean()
# 504 fBodyAccMag-std()
# 516 fBodyBodyAccJerkMag-mean()
# 517 fBodyBodyAccJerkMag-std()
# 529 fBodyBodyGyroMag-mean()
# 530 fBodyBodyGyroMag-std()
# 542 fBodyBodyGyroJerkMag-mean()
# 543 fBodyBodyGyroJerkMag-std()


#Replace with proper feature names we will need (this is really step 4 but I thought it more logical to do this fisrt)
library(data.table)
union2<-setnames(union1, old = c('V2.x','V1','V2.y','V3','V4','V5','V6','V41','V42','V43','V44','V45','V46','V81','V82','V83','V84','V85','V86','V121','V122','V123','V124','V125','V126','V161','V162','V163','V164','V165','V166','V201','V202','V214','V215','V227','V228','V240','V241','V253','V254','V266','V267','V268','V269','V270','V271','V294','V295','V296','V345','V346','V347','V348','V349','V350','V424','V425','V426','V427','V428','V429','V503','V504','V516','V517','V529','V530','V542','V543'),  new = c('Subject','tBodyAcc-mean()-X','tBodyAcc-mean()-Y','tBodyAcc-mean()-Z','tBodyAcc-std()-X','tBodyAcc-std()-Y','tBodyAcc-std()-Z','tGravityAcc-mean()-X','tGravityAcc-mean()-Y','tGravityAcc-mean()-Z','tGravityAcc-std()-X','tGravityAcc-std()-Y','tGravityAcc-std()-Z','tBodyAccJerk-mean()-X','tBodyAccJerk-mean()-Y','tBodyAccJerk-mean()-Z','tBodyAccJerk-std()-X','tBodyAccJerk-std()-Y','tBodyAccJerk-std()-Z','tBodyGyro-mean()-X','tBodyGyro-mean()-Y','tBodyGyro-mean()-Z','tBodyGyro-std()-X','tBodyGyro-std()-Y','tBodyGyro-std()-Z','tBodyGyroJerk-mean()-X','tBodyGyroJerk-mean()-Y','tBodyGyroJerk-mean()-Z','tBodyGyroJerk-std()-X','tBodyGyroJerk-std()-Y','tBodyGyroJerk-std()-Z','tBodyAccMag-mean()','tBodyAccMag-std()','tGravityAccMag-mean()','tGravityAccMag-std()','tBodyAccJerkMag-mean()','tBodyAccJerkMag-std()','tBodyGyroMag-mean()','tBodyGyroMag-std()','tBodyGyroJerkMag-mean()','tBodyGyroJerkMag-std()','fBodyAcc-mean()-X','fBodyAcc-mean()-Y','fBodyAcc-mean()-Z','fBodyAcc-std()-X','fBodyAcc-std()-Y','fBodyAcc-std()-Z','fBodyAcc-meanFreq()-X','fBodyAcc-meanFreq()-Y','fBodyAcc-meanFreq()-Z','fBodyAccJerk-mean()-X','fBodyAccJerk-mean()-Y','fBodyAccJerk-mean()-Z','fBodyAccJerk-std()-X','fBodyAccJerk-std()-Y','fBodyAccJerk-std()-Z','fBodyGyro-mean()-X','fBodyGyro-mean()-Y','fBodyGyro-mean()-Z','fBodyGyro-std()-X','fBodyGyro-std()-Y','fBodyGyro-std()-Z','fBodyAccMag-mean()','fBodyAccMag-std()','fBodyBodyAccJerkMag-mean()','fBodyBodyAccJerkMag-std()','fBodyBodyGyroMag-mean()','fBodyBodyGyroMag-std()','fBodyBodyGyroJerkMag-mean()','fBodyBodyGyroJerkMag-std()') )
#head(union2,1)

#limit dataset to the columns we need (the means and Std deviations - have already renamed to make t easy).uses dply select fn
vars<-c('activityid','subjectid','tBodyAcc-mean()-X','tBodyAcc-mean()-Y','tBodyAcc-mean()-Z','tBodyAcc-std()-X','tBodyAcc-std()-Y','tBodyAcc-std()-Z','tGravityAcc-mean()-X','tGravityAcc-mean()-Y','tGravityAcc-mean()-Z','tGravityAcc-std()-X','tGravityAcc-std()-Y','tGravityAcc-std()-Z','tBodyAccJerk-mean()-X','tBodyAccJerk-mean()-Y','tBodyAccJerk-mean()-Z','tBodyAccJerk-std()-X','tBodyAccJerk-std()-Y','tBodyAccJerk-std()-Z','tBodyGyro-mean()-X','tBodyGyro-mean()-Y','tBodyGyro-mean()-Z','tBodyGyro-std()-X','tBodyGyro-std()-Y','tBodyGyro-std()-Z','tBodyGyroJerk-mean()-X','tBodyGyroJerk-mean()-Y','tBodyGyroJerk-mean()-Z','tBodyGyroJerk-std()-X','tBodyGyroJerk-std()-Y','tBodyGyroJerk-std()-Z','tBodyAccMag-mean()','tBodyAccMag-std()','tGravityAccMag-mean()','tGravityAccMag-std()','tBodyAccJerkMag-mean()','tBodyAccJerkMag-std()','tBodyGyroMag-mean()','tBodyGyroMag-std()','tBodyGyroJerkMag-mean()','tBodyGyroJerkMag-std()','fBodyAcc-mean()-X','fBodyAcc-mean()-Y','fBodyAcc-mean()-Z','fBodyAcc-std()-X','fBodyAcc-std()-Y','fBodyAcc-std()-Z','fBodyAcc-meanFreq()-X','fBodyAcc-meanFreq()-Y','fBodyAcc-meanFreq()-Z','fBodyAccJerk-mean()-X','fBodyAccJerk-mean()-Y','fBodyAccJerk-mean()-Z','fBodyAccJerk-std()-X','fBodyAccJerk-std()-Y','fBodyAccJerk-std()-Z','fBodyGyro-mean()-X','fBodyGyro-mean()-Y','fBodyGyro-mean()-Z','fBodyGyro-std()-X','fBodyGyro-std()-Y','fBodyGyro-std()-Z','fBodyAccMag-mean()','fBodyAccMag-std()','fBodyBodyAccJerkMag-mean()','fBodyBodyAccJerkMag-std()','fBodyBodyGyroMag-mean()','fBodyBodyGyroMag-std()','fBodyBodyGyroJerkMag-mean()','fBodyBodyGyroJerkMag-std()') 
union3<-select(union2,one_of(vars))

#compute the means  
union3 %>% group_by(activityid,subjectid) %>% summarise_each(funs(mean))

#output the text file
setwd("c:/users/chris/datasciencecoursera/GettingCleaningData/RunAnalysis")
write.table(union3, "run_analysis.txt", row.name=FALSE)
