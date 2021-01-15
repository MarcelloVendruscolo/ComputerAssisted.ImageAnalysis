%% Settings

addpath('functions');

%% Task 1

load 'data/cdata'; % Load synthetic data

figure; plot(cdata(:,1),cdata(:,2),'.'); % Plot the data
hold on; yline(2.0,'r','y = 2.0'); hold off; % Plot constant function y = 2
title('Separation of Classes'); xlabel('x coordinate'); ylabel('y coordinate'); % Label the diagram

%% Task 2

handBw = imread('data/handBW.pnm'); % Read the image

figure(); imshow(handBw); % Show the image
figure(); imhist(handBw); % Show the histogram
figure(); mtresh(handBw,110,175); % Multiple Threshold where t1 and t2 are the threshold values
title('Multiple thresholding');

%% Task 3 & 4

% Setup for the several classifications that follow
handBw = imread('data/handBW.pnm'); % Read the image
hand_rgb = imread('data/hand.pnm'); % Read the image
label_hand_rgb = imread('images/hand_training.png'); % Read image with labels
%figure(); imagesc(label_hand_rgb); % View the training areas

% Separate the three layers, RGB
R = hand_rgb(:,:,1);
G = hand_rgb(:,:,2);
B = hand_rgb(:,:,3);

%figure(); plot3(R(:),G(:),B(:),'.') % 3D scatterplot of the RGB data

% Classification of the greyscale image:
[data,class] = create_training_data(handBw,label_hand_rgb); % Arrange the training data into vectors

Itest = im2testdata(handBw); % Reshape the image before classification
classifier = classify(double(Itest),double(data),double(class)); % Train classifier and classify the data
ImClassifier_greylevel = class2im(classifier,size(handBw,1),size(handBw,2)); % Reshape the classification to an image
figure(); imagesc(ImClassifier_greylevel); title('Greyscale Classification'); % View the classification result

% Classification using one feature (one channel at time):
green_band_image(:,:,1) = G; % Create an image with one band/feature
[data,class] = create_training_data(green_band_image,label_hand_rgb); % Arrange the training data into vectors
Itest = im2testdata(green_band_image); % Reshape the image before classification
classifier = classify(double(Itest),double(data),double(class)); % Train classifier and classify the data
ImClassifier_green = class2im(classifier,size(green_band_image,1),size(green_band_image,2)); % Reshape the classification to an image

red_band_image(:,:,1) = R; % Create an image with one band/feature
[data,class] = create_training_data(red_band_image,label_hand_rgb); % Arrange the training data into vectors
Itest = im2testdata(red_band_image); % Reshape the image before classification
classifier = classify(double(Itest),double(data),double(class)); % Train classifier and classify the data
ImClassifier_red = class2im(classifier,size(red_band_image,1),size(red_band_image,2)); % Reshape the classification to an image

blue_band_image(:,:,1) = B; % Create an image with one band/feature
[data,class] = create_training_data(blue_band_image,label_hand_rgb); % Arrange the training data into vectors
Itest = im2testdata(blue_band_image); % Reshape the image before classification
classifier = classify(double(Itest),double(data),double(class)); % Train classifier and classify the data
ImClassifier_blue = class2im(classifier,size(blue_band_image,1),size(blue_band_image,2)); % Reshape the classification to an image

% View the one channel images:
figure();
subplot(1,3,1), imshow(green_band_image); title('Green Channel');
subplot(1,3,2), imshow(red_band_image); title('Red Channel');
subplot(1,3,3), imshow(blue_band_image); title('Blue Channel');

% View the classification results:
figure();
subplot(1,3,1), imagesc(ImClassifier_green); title('Green Feature Class.');
subplot(1,3,2), imagesc(ImClassifier_red); title('Red Feature Class.');
subplot(1,3,3), imagesc(ImClassifier_blue); title('Blue Feature Class.');

% Classification using full RGB:

% Create an image with all three bands/features
three_bands_image(:,:,1) = R;
three_bands_image(:,:,2) = G;
three_bands_image(:,:,3) = B;

[data,class] = create_training_data(three_bands_image,label_hand_rgb); % Arrange the training data into vectors
Itest = im2testdata(three_bands_image); % Reshape the image before classification
classifier = classify(double(Itest),double(data),double(class)); % Train classifier and classify the data
ImClassifier_RGB = class2im(classifier,size(three_bands_image,1),size(three_bands_image,2)); % Reshape the classification to an image
figure(); imagesc(ImClassifier_RGB); title('Full RGB Classification'); % View the classification result

% Create an image with two bands/features
gb_bands_image(:,:,1) = G;
gb_bands_image(:,:,2) = B;

