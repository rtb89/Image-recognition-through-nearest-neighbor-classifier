    ----------------------------------------------------
	Your MATLAB license will expire in 27 days.
	Please contact your system administrator or
	MathWorks to renew this license.
    ----------------------------------------------------
   %Extracting the feature matrices for all 10 image file
   %matrix
A= imgfts('a.jpg') ;            		                              %80X6
D= imgfts('d.jpg') ;     				            			      %80X6
M=imgfts('m.jpg') ;     				               		              %80X6
N=imgfts('n.jpg');     				                 		          %80X6
O=imgfts('o.jpg'); 				                                      %81X6
P=imgfts('p.jpg');                      					              %80X6
Q=imgfts('q.jpg');              					                      %79X6
R=imgfts('r.jpg');           					                      %80X6
U= imgfts('u.jpg');					                                  %80X6
W=imgfts('w.jpg') ;					                                  %80X6


%Combining column wise all the individual feature matrix into a 800X6 matrix
feature=[A;D;M;N;O;P;Q;R;U;W];

% Create a 800X1 Character matrix representing the actaul class of
% elements

 trainingClass= [repmat('a',80,1); repmat('d',80,1); repmat('m',80,1); repmat('n',80,1); repmat('o',81,1);repmat('p',80,1); repmat('q',79,1); repmat('r',80,1); repmat('u',80,1); repmat('w',80,1)];
% calculating the distance of each row with all the rows of the feature
% into a 800 X 800 matrix
 feature_dist=dist2 (feature, feature);

% Sorting the distance matrix of training feature matrix and storing its
% Index as well
 [feature_dist_sorted, feature_dist_index]=sort (feature_dist,2);

% predicting the training class using the second nearest value
training_predicted1=trainingClass (feature_dist_index(:,2));

% Iterate on 'i' through all the rows to find the number of correct prediction

 count=0;
 for i=1:800
if training_predicted1(i,1)==trainingClass(i,1)
count=count+1;
end
end
 count

count =

   387
% Accuracy on the training set
 acc_training1= (count/800)*100

acc_training1 =

   48.3750

% Creating the class matrix for the test image using repmat  (70 X 1 Char)
testClass= [repmat('a',7 ,1); repmat('d',7,1); repmat('m',7,1); repmat('n',7,1); repmat('o',7,1);repmat('p',7,1); repmat('q',7,1); repmat('r',7,1); repmat('u',7,1); repmat('w',7,1)];

% reorder the test class matrix
 load Reorder;
 testClass=testClass(ReorderIndex);
clear ReorderIndex;

% Extracting the feature matrix for the test file
 test_feature = imgfts('test.jpg');                             % (70 X 6 Double)

% Creating a distance matrix (70x800 double) matrix by calculateing the
% distance of each row of the feature matrix of the test from each row of
% teh feature matrix of traing training 
 test_dist=dist2(test_feature,feature);

% Sorting and Storing the Index of the test distance matrix into (70 X 1 ) matrix 
 [test_dist_S, test_dist_I]=sort(test_dist,2);

% predicting the test class using the closet class
 test_predicted1=trainingClass (test_dist_I(:,1));               % 70 X 1 char matrix

% Calculating the number of correct prediction (that matches the actual test class) of the test class by
% iteratiing on i through all the 70 rows
 c=0;
 for i=1:70
if test_predicted1(i,1)==testClass(i,1)
c=c+1;
end
 end
 acc_test1=c*100/70

acc_test1 =

   51.4286

 showcharlabels('test.jpg',test_predicted1,['a','d','m','n','o','p','q','r','u','w'])
Warning: Image is too big to fit on screen; displaying at 67% 
> In images.internal.initSize (line 71)
  In imshow (line 309)
  In showcharlabels (line 33) 
  
%Enhancements  
  
%  Calculate the mean and standard deviation of each feature of the training feature matrix
  M=mean(feature);            % (1X6 double) matrix    
 S=std(feature)               % (1X6 double) matrix

% Normalizzing the feature matarix by iterating though each column of each
% row
 for i=1:800
for j=1:6
featureN(i,j)=(feature(i,j)-M(1,j))/(S(1,j));
end
end

% Creating teh distance matrix from the mormalized feature matrix
 featureN_dist=dist2 (featureN, featureN);          %(800 X 800 double)

% Sorting and storing the index values of the distance matrix
[featureN_dist_sorted, featureN_dist_index]=sort (featureN_dist,2);

%Predicting the training class using the second closet character
training_predicted2=trainingClass (featureN_dist_index(:,2)); % (800 X 1 Char)

% counting the number of correct predicting using the normalization process
 count=0;
for i=1:800
if training_predicted2(i,1)==trainingClass(i,1)
count=count+1;
end
end
acc_training2=(count/800)*100

acc_training2 =

   58.75

% Normalizzing the feature matarix of the test set by iterating though each column of each
% row
 for i=1:70
