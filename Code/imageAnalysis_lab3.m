%% Question 1 - Question 3

original = imread('images/coins.tif'); %Open the original image.
median = medfilt2(original,[3 3],'symmetric'); %Remove possible noise.

%Compute adequate thresholding value and apply to the original image. Output image has black foreground and white background (binary image).
T = graythresh(median);
binary = imbinarize(median,T);

%Calculate the distance transform of the complement of the binary image. Complement of the distance transformed for the watershed transform:
%light pixels -> high elevations, dark pixels -> low elevations. Pixels outside the region of interest are set to 0.
distanceT = bwdist(binary,'cityblock');
neg_distanceT = -distanceT;
watersheded = watershed(neg_distanceT);
watersheded(~distanceT) = 0;

%Labelling the watershed transf. with 8-neighbours and eroding for better identification of ROIs.
labelled = bwlabel(watersheded,8);
segmented = bwmorph(labelled, 'erode');

%Find local maxima of each ROI and map with values from distance transf. + paint similar regions (radius) with similar colours.
maxima = bwmorph(imextendedmax(distanceT,1), 'shrink', Inf);
CH = regionprops(segmented, 'ConvexHull');
[nrows, ncols] = size(maxima);
maxima = uint8(maxima);
segmented = uint8(segmented);
for row = 1:nrows
    for col = 1:ncols
        if maxima(row,col) == 1
            maxima(row,col) = distanceT(row,col);
        end
        if segmented(row,col) > 0 && maxima(row,col) > 0
            segmented(row,col) = maxima(row,col);
        end
    end
end
for index = 1:length(CH)
    roi = roipoly(segmented, CH(index).ConvexHull(:,1), CH(index).ConvexHull(:,2));
    segmented(roi) = max(segmented(roi));
end

%Extract the Area features from the labelled image and set up bins for the histogram.
F = regionprops(labelled, 'Area');
A = [F.Area];
bins = [];
for boundaries = 400:100:2600
    bins = [bins boundaries];
end
figure, imshow(label2rgb(segmented)); title('Segmented Image')
figure, histogram(A,bins); xlabel('area mesured in pixels'); ylabel('number of objects');

%% Question 7

original = imread('images/bacteria.tif'); %Open the original image.
median = medfilt2(original,[3 3],'symmetric'); %Remove possible noise.

%Compute adequate thresholding value and apply to the original image. Output image has black foreground and white background (binary image).
T = graythresh(median);
binary = imbinarize(median,T);

se = strel('disk',7);
closed = imclose(binary,se);

%Calculate the distance transform of the complement of the binary image. Complement of the distance transformed for the watershed transform:
%light pixels -> high elevations, dark pixels -> low elevations. Pixels outside the region of interest are set to 0.
distanceT = bwdist(closed,'cityblock');
neg_distanceT = -distanceT;
watersheded = watershed(neg_distanceT);
watersheded(~distanceT) = 0;

%Labelling the watershed transf. with 8-neighbours and eroding for better identification of ROIs.
labelled = bwlabel(watersheded,8);
segmented = bwmorph(labelled, 'open');

%Find local maxima of each ROI and map with values from distance transf. + paint similar regions (radius) with similar colours.
maxima = bwmorph(imextendedmax(distanceT,1), 'shrink', Inf);
CH = regionprops(segmented, 'ConvexHull');
[nrows, ncols] = size(maxima);
maxima = uint8(maxima);
segmented = uint8(segmented);
for row = 1:nrows
    for col = 1:ncols
        if maxima(row,col) == 1
            maxima(row,col) = distanceT(row,col);
        end
        if segmented(row,col) > 0 && maxima(row,col) > 0
            segmented(row,col) = maxima(row,col);
        end
    end
end
for index = 1:length(CH)
    roi = roipoly(segmented, CH(index).ConvexHull(:,1), CH(index).ConvexHull(:,2));
    segmented(roi) = max(segmented(roi));
end

%Extract the Area features from the labelled image and set up bins for the histogram.
F = regionprops(labelled, 'Area');
A = [F.Area];
bins = [];
for boundaries = 400:100:2600
    bins = [bins boundaries];
end
figure, imshow(label2rgb(segmented)); title('Segmented Image')
figure, histogram(A,bins); xlabel('area mesured in pixels'); ylabel('number of objects');