[data0,class0] = create_training_data(gb_bands_image,label_hand_rgb); % Arrange the training data into vectors
Itest = im2testdata(gb_bands_image); % Reshape the image before classification
classifier = classify(double(Itest),double(data0),double(class0)); % Train classifier and classify the data
ImClassifier_gb = class2im(classifier,size(gb_bands_image,1),size(gb_bands_image,2)); % Reshape the classification to an image

% Create an image with two bands/features
gr_bands_image(:,:,1) = G;
gr_bands_image(:,:,2) = R;

[data1,class1] = create_training_data(gr_bands_image,label_hand_rgb); % Arrange the training data into vectors
Itest = im2testdata(gr_bands_image); % Reshape the image before classification
classifier = classify(double(Itest),double(data1),double(class1)); % Train classifier and classify the data
ImClassifier_gr = class2im(classifier,size(gr_bands_image,1),size(gr_bands_image,2)); % Reshape the classification to an image

% Create an image with two bands/features
br_bands_image(:,:,1) = B;
br_bands_image(:,:,2) = R;

[data2,class2] = create_training_data(br_bands_image,label_hand_rgb); % Arrange the training data into vectors
Itest = im2testdata(br_bands_image); % Reshape the image before classification
classifier = classify(double(Itest),double(data2),double(class2)); % Train classifier and classify the data
ImClassifier_br = class2im(classifier,size(br_bands_image,1),size(br_bands_image,2)); % Reshape the classification to an image

% View the training feature vectors;
figure();
subplot(3,1,1), scatterplot2D(data0,class0); title('Green + Blue Channels');
subplot(3,1,2), scatterplot2D(data1,class1); title('Green + Red Channels');
subplot(3,1,3), scatterplot2D(data2,class2); title('Blue + Red Channels');

% View the classification results:
figure();
subplot(1,3,1), imagesc(ImClassifier_gb); title('Green + Blue Features');
subplot(1,3,2), imagesc(ImClassifier_gr); title('Green + Red Features');
subplot(1,3,3), imagesc(ImClassifier_br); title('Blue + Red Features');

%% Task 5

load 'data/landsat_data'; % Load image data
[nrows,ncols] = size(landsat_data,[1 2]); % Size (rows x cols) of data
%imtool(landsat_data(:,:,[6,4,1])./255);
%6,4,1 good combination

% Create training areas using rectangle coordinates
training_labels = zeros(nrows,ncols); % Create an empty image of size equals of data
training_labels(485:510,20:60) = 1; % Class 1: Water
training_labels(285:288,99) = 1; % Class 1: Water
training_labels(289:291,100) = 1; % Class 1: Water
training_labels(241:245,82) = 1; % Class 1: Water
training_labels(255:265,300:340) = 2; % Class 2: Agricultural area
training_labels(45:70,338:363) = 3; % Class 3: Forest
training_labels(210:215,100:108) = 4; % Class 4: Urban Areas
training_labels(286:289,239) = 5; % Class 5: Roads
training_labels(354:359,281) = 5; % Class 5: Roads

% Separate the seven bands
B1 = landsat_data(:,:,1);
B2 = landsat_data(:,:,2);
B3 = landsat_data(:,:,3);
B4 = landsat_data(:,:,4);
B5 = landsat_data(:,:,5);
B6 = landsat_data(:,:,6);
B7 = landsat_data(:,:,7);

% figure();imshow(B1,[]);
% figure();imshow(B2,[]);
% figure();imshow(B3,[]);
% figure();imshow(B4,[]);
% figure();imshow(B5,[]);
% figure();imshow(B6,[]);
% figure();imshow(B7,[]);

% Create an image with three bands/features
bands_145_image(:,:,1) = B1;
bands_145_image(:,:,2) = B4;
bands_145_image(:,:,3) = B5;

[data,class] = create_training_data(bands_145_image,training_labels); % Arrange the training data into vectors
Itest = im2testdata(bands_145_image); % Reshape the image before classification
%classifier = classify(double(Itest),double(data),double(class)); % Train classifier and classify the data
classifier = classify(double(Itest),double(data),double(class),'quadratic'); % Train classifier and classify the data
ImClassifier_gr = class2im(classifier,size(bands_145_image,1),size(bands_145_image,2)); % Reshape the classification to an image
figure(); imagesc(ImClassifier_gr); title('Band 1 + Band 4 + Band 5 Classification'); % View the classification result

[data,class] = create_training_data(landsat_data,training_labels); % Arrange the training data into vectors
Itest = im2testdata(landsat_data); % Reshape the image before classification
%classifier = classify(double(Itest),double(data),double(class)); % Train classifier and classify the data
classifier = classify(double(Itest),double(data),double(class),'quadratic');% Train classifier and classify the data
ImClassifier_gr = class2im(classifier,size(landsat_data,1),size(landsat_data,2)); % Reshape the classification to an image
figure(); imagesc(ImClassifier_gr); title('Full Bands Classification'); % View the classification result