for j=1:6
test_featureN(i,j)=(test_feature(i,j)-M(1,j))/(S(1,j));
end
end
% Creating a distance matrix (70x800 double) matrix by calculateing the
% distance of each row of the normalized feature matrix of the test from each row of
% the normalized feature matrix of traing training 
testN_dist=dist2 (test_featureN, featureN);

%Sorting the normalized test distance matrix
[testN_dist_S, testN_dist_I]=sort (testN_dist,2);

%Predicting the test class using the closet elemnet using the Normalized methode
test_predicted2=trainingClass (testN_dist_I(:,1));       %(70 X 1 Char)

% Calculating the correctly predicted value
c=0;
 for i=1:70
if test_predicted2(i,1)==testClass(i,1)
c=c+1;
end
 end

% Calculating the acccuracy of predicting the test matrix
acc_test2=c*100/70

acc_test2 =

   51.4286

 showcharlabels('test.jpg',test_predicted2,['a','d','m','n','o','p','q','r','u','w'])


% Predicting the training calss using the 5 nearest neighbor elements
% leaving the first closet element
 
 for i=1:5
training_pred3(:,i)=trainingClass (featureN_dist_index(:,i+1));    % (800 X 5) matrix
end

% Taking the most occuring value using for each row as the prediction
training_predicted3=mode(training_pred3,2);

% Calculating the predicted class
count=0;
for i=1:800
if training_predicted3(i,1)==trainingClass(i,1)
count=count+1;
end
end

% Calculating the Accuracy
acc_training3= (count/800)*100

acc_training3 =

    59.62
    
 

% Predicting the test class using the 5 nearest neighbor elements set
for i=1:5
test_pred3(:,i)=trainingClass(testN_dist_I(:,i));    % (70 X 5) matrix
end

% Taking the most occuring value using for each row as the prediction
[test_predicted3, F ]= mode(test_pred3,2);


   
% Calculating the number of corect prediction for the test 
c=0;
for i=1:70
if test_predicted3(i,1)==testClass(i,1)
c=c+1;
end
end
acc_test3= (c/70)*100

acc_test3 =

   55.71
  
showcharlabels('test.jpg',test_predicted3,['a','d','m','n','o','p','q','r','u','w'])
   
   %  1.10
   
% Extracting the combined feature matrix with additional features (800 X 13 double) 
featureX= [imgfts2('a.jpg'); imgfts2('d.jpg');  imgfts2('m.jpg');imgfts2('n.jpg');imgfts2('o.jpg');imgfts2('p.jpg');imgfts2('q.jpg');imgfts2('r.jpg');imgfts2('u.jpg');imgfts2('w.jpg')];

% Calculatinng the mean and standard deviation column wise  for each
% feature
mX = mean(featureX);                   % (1 X 13 double)
sX = std(featureX);                    % (1 X 13 double)

% Normallizing the training feature matrix
for i=1:800
for j=1:13
featureXN(i,j)=(featureX(i,j)-mX(1,j))/(sX(1,j));
end
end

% Calculating the distance 
featureXN_dist=dist2(featureXN, featureXN);    %(800 X 800 double)

% Sorting and storing the index
[featureXN_dist_sorted, featureXN_dist_index]=sort(featureXN_dist,2);

% Predicting the nearest 5 elemnets for each row leaving the closest
for i=1:5
training_pred4(:,i)=trainingClass(featureXN_dist_index(:,i+1));    %(800 X 5 Char)
end

% Choosing the most occuring element as the final predicted training class
training_predicted4=mode(training_pred4,2);                         %(800 X 1 Char)
count=0;

% Calculating the number of correctly predicted elemnets
for i=1:800
if training_predicted4(i,1)==trainingClass(i,1)
count=count+1;
end
end

 count

count =

   581

   % Calculating the accuracy
 acc_training4= (count/800)*100

acc_training4 =

   87.625

   
 % Extracting the enchanced feature matrix of the test file
 test_featureX= imgfts2('test.jpg');             %(70 X 13 double)

% Normalizing the matrix
for i=1:70
for j=1:13
test_featureXN(i,j)=(test_featureX(i,j)-mX(1,j))/(sX(1,j));       %(70 X 13 double)
end
end

            
testXN_dist=dist2(test_featureXN, featureXN);   %(70 X 800 double) 
[testXN_dist_S, testXN_dist_I]=sort (testXN_dist,2);

% Predicting the class of the first 5 nearest test values
 for j=1:5
test_pred4(:,j)=trainingClass(testXN_dist_I(:,j));
end

% Taking the most occuring elment 
 test_predicted4=mode(test_pred4,2);

% Calculating the number of correctly predicted values
 c=0;
for i=1:70
if test_predicted4(i,1)==testClass(i,1)
c=c+1;
end
end

% Calculating the accuracy on the test set (k=5)
 acc_test4=c*100/70

acc_test4 =

   71.4286 
   
showcharlabels('test.jpg',test_predicted4,['a','d','m','n','o','p','q','r','u','w'])


