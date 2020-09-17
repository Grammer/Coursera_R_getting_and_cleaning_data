# Code Book

Aim of this file is to describe the data used in the project and the algorythm to get the final data set

### Overview

Data is provided by volunteers that did some activities while wearing a smartphone, that captured data from movements.

### Files:
* X_train.txt: 7352 observations from 561 features, 21/30 volunteers.
* X_test.txt: 2947 observations from 561 features, 9/30 volunteers.
* y_train.txt: vector of 7352 integers, denoting the ID of the activity related to each of the observations in X_train.txt.
* y_test.txt: vector of 2947 integers, denoting the ID of the activity related to each of the observations in X_test.txt.
* subject_train.txt: vector of 7352 integers, denoting the ID of the volunteer related to each of the observations in X_train.txt.
* subject_test.txt: vector of 2947 integers, denoting the ID of the volunteer related to each of the observations in X_test.txt.
* activity_labels.txt: Names and IDs for activities
* features.txt: Names of features

###Processing steps

* Files are downloaded, read and training - test data is merged
* Feature columns without "mean" or "std" are removed
* Activity column is converted to factor
* Tidy data is created based on the tast
* Tidy data is written as txt file
