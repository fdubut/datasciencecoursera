# Script to clean the Samsung Galaxy S accelerometer dataset

# 1. Merge the training and test sets

dir.create("merged")

# 1.1. Merge features

X_train <- read.table(".\\train\\X_train.txt")
X_test <- read.table(".\\test\\X_test.txt")
X <- rbind(X_train,X_test)

# 1.2. Merge labels

y_train <- read.table(".\\train\\y_train.txt")
y_test <- read.table(".\\test\\y_test.txt")
y <- rbind(y_train,y_test)

# 1.3. Merge subjects

subject_train <- read.table(".\\train\\subject_train.txt")
subject_test <- read.table(".\\test\\subject_test.txt")
subject <- rbind(subject_train,subject_test)
names(subject) <- c("subject.id")
write.csv(subject,".\\merged\\subject.csv",row.names=FALSE)

# 2. Extract only mean and std for each measurement

feature_names <- read.table(".\\features.txt")
names(X) <- feature_names[,2]
X <- X[,grepl("mean[^F]|std",names(X))]

# 3. Assign descriptive activity names to test set

activity_names <- read.table(".\\activity_labels.txt", stringsAsFactors=FALSE)
y[,2] <- unlist(lapply(y[,1], function(x) activity_names[x,2]))
names(y) <- c("activity.id","activity.name")
write.csv(y,".\\merged\\y.csv",quote=FALSE,row.names=FALSE)

# 4. Assign appropriate labels to data set

feature_names <- names(X)
feature_names <- sub("^t","time.",feature_names)
feature_names <- sub("^f","frequency.",feature_names)
feature_names <- gsub("-",".", feature_names)
feature_names <- gsub("[()]","", feature_names)
names(X) <- feature_names
write.csv(X,".\\merged\\X.csv",row.names=FALSE)

# 5. Create final tidy data set

final <- cbind(subject,y,X)
final <- ddply(final, .(subject.id,activity.id,activity.name),
              function(df) sapply(df[,-c(1,2,3)], mean))
write.csv(final,".\\merged\\final.csv",row.names=FALSE)