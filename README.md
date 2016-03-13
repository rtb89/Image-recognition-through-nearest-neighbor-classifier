Image-recognition-through-nearest-neighbor-classifier

Hu moments are a category of image analysis features useful in handwriting recognition. 

Two functions imgfts.m and  imgfts2.m are used that returns a set of features 6 and 13 respectively for all the letters in a given input image. These features are based on the values of centroid, axis of moment of inertia, a measure of 'roundness', and a vector % of invariant moments. 
The prediction of the test data is made using nearest neighbor classifier and the test accuracy is improved by using and coparing the results by taking k nearest neighbors, normallization of the feature matrix.